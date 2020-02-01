params.fpass    = [1 35];
params.Fs       = subjectPSD.Srate;
params.tapers   = [5 9];
params.trialave = 0;
params.err      = 0;

params.edgesSpin = [7, 16];
params.sepSpin = 11;


% For every channel, save frequency peaks
sizeWindow  = 500;

data_postCue      = ...
    [Data_SS(:, size(Data_SS,2) / 2 + 15 * subjectPSD.Srate + 1 : size(Data_SS,2) ,:), ...
    Data_SS(:, 1:size(Data_SS,2)/2 - 15*subjectPSD.Srate ,:)];

data_postSham      = ...
    Data_SS(:, 15 * subjectPSD.Srate + 1 : size(Data_SS,2) / 2 + 15 * subjectPSD.Srate ,:);

data_postCue      = squeeze(data_postCue(:,1:end,:));
data_postSham     = squeeze(data_postSham(:,1:end,:));


%% ----- For total Spindle range -----

% ---------- Post-Cue phase ----------

% Get PSD of off period in trial
[CueS,CueFreq]    = mtspectrumc(data_postCue, params); 

% Get all frequency points in frequency range of interest
highpass = CueFreq(CueFreq > params.edgesSpin(1));
lowpass = CueFreq(CueFreq < params.edgesSpin(2));

% Get edge points of frequency ranges
minEdge = CueFreq(CueFreq == highpass(1));
maxEdge = CueFreq(CueFreq == lowpass(end));

% Build vector of frequency span (Seemed useful when I coded it but seems
% unused...)
% FreqPts = offFreq(find(offFreq == minEdge):find(offFreq == maxEdge));

% Get power values inside frequency range and identify peaks
CueS_span = CueS(find(CueFreq == minEdge):find(CueFreq == maxEdge));

peaks = findpeaks(CueS_span);

% Get value and location of max peak
maxpeakVal = max(CueS_span(peaks.loc));

find_pos = find(CueS == maxpeakVal);
maxpeakLoc = CueFreq(find_pos(1));

subjectPSD.(str_subj).(str_SS).MaxSpindle_Cue = maxpeakLoc;


% ---------- Post-Sham phase -----------
[ShamS,ShamFreq]     = mtspectrumc(data_postSham, params);


highpass = ShamFreq(ShamFreq > params.edgesSpin(1));
lowpass = ShamFreq(ShamFreq < params.edgesSpin(2));

minEdge = ShamFreq(ShamFreq == highpass(1));
maxEdge = ShamFreq(ShamFreq == lowpass(end));

% FreqPts = offFreq(find(onFreq == minEdge):find(onFreq == maxEdge));

onS_span = ShamS(find(ShamFreq == minEdge):find(ShamFreq == maxEdge));

peaks = findpeaks(onS_span);

% Get value of max peak and location
maxpeakVal = max(onS_span(peaks.loc));

find_pos = find(ShamS == maxpeakVal);
maxpeakLoc = ShamFreq(find_pos(1));

subjectPSD.(str_subj).(str_SS).MaxSpindle_Sham = maxpeakLoc;



%% ----- For slow Spindle range -----

% ---------- Post-Cue phase ----------
[CueS,CueFreq]    = mtspectrumc(data_postCue, params); 


highpass = CueFreq(CueFreq > params.edgesSpin(1));
lowpass = CueFreq(CueFreq < params.sepSpin);

% Get edge points of frequency ranges
minEdge = CueFreq(CueFreq == highpass(1));
maxEdge = CueFreq(CueFreq == lowpass(end));

% Build vector of frequency span (Seemed useful when I coded it but seems
% unused...)
% FreqPts = offFreq(find(offFreq == minEdge):find(offFreq == maxEdge));

% Get power values inside frequency range and identify peaks
CueS_span = CueS(find(CueFreq == minEdge):find(CueFreq == maxEdge));

peaks = findpeaks(CueS_span);

% Get value and location of max peak
maxpeakVal = max(CueS_span(peaks.loc));

find_pos = find(CueS == maxpeakVal);
maxpeakLoc = CueFreq(find_pos(1));

subjectPSD.(str_subj).(str_SS).MaxSlowSpindle_Cue = maxpeakLoc;


% ---------- Post-Sham phase -----------
[ShamS,ShamFreq]     = mtspectrumc(data_postSham, params);


highpass = ShamFreq(ShamFreq > params.edgesSpin(1));
lowpass = ShamFreq(ShamFreq < params.sepSpin);

minEdge = ShamFreq(ShamFreq == highpass(1));
maxEdge = ShamFreq(ShamFreq == lowpass(end));

% FreqPts = offFreq(find(onFreq == minEdge):find(onFreq == maxEdge));

onS_span = ShamS(find(ShamFreq == minEdge):find(ShamFreq == maxEdge));

peaks = findpeaks(onS_span);

% Get value of max peak and location
maxpeakVal = max(onS_span(peaks.loc));

find_pos = find(ShamS == maxpeakVal);
maxpeakLoc = ShamFreq(find_pos(1));

subjectPSD.(str_subj).(str_SS).MaxSlowSpindle_Sham = maxpeakLoc;


%% ------ For fast Spindle range -----

% ---------- Post-Cue phase ----------
[CueS,CueFreq]    = mtspectrumc(data_postCue, params); 


highpass = CueFreq(CueFreq > params.sepSpin);
lowpass = CueFreq(CueFreq < params.edgesSpin(2));

minEdge = CueFreq(CueFreq == highpass(1));
maxEdge = CueFreq(CueFreq == lowpass(end));

% Build vector of frequency span (Seemed useful when I coded it but seems
% unused...)
% FreqPts = offFreq(find(offFreq == minEdge):find(offFreq == maxEdge));

% Get power values inside frequency range and identify peaks
CueS_span = CueS(find(CueFreq == minEdge):find(CueFreq == maxEdge));

peaks = findpeaks(CueS_span);

% Get value and location of max peak
maxpeakVal = max(CueS_span(peaks.loc));

find_pos = find(CueS == maxpeakVal);
maxpeakLoc = CueFreq(find_pos(1));

subjectPSD.(str_subj).(str_SS).MaxFastSpindle_Cue = maxpeakLoc;


% ---------- Post-Sham phase -----------
[ShamS,ShamFreq]     = mtspectrumc(data_postSham, params);


highpass = ShamFreq(ShamFreq > params.sepSpin);
lowpass = ShamFreq(ShamFreq < params.edgesSpin(2));

minEdge = ShamFreq(ShamFreq == highpass(1));
maxEdge = ShamFreq(ShamFreq == lowpass(end));

% FreqPts = offFreq(find(onFreq == minEdge):find(onFreq == maxEdge));

onS_span = ShamS(find(ShamFreq == minEdge):find(ShamFreq == maxEdge));

peaks = findpeaks(onS_span);

% Get value of max peak and location
maxpeakVal = max(onS_span(peaks.loc));

find_pos = find(ShamS == maxpeakVal);
maxpeakLoc = ShamFreq(find_pos(1));

subjectPSD.(str_subj).(str_SS).MaxFastSpindle_Sham = maxpeakLoc;



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