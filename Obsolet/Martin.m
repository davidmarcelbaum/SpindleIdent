params.fpass    = [1 35]; 
params.Fs       = s_fs; 
params.tapers   = [5 9]; 
params.trialave = 0; 
params.err      = 0; 

% For every channel, save frequency peaks
sizeWindow  = 5000; 
dataOn      = squeeze(Data_SS(:,5001:15000,:));
dataOff      = squeeze(Data_SS(:,15001:25000,:));


[offS,offFreq]    = mtspectrumc(dataOn, params); 
[onS,onFreq]     = mtspectrumc(dataOff, params); 
% 
% offS = median(offS,2); 
% onS  = median(onS,2); 

[~,fmin] = min(abs(onFreq-7)); 
[~,fmax] = min(abs(onFreq-16)); 

[peaks, peaksLoc] = findpeaks(pow2db(onS(fmin:fmax,1)));
[~,maxPeak] = max(peaks); 
maxPeakLoc  = peaksLoc(maxPeak);

maxPeakFreq    = onFreq(fmin+maxPeakLoc); 


for t = 1:size(offS,2)

hold on; 
plot(offFreq,pow2db(offS(:,t)), 'LineWidth', 1, 'Color', 'b'); hold on;
plot(onFreq,pow2db(onS(:,t)), 'LineWidth', 1, 'Color', 'r'); 
xlabel('frequency (Hz)'); 
ylabel('power(dB)'); 
title(['trial ', num2str(t)]);
%legend({'odor off', 'odor on'})
end 