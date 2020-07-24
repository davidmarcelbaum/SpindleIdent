params.fpass    = [1 35];
params.Fs       = subjectPSD.Srate;
params.tapers   = [5 9];
params.trialave = 0;
params.err      = 0;

params.edgesSpin = [7, 16];
params.sepSpin = 11;


% For every channel, save frequency peaks
sizeWindow  = 500;

if strcmp(str_triggers, 'switchedOFF_switchedON')
    
    data_postOdor  = ...
        [Data_SS(:, size(Data_SS,2) / 2 + 15 * subjectPSD.Srate + 1 : size(Data_SS,2), :), ...
        Data_SS(:, 1:size(Data_SS,2)/2 - 15 * subjectPSD.Srate, :)];
    
    data_postSham = ...
        Data_SS(:, 15 * subjectPSD.Srate + 1 : size(Data_SS,2) / 2 + 15 * subjectPSD.Srate, :);
    
elseif strcmp(str_triggers, 'switchedON_switchedOFF')
    
    data_postOdor  = Data_SS(:, size(Data_SS,2) / 2 + 1 : size(Data_SS,2), :);
    
    data_postSham = Data_SS(:, 1 : size(Data_SS,2) / 2, :);
    
end

data_postOdor      = squeeze(data_postOdor(:,1:end,:));
data_postSham     = squeeze(data_postSham(:,1:end,:));


%% ----- For total Spindle range -----

% ---------- Post-Odor phase ----------

% Get PSD of off period in trial
[OdorS,OdorFreq]    = mtspectrumc(data_postOdor, params); 

% Get all frequency points in frequency range of interest
highpass = OdorFreq(OdorFreq > params.edgesSpin(1));
lowpass = OdorFreq(OdorFreq < params.edgesSpin(2));

% Get edge points of frequency ranges
minEdge = OdorFreq(OdorFreq == highpass(1));
maxEdge = OdorFreq(OdorFreq == lowpass(end));

% Build vector of frequency span (Seemed useful when I coded it but seems
% unused...)
% FreqPts = offFreq(find(offFreq == minEdge):find(offFreq == maxEdge));

% Get power values inside frequency range and identify peaks
OdorS_span = OdorS(find(OdorFreq == minEdge):find(OdorFreq == maxEdge));

peaks = findpeaks(OdorS_span);

% Get value and location of max peak
maxpeakVal = max(OdorS_span(peaks.loc));

find_pos = find(OdorS == maxpeakVal);
maxpeakLoc = OdorFreq(find_pos(1));

subjectPSD.(str_subj).(str_SS).MaxSpindle_Odor = maxpeakLoc;


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

% ---------- Post-Odor phase ----------
[OdorS,OdorFreq]    = mtspectrumc(data_postOdor, params); 


highpass = OdorFreq(OdorFreq > params.edgesSpin(1));
lowpass = OdorFreq(OdorFreq < params.sepSpin);

% Get edge points of frequency ranges
minEdge = OdorFreq(OdorFreq == highpass(1));
maxEdge = OdorFreq(OdorFreq == lowpass(end));

% Build vector of frequency span (Seemed useful when I coded it but seems
% unused...)
% FreqPts = offFreq(find(offFreq == minEdge):find(offFreq == maxEdge));

% Get power values inside frequency range and identify peaks
OdorS_span = OdorS(find(OdorFreq == minEdge):find(OdorFreq == maxEdge));

peaks = findpeaks(OdorS_span);

% Get value and location of max peak
maxpeakVal = max(OdorS_span(peaks.loc));

find_pos = find(OdorS == maxpeakVal);
maxpeakLoc = OdorFreq(find_pos(1));

subjectPSD.(str_subj).(str_SS).MaxSlowSpindle_Odor = maxpeakLoc;


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

% ---------- Post-Odor phase ----------
[OdorS,OdorFreq]    = mtspectrumc(data_postOdor, params); 


highpass = OdorFreq(OdorFreq > params.sepSpin);
lowpass = OdorFreq(OdorFreq < params.edgesSpin(2));

minEdge = OdorFreq(OdorFreq == highpass(1));
maxEdge = OdorFreq(OdorFreq == lowpass(end));

% Build vector of frequency span (Seemed useful when I coded it but seems
% unused...)
% FreqPts = offFreq(find(offFreq == minEdge):find(offFreq == maxEdge));

% Get power values inside frequency range and identify peaks
OdorS_span = OdorS(find(OdorFreq == minEdge):find(OdorFreq == maxEdge));

peaks = findpeaks(OdorS_span);

% Get value and location of max peak
maxpeakVal = max(OdorS_span(peaks.loc));

find_pos = find(OdorS == maxpeakVal);
maxpeakLoc = OdorFreq(find_pos(1));

subjectPSD.(str_subj).(str_SS).MaxFastSpindle_Odor = maxpeakLoc;


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