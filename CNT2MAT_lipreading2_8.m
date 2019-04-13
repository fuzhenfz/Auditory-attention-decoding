% extract EEG from raw CNT files and convert to MAT format for further
% utilizing. All pre-prossing procedures are applied.
clear
clc

SubjectNames = {'lr','dyf','nyd','wyw','cgf','pc','lx','cjx','lxy','dyf2','qy','gzs','syf','lj','hql','wyy','cjf'};

%% lr

SubjectName = 'lr';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
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
    % FC3 = 17, CP5 = 35, C4 = 30
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '/'];
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



%% dyf

SubjectName = 'dyf';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
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
    % FP1 = 1, FP2 = 3, FPZ = 2, FC3 = 17, CP5 = 35, C4 = 30
    EEG = pop_interp(EEG, [1 2 3 17 35], 'spherical');
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '/'];
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

%% nyd

SubjectName = 'nyd';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
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
    % FC3 = 17, CP5 = 35, C4 = 30
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '/'];
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

%% wyw

SubjectName = 'wyw';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
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
    % FP1 = 1, FP2 = 3, FPZ = 2, FC3 = 17, CP5 = 35, C4 = 30
    EEG = pop_interp(EEG, [2 17 35], 'spherical');
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '/'];
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


%% cgf

SubjectName = 'cgf';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
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
    % FC3 = 17, CP5 = 35, C4 = 30
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '/'];
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

%% wyw 2, with more electrodes were interpolated

SubjectName = 'wyw';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
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
    %     FP1 = 1, FP2 = 3, FPZ = 2, FC3 = 17, CP5 = 35, C4 = 30, TP7 = 34, FC5 = 16, FT7 = 15
    EEG = pop_interp(EEG, [2 15 16 17 34 35], 'spherical');
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '2/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '2/'];
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

%% cgf 2, with more electrodes were interpolated

SubjectName = 'cgf';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
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
    % FC3 = 17, CP5 = 35, C4 = 30, FCZ = 19, CZ = 28, FZ = 10
    EEG = pop_interp(EEG, [10 19 28 30], 'spherical');
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '2/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '2/'];
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

%% pc

SubjectName = 'pc';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
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
    % FC3 = 17, CP5 = 35, C4 = 30, T7 = 24
    EEG = pop_interp(EEG, [24 30], 'spherical');
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '/'];
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

%% lx

SubjectName = 'lx';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
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
    % FC3 = 17, CP5 = 35, C4 = 30, T7 = 24
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '/'];
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

%% cjx

SubjectName = 'cjx';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
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
    % FP1 = 1, FP2 = 3, FPZ = 2, FC3 = 17, CP5 = 35, C4 = 30
    EEG = pop_interp(EEG,[17], 'spherical');
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '/'];
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

%% lxy

SubjectName = 'lxy';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
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
    % FC3 = 17, CP5 = 35, C4 = 30, T7 = 24
    EEG = pop_interp(EEG, [24 30], 'spherical');
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '/'];
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

%% dyf2

SubjectName = 'dyf2';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
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
    % FC3 = 17, CP5 = 35, C4 = 30, T7 = 24, F8 = 14
    EEG = pop_interp(EEG, [3 14 24 30], 'spherical');
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '/'];
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

%% qy

SubjectName = 'qy';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
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
    % Fp1 = 1, FPZ = 2, C4 = 30, T8 = 32
    EEG = pop_interp(EEG, [1 2 30 32], 'spherical');
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '/'];
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

%% gzs

SubjectName = 'gzs';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
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
    % Fp1 = 1, FPZ = 2, C4 = 30, T8 = 32
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '/'];
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

%% syf

SubjectName = 'syf';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
dirOutput = dir(fullfile(CNTFilePath,'*'));
fileNames = {dirOutput.name}';
fileNumber = length(fileNames);

for i0=36:36
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
    % FPZ = 2, FC3 = 17, CP5 = 35, T7 = 24, TP7 = 34, TP8 = 42
    EEG = pop_interp(EEG, [2 17 24 34 35 42], 'spherical');
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '/'];
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

%% lj

SubjectName = 'lj';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
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
    % Fp1 = 1, FPZ = 2, C4 = 30, T8 = 32
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '/'];
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

%% hql

SubjectName = 'hql';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
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
    % Fp1 = 1, FPZ = 2, C4 = 30, T8 = 32
    EEG = pop_interp(EEG, [30 32], 'spherical');
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '/'];
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

%% wyy

SubjectName = 'wyy';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
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
    % Fp1 = 1, FPZ = 2, C4 = 30, T8 = 32, TP7 = 34
    EEG = pop_interp(EEG, [30 34], 'spherical');
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '/'];
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

%% cjf

SubjectName = 'cjf';
CNTFilePath = ['K:\attention\lipreading\data\' SubjectName '/'];
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
    % Fp1 = 1, FPZ = 2, C4 = 30, T8 = 32, TP7 = 34
    EEG = pop_interp(EEG, [32], 'spherical');
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
    % ICA
    EEG = pop_runica(EEG, 'extended',1,'interupt','on');
    EEG = eeg_checkset( EEG );
    MATFilePath = ['D:\ѧϰ\experiment\attention_lipreading\data\EEGData\' SubjectName '/'];
    if exist(MATFilePath,'dir')==0, mkdir(MATFilePath); end
    ReportFile = [MATFilePath strrep(fileNames{i0},'.cnt','.txt')];
    [~,~,~,~,horiz,vert,blink,disc] = MY_pop_ADJUST_interface(EEG,EEG,1,ReportFile);
    
    ICAPath = ['D:\ѧϰ\experiment\attention_lipreading\data\ICA\' SubjectName '/'];
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

