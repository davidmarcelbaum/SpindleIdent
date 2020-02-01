if ~exist('FileTemp', 'var')
    
    try
        FileTemp = load(FilesList(1).name);
        
    catch ME
        
        if strcmp(ME.message, 'Undefined variable "FilesList" or class "FilesList".')
        
            FileTemp = load(FilesListPlacebo(1).name);
            
        end
            
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

%% Get channels
run channel_list.m

% indx_SO = get_chans;
indx_SS = get_chans;

% Get strings
% str_SO_all = Sources(indx_SO);
str_SS_all = Sources(indx_SS);