%% Create a Files List in order to go through them for the analysis
if ~exist('pathData','var') || size(pathData,2) < 3
    
    % path to datasets containing channel data
    pathData = [uigetdir(cd,...
        'Locate folder of CHANNEL datasets'), filesep];
    addpath(pathData)
    FilesList = dir([pathData,'*.mat']);
    
end



%% Select which areas to compare
run p_determine_ROIs.m


%% Loading Odor sets into memory

fprintf('<!> Running datasets ...\n')

for Load2Mem = 1:numel(FilesList)
    
    fprintf('<!> subject %s (%d/%d)\n', ...
        FilesList(Load2Mem).name, Load2Mem, numel(FilesList));
    
    
    str_subj = extractBefore(FilesList(Load2Mem).name, '.mat');
    
    
    tmp_data = load([pathData FilesList(Load2Mem).name]);
    
    
    try
        
        tmp_data = tmp_data.Channel;
        
    catch ME
        
        if strcmp(ME.message, "Reference to non-existent field 'Channel'.")
            
            tmp_data = tmp_data;
            
        end
        
        
    end
    
    
    if Load2Mem == 1
        
        subjectPSD.Ori = pathData;
        subjectPSD.str_SS = str_SS_all;
        subjectPSD.Srate = tmp_data.Srate;
        subjectPSD.Times = tmp_data.Times;
        subjectPSD.TrialEnd = tmp_data.TrialEnd;
        subjectPSD.TrialStart = tmp_data.TrialStart;
        
    end
    
    
    v_ROI_SS = find(strcmp(tmp_data.Labels(:,:),indx_SS));
    
    subjectPSD.(str_subj).Data = tmp_data.Data(indx_SS,:,:);
    
    
    clear tmp_data
    
    
    
    for s_SS = 1:numel(indx_SS)
        
        str_SS = char(subjectPSD.str_SS(s_SS));
        
        Data_SS = subjectPSD.(str_subj).Data(s_SS,:,:);
        
        
        % Get the peak in PSD of spindle frequency range (7 to 16 Hz)
        run extractFrPeak_initial.m
        
        
    end
    
    subjectPSD.(str_subj) = rmfield(subjectPSD.(str_subj), 'Data');
   

end

clear data_struct


whos
save([pathData, 'Subject_PSDPeaks.mat'], 'subjectPSD', '-V7.3')
    
    
    
    
    
    
    