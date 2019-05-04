% extract EEG from raw CNT files and convert to MAT format for further
% utilizing. All pre-prossing procedures are applied.
clear
clc

SubjectName = 'lr';
CNTFilePath = ['.\data\' SubjectName '\'];
dirOutput = dir(fullfile(CNTFilePath,'*'));
fileNames = {dirOutput.name}';
fileNumber = length(fileNames);

for i0=3:fileNumber
    clear EEG horiz vert blink disc
    
    EEG.etc.eeglabvers = '14.1.1'; % this tracks which version of EEGLAB is being used, you may ignore it
    CNTFileName = [CNTFilePath fileNames{i0}];
    % load raw CNT
    EEG = pop_loadcnt(CNTFileName, 'dataformat', 'auto', 'memmapfile', '');
    EEG = eeg_checkset( EEG );
    % load electrodes information
    EEG = pop_chanedit(EEG, 'lookup',[cd '/plugins/dipfit2.3/standard_BESA/standard-10-5-cap385.elp']);
    EEG = eeg_checkset( EEG );
    % interpolate bad electrodes
    % C4 = 30
    EEG = pop_interp(EEG, [30], 'spherical');
    EEG = eeg_checkset( EEG );
    % delete unused electrodes
    EEG = pop_select( EEG,'nochannel',{'M1' 'M2' 'EKG' 'EMG'});
    EEG = eeg_checkset( EEG );
    % re-reference, except for VEoG/HEoG
    EEG = pop_reref( EEG, [],'exclude',[63 64] );
    EEG = eeg_checkset( EEG );
    % downsample from 500 to 64 Hz
    EEG = pop_resample( EEG, 64);
    EEG = eeg_checkset( EEG );
    % epoch from -1 to 60s relative to trigger
    EEG = pop_epoch( EEG, {  '255'  }, [-1  60], 'newname', 'CNT file resampled epochs', 'epochinfo', 'yes','eventindices',1);
    EEG = eeg_checkset( EEG );
    % baseline correction
    EEG = pop_rmbase( EEG, [-1000 59984.375]);
    EEG = eeg_checkset( EEG );
    % band-pass filtering, 2-8 Hz
    EEG = pop_eegfiltnew(EEG, 2,8,106,0,[],0);
    EEG = eeg_checkset( EEG );
    EEG = eeg_checkset( EEG );
    % ICA to identify eye blink/movement related EEG activity
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['.\data\EEGData\' SubjectName '\'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['.\data\ICA\' SubjectName '\'];
    if exist(ICAPath,'dir')==0, mkdir(ICAPath); end
    ICAConponentName1 = [ICAPath strrep(fileNames{i0},'.cnt','_(36-64).jpg')];
    ICAConponentName2 = [ICAPath strrep(fileNames{i0},'.cnt','_(1-35).jpg')];
    print('-djpeg',ICAConponentName1,'-r100');
    close
    print('-djpeg',ICAConponentName2,'-r100');
    close
    
    % remove eye movement/blink artifacts
    eyeArtifactNO = unique([horiz,vert,blink]);
    EEG = pop_subcomp( EEG, eyeArtifactNO, 0);
    EEG = eeg_checkset( EEG );
    save([MATFilePath strrep(fileNames{i0},'.cnt','.mat')],'EEG');
end
