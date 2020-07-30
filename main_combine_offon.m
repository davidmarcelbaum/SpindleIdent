%% Create a Files List in order to go through them for the analysis
if ~exist('pathData','var') || size(pathData,2) < 3
    
    % path to datasets containing channel data
    pathData = [uigetdir(cd,...
        'Locate folder of CHANNEL datasets'), filesep];
    addpath(pathData)
    FilesListSham = dir([pathData,'*Sham*']);
    FilesListOdor = dir([pathData,'*Odor*']);
    
    if numel(FilesListSham) ~= numel(FilesListOdor)
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
    tmp_data_Odor = load([pathData FilesListOdor(Load2Mem).name]);
    
    try
        tmp_data_Sham = tmp_data_Sham.Channel;
        tmp_data_Odor = tmp_data_Odor.Channel;
    catch ME
        if strcmp(ME.message, "Reference to non-existent field 'Channel'.")
            tmp_data_Sham = tmp_data_Sham;
            tmp_data_Odor = tmp_data_Odor;
        end
    end
    
    if Load2Mem == 1
        subjectPSD.Ori          = pathData;
        subjectPSD.str_SS       = str_SS_all;
        subjectPSD.Srate        = tmp_data_Sham.Srate;
        subjectPSD.Times        = tmp_data_Sham.Times;
        subjectPSD.TrialEnd     = tmp_data_Sham.TrialEnd;
        subjectPSD.TrialStart   = tmp_data_Sham.TrialStart;
    end
    
    v_ROI_SS = find(strcmp(tmp_data_Sham.Labels(:,:), idx_SS));
    
    subjectPSD.(str_subj).Sham.Data = tmp_data_Sham.Data(idx_SS,:,:);
    subjectPSD.(str_subj).Odor.Data = tmp_data_Odor.Data(idx_SS,:,:);
    
    clear tmp_data
    
    if size(subjectPSD.(str_subj).Sham.Data, 3) > ...
            size(subjectPSD.(str_subj).Odor.Data, 3)
        
        subjectPSD.(str_subj).Sham.Data = ...
            subjectPSD.(str_subj).Sham.Data(:,:, ...
            1:size(subjectPSD.(str_subj).Odor.Data,3));
        
        warning('Removed Sham trials')
        
    elseif size(subjectPSD.(str_subj).Sham.Data, 3) < ...
            size(subjectPSD.(str_subj).Odor.Data, 3)
        
        subjectPSD.(str_subj).Odor.Data = ...
            subjectPSD.(str_subj).Odor.Data(:,:, ...
            1:size(subjectPSD.(str_subj).Sham.Data,3));
        
        warning('Removed Odor trials')
        
    end
    
    for s_SS = 1:numel(idx_SS)
        
        str_SS = char(subjectPSD.str_SS(s_SS));
        
        Data_SS_Sham = subjectPSD.(str_subj).Sham.Data(s_SS,:,:);
        Data_SS_Odor = subjectPSD.(str_subj).Odor.Data(s_SS,:,:);
        
        Data_SS = [Data_SS_Sham, Data_SS_Odor];
        
        % Get the peak in PSD of spindle frequency range (7 to 16 Hz)
        run extractFrPeak_combined.m
        
    end
    
    subjectPSD.(str_subj) = rmfield(subjectPSD.(str_subj), 'Sham');
    subjectPSD.(str_subj) = rmfield(subjectPSD.(str_subj), 'Odor');
   
end

clear data_struct

whos
save([pathData, 'Subject_PSDPeaks_combined.mat'], 'subjectPSD', '-V7.3')
    