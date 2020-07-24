if ~exist('FileTemp', 'var')
    
    if exist('FilesList', 'var')
        FileTemp = load(FilesList(1).name);
    else
        FileTemp = load(FilesListSham(1).name);
    end
    
end

try
    Sources = FileTemp.Labels';
catch
    Sources = FileTemp.Channel.Labels;
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
run('D:\Gits\EEG_channels\channel_list_128_Channel_HCGSN58.m')

str_SS_all = Sources(ismember(Sources, get_names_generic));
idx_SS = find(ismember(Sources, get_names_generic));