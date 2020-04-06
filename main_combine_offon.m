%% Create a Files List in order to go through them for the analysis
if ~exist('pathData','var') || size(pathData,2) < 3
    
    % path to datasets containing channel data
    pathData = [uigetdir(cd,...
        'Locate folder of CHANNEL datasets'), filesep];
    addpath(pathData)
    FilesListSham = dir([pathData,'*Sham*']);
    FilesListCue = dir([pathData,'*Cue*']);
    
    
    if numel(FilesListSham) ~= numel(FilesListCue)
        
        error('Mismatch in number of datasets')
        
    end
    
    
end



%% Select which areas to compare
run p_determine_ROIs.m


%% Loading Odor sets into memory

fprintf('<!> Running datasets ...\n')

for Load2Mem = 1:numel(FilesListSham)
    
    
    str_subj = ...
        extractBefore(FilesListSham(Load2Mem).name, '_Sham');
    
    str_triggers = extractBetween(FilesListSham(Load2Mem).name, ...
        'Sham_', '.mat');
    
    
    fprintf('<!> subject %s (%d/%d)\n', ...
        str_subj, Load2Mem, numel(FilesListSham));
        
    
    tmp_data_Sham = load([pathData FilesListSham(Load2Mem).name]);
    tmp_data_Cue = load([pathData FilesListCue(Load2Mem).name]);
    
    
    try
        
        tmp_data_Sham = tmp_data_Sham.Channel;
        tmp_data_Cue = tmp_data_Cue.Channel;
        
    catch ME
        
        if strcmp(ME.message, "Reference to non-existent field 'Channel'.")
            
            tmp_data_Sham = tmp_data_Sham;
            tmp_data_Cue = tmp_data_Cue;
            
        end
        
        
    end
    
    
    if Load2Mem == 1
        
        subjectPSD.Ori = pathData;
        subjectPSD.str_SS = str_SS_all;
        subjectPSD.Srate = tmp_data_Sham.Srate;
        subjectPSD.Times = tmp_data_Sham.Times;
        subjectPSD.TrialEnd = tmp_data_Sham.TrialEnd;
        subjectPSD.TrialStart = tmp_data_Sham.TrialStart;
        
    end
    
    
    v_ROI_SS = find(strcmp(tmp_data_Sham.Labels(:,:), idx_SS));
    
    subjectPSD.(str_subj).Sham.Data = tmp_data_Sham.Data(idx_SS,:,:);
    subjectPSD.(str_subj).Cue.Data = tmp_data_Cue.Data(idx_SS,:,:);
    
    
    clear tmp_data
    
    
    if size(subjectPSD.(str_subj).Sham.Data, 3) > ...
            size(subjectPSD.(str_subj).Cue.Data, 3)
        
        subjectPSD.(str_subj).Sham.Data = ...
            subjectPSD.(str_subj).Sham.Data(:,:, ...
            1:size(subjectPSD.(str_subj).Cue.Data,3));
        
        warning('Removed Placebo trials')
        
    elseif size(subjectPSD.(str_subj).Sham.Data, 3) < ...
            size(subjectPSD.(str_subj).Cue.Data, 3)
        
        subjectPSD.(str_subj).Cue.Data = ...
            subjectPSD.(str_subj).Cue.Data(:,:, ...
            1:size(subjectPSD.(str_subj).Sham.Data,3));
        
        warning('Removed Odor trials')
        
    end
    
    
    
    for s_SS = 1:numel(idx_SS)
        
        
        str_SS = char(subjectPSD.str_SS(s_SS));
        
        Data_SS_Sham = subjectPSD.(str_subj).Sham.Data(s_SS,:,:);
        Data_SS_Cue = subjectPSD.(str_subj).Cue.Data(s_SS,:,:);
        
        
        
        Data_SS = [Data_SS_Sham, Data_SS_Cue];
        
        
        % Get the peak in PSD of spindle frequency range (7 to 16 Hz)
        run extractFrPeak_combined.m
        
        
    end
    
    subjectPSD.(str_subj).Sham = rmfield(subjectPSD.(str_subj).Sham, 'Data');
    subjectPSD.(str_subj).Cue = rmfield(subjectPSD.(str_subj).Cue, 'Data');
   

end

clear data_struct


whos
save([pathData, 'Subject_PSDPeaks_combined.mat'], 'subjectPSD', '-V7.3')
    
    
    
    
    
    
    