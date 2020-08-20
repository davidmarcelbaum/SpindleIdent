if ~exist('FileTemp', 'var')
    
    if exist('FilesList', 'var')
        FileTemp = load(FilesList(1).name);
    else
        FileTemp = load(FilesListSham(1).name);
    end
end

try
    ROIs.Sources = FileTemp.Labels';
catch
    ROIsSources = FileTemp.Channel.Labels;
end
% DMB: Soon to be changed: take out "Channel."

%% Uncomment for manual selection
%Asks for selection of a ROI to detect the Slow Oscillations
% [indx_SO] = listdlg('PromptString',...
%     'Select an origin of Slow Oscillations',...
%     'SelectionMode','multiple','ListSize',[400 400],...
%     'ListString',Sources(:,1));
% 
% %Asks for selection of a ROI to detect the Sleep Spindles
% [indx_SS] = listdlg('PromptString',...
%     'Select a channel: for Sleep Spindles',...
%     'SelectionMode','multiple','ListSize',[400 400],...
%     'ListString',Sources(:,1));

%% Get channels by strings and position in data

[ROIs.str_chans, ROIs.indx_chans, ROIs.str_chans_real] = ...
    f_get_HCGSN58_chans(ROIs.Sources, ...
    '/home/sleep/Documents/DAVID/GitHub/EEG_channels/channel_list_128_Channel_HCGSN58.m');

%% Compute all channels, event hose that don't have cortical namings

ROIs.str_sources = cell(numel(ROIs.Sources), 1);

for i_src = 1:numel(ROIs.str_sources)
   
    idx_hasName = find(strcmp(ROIs.str_chans, ROIs.Sources(i_src)));
    if isempty(idx_hasName)
        ROIs.str_sources(i_src) = ROIs.Sources(i_src);
    else
        ROIs.str_sources(i_src) = ROIs.str_chans_real(idx_hasName);
    end
    
end
ROIs.str_chans      = ROIs.Sources;
ROIs.str_chans_real = ROIs.str_sources;
ROIs.indx_chans     = [1:1:numel(ROIs.str_sources)]';