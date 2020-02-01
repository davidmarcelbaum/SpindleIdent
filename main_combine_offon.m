%% Create a Files List in order to go through them for the analysis
if ~exist('pathData','var') || size(pathData,2) < 3
    
    % path to datasets containing channel data
    pathData = [uigetdir(cd,...
        'Locate folder of CHANNEL datasets'), filesep];
    addpath(pathData)
    FilesListPlacebo = dir([pathData,'*Placebo*']);
    FilesListOdor = dir([pathData,'*Odor*']);
    
    
    if numel(FilesListPlacebo) ~= numel(FilesListOdor)
        
        error('Mismatch in number of datasets')
        
    end
    
    
end



%% Select which areas to compare
run p_determine_ROIs.m


%% Loading Odor sets into memory

fprintf('<!> Running datasets ...\n')

for Load2Mem = 1:numel(FilesListPlacebo)
    
    
    str_subj = ...
        extractBefore(FilesListPlacebo(Load2Mem).name, '_Placebo');
    
    
    fprintf('<!> subject %s (%d/%d)\n', ...
        str_subj, Load2Mem, numel(FilesListPlacebo));
        
    
    tmp_data_Placebo = load([pathData FilesListPlacebo(Load2Mem).name]);
    tmp_data_Odor = load([pathData FilesListOdor(Load2Mem).name]);
    
    
    try
        
        tmp_data_Placebo = tmp_data_Placebo.Channel;
        tmp_data_Odor = tmp_data_Odor.Channel;
        
    catch ME
        
        if strcmp(ME.message, "Reference to non-existent field 'Channel'.")
            
            tmp_data_Placebo = tmp_data_Placebo;
            tmp_data_Odor = tmp_data_Odor;
            
        end
        
        
    end
    
    
    if Load2Mem == 1
        
        subjectPSD.Ori = pathData;
        subjectPSD.str_SS = str_SS_all;
        subjectPSD.Srate = tmp_data_Placebo.Srate;
        subjectPSD.Times = tmp_data_Placebo.Times;
        subjectPSD.TrialEnd = tmp_data_Placebo.TrialEnd;
        subjectPSD.TrialStart = tmp_data_Placebo.TrialStart;
        
    end
    
    
    v_ROI_SS = find(strcmp(tmp_data_Placebo.Labels(:,:),indx_SS));
    
    subjectPSD.(str_subj).Placebo.Data = tmp_data_Placebo.Data(indx_SS,:,:);
    subjectPSD.(str_subj).Odor.Data = tmp_data_Odor.Data(indx_SS,:,:);
    
    
    clear tmp_data
    
    
    if size(subjectPSD.(str_subj).Placebo.Data, 3) > ...
            size(subjectPSD.(str_subj).Odor.Data, 3)
        
        subjectPSD.(str_subj).Placebo.Data = ...
            subjectPSD.(str_subj).Placebo.Data(:,:, ...
            1:size(subjectPSD.(str_subj).Odor.Data,3));
        
        warning('Removed Placebo trials')
        
    elseif size(subjectPSD.(str_subj).Placebo.Data, 3) < ...
            size(subjectPSD.(str_subj).Odor.Data, 3)
        
        subjectPSD.(str_subj).Odor.Data = ...
            subjectPSD.(str_subj).Odor.Data(:,:, ...
            1:size(subjectPSD.(str_subj).Placebo.Data,3));
        
        warning('Removed Odor trials')
        
    end
    
    
    
    for s_SS = 1:numel(indx_SS)
        
        
        str_SS = char(subjectPSD.str_SS(s_SS));
        
        Data_SS_Placebo = subjectPSD.(str_subj).Placebo.Data(s_SS,:,:);
        Data_SS_Odor = subjectPSD.(str_subj).Odor.Data(s_SS,:,:);
        
        
        
        Data_SS = [Data_SS_Placebo, Data_SS_Odor];
        
        
        % Get the peak in PSD of spindle frequency range (7 to 16 Hz)
        run extractFrPeak_combined.m
        
        
    end
    
    subjectPSD.(str_subj).Placebo = rmfield(subjectPSD.(str_subj).Placebo, 'Data');
    subjectPSD.(str_subj).Odor = rmfield(subjectPSD.(str_subj).Odor, 'Data');
   

end

clear data_struct


whos
save([pathData, 'Subject_PSDPeaks_combined.mat'], 'subjectPSD', '-V7.3')
    
    
    
    
    
    
    