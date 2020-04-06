params.fpass    = [1 35];
params.Fs       = subjectPSD.Srate;
params.tapers   = [5 9];
params.trialave = 0;
params.err      = 0;

params.edgesSpin = [7, 16];
params.sepSpin = 11;


% For every channel, save frequency peaks
sizeWindow  = 500;
dataOn      = squeeze(Data_SS(:,501:1500,:));
dataOff     = squeeze(Data_SS(:,1501:2500,:));


%% ----- For total Spindle range -----

% ------------ Off  phase ------------

% Get PSD of off period in trial
[offS,offFreq]    = mtspectrumc(dataOn, params); 

% Get all frequency points in frequency range of interest
highpass = offFreq(offFreq > params.edgesSpin(1));
lowpass = offFreq(offFreq < params.edgesSpin(2));

% Get edge points of frequency ranges
minEdge = offFreq(offFreq == highpass(1));
maxEdge = offFreq(offFreq == lowpass(end));

% Build vector of frequency span (Seemed useful when I coded it but seems
% unused...)
% FreqPts = offFreq(find(offFreq == minEdge):find(offFreq == maxEdge));

% Get power values inside frequency range and identify peaks
offS_span = offS(find(offFreq == minEdge):find(offFreq == maxEdge));

peaks = findpeaks(offS_span);

% Get value and location of max peak
maxpeakVal = max(offS_span(peaks.loc));
maxpeakLoc = offFreq(offS == maxpeakVal);

subjectPSD.(str_subj).(str_SS).MaxSpindle_Off = maxpeakLoc;


% ------------- On phase -------------
[onS,onFreq]     = mtspectrumc(dataOff, params);


highpass = onFreq(onFreq > params.edgesSpin(1));
lowpass = onFreq(onFreq < params.edgesSpin(2));

minEdge = onFreq(onFreq == highpass(1));
maxEdge = onFreq(onFreq == lowpass(end));

% FreqPts = offFreq(find(onFreq == minEdge):find(onFreq == maxEdge));

onS_span = onS(find(onFreq == minEdge):find(onFreq == maxEdge));

peaks = findpeaks(onS_span);

% Get value of max peak and location
maxpeakVal = max(onS_span(peaks.loc));
maxpeakLoc = onFreq(onS == maxpeakVal);

subjectPSD.(str_subj).(str_SS).MaxSpindle_On = maxpeakLoc;



%% ----- For slow Spindle range -----

% ------------ Off phase ------------
[offS,offFreq]    = mtspectrumc(dataOn, params); 


highpass = offFreq(offFreq > params.edgesSpin(1));
lowpass = offFreq(offFreq < params.sepSpin);

minEdge = offFreq(offFreq == highpass(1));
maxEdge = offFreq(offFreq == lowpass(end));

% FreqPts = offFreq(find(offFreq == minEdge):find(offFreq == maxEdge));

offS_span = offS(find(offFreq == minEdge):find(offFreq == maxEdge));

peaks = findpeaks(offS_span);

% Get value of max peak and location
maxpeakVal = max(offS_span(peaks.loc));
maxpeakLoc = offFreq(offS == maxpeakVal);

subjectPSD.(str_subj).(str_SS).MaxSlowSpindle_Off = maxpeakLoc;


% ------------- On phase -------------
[onS,onFreq]     = mtspectrumc(dataOff, params);


highpass = onFreq(onFreq > params.edgesSpin(1));
lowpass = onFreq(onFreq < params.sepSpin);

minEdge = onFreq(onFreq == highpass(1));
maxEdge = onFreq(onFreq == lowpass(end));

% FreqPts = offFreq(find(onFreq == minEdge):find(onFreq == maxEdge));

onS_span = onS(find(onFreq == minEdge):find(onFreq == maxEdge));

peaks = findpeaks(onS_span);

% Get value of max peak and location
maxpeakVal = max(onS_span(peaks.loc));
maxpeakLoc = onFreq(onS == maxpeakVal);

subjectPSD.(str_subj).(str_SS).MaxSlowSpindle_On = maxpeakLoc;



%% ------ For fast Spindle range -----

% ------------ Off  phase ------------
[offS,offFreq]    = mtspectrumc(dataOn, params); 


highpass = offFreq(offFreq > params.sepSpin);
lowpass = offFreq(offFreq < params.edgesSpin(2));

minEdge = offFreq(offFreq == highpass(1));
maxEdge = offFreq(offFreq == lowpass(end));

% FreqPts = offFreq(find(offFreq == minEdge):find(offFreq == maxEdge));

offS_span = offS(find(offFreq == minEdge):find(offFreq == maxEdge));

peaks = findpeaks(offS_span);

% Get value of max peak and location
maxpeakVal = max(offS_span(peaks.loc));
maxpeakLoc = offFreq(offS == maxpeakVal);

subjectPSD.(str_subj).(str_SS).MaxFastSpindle_Off = maxpeakLoc;


% ------------- On phase -------------
[onS,onFreq]     = mtspectrumc(dataOff, params);


highpass = onFreq(onFreq > params.sepSpin);
lowpass = onFreq(onFreq < params.edgesSpin(2));

minEdge = onFreq(onFreq == highpass(1));
maxEdge = onFreq(onFreq == lowpass(end));

% FreqPts = offFreq(find(onFreq == minEdge):find(onFreq == maxEdge));

onS_span = onS(find(onFreq == minEdge):find(onFreq == maxEdge));

peaks = findpeaks(onS_span);

% Get value of max peak and location
maxpeakVal = max(onS_span(peaks.loc));
maxpeakLoc = onFreq(onS == maxpeakVal);

subjectPSD.(str_subj).(str_SS).MaxFastSpindle_On = maxpeakLoc;



% for t = 1:size(offS,2)
%     
%     hold on;
%     plot(offFreq,pow2db(offS(:,t)), 'LineWidth', 0.5, 'Color', 'b'); hold on;
%     plot(onFreq,pow2db(onS(:,t)), 'LineWidth', 0.5, 'Color', 'r');
%     xlabel('frequency (Hz)');
%     ylabel('power (dB)');
%     legend({'odor off', 'odor on'})
%     
% end