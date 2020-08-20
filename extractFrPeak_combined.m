params.fpass    = [1 35];
params.Fs       = subjectPSD.Srate;
params.tapers   = [5 9];
params.trialave = 0;
params.err      = 0;

params.edgesSpin = [7, 16];
params.sepSpin = 11;


% For every channel, save frequency peaks
sizeWindow  = 500;

%% VERIFY:
%  Why POST-odor vectors and not OdorOn and ShamOn?
%  Why Sham and Odor separated?

if strcmp(str_triggers, 'switchedOFF_switchedON')
    
    data_postOdor  = ...
        [Data_SS(:, ...
        size(Data_SS,2) / 2 + 15 * subjectPSD.Srate + 1 : size(Data_SS,2), ...
        :), ...
        Data_SS(:, ...
        1:size(Data_SS,2)/2 - 15 * subjectPSD.Srate, ...
        :)];
    
    data_postSham = ...
        Data_SS(:, ...
        15 * subjectPSD.Srate + 1 : size(Data_SS,2) / 2 + 15 * subjectPSD.Srate, ...
        :);
    
elseif strcmp(str_triggers, 'switchedON_switchedOFF')
    
    data_postOdor = Data_SS(:, ...
        size(Data_SS,2) / 2 + 1 : size(Data_SS,2), ...
        :);
    
    data_postSham = Data_SS(:, ...
        1 : size(Data_SS,2) / 2, ...
        :);
    
end

data_postOdor      = squeeze(data_postOdor(:,1:end,:));
data_postSham     = squeeze(data_postSham(:,1:end,:));


%% ----- For total Spindle range -----

% ---------- Post-Odor phase ----------
[subjectPSD.(str_subj).(str_SS).MaxSpindle_Odor] = ...
    f_get_frPeak(data_postOdor, params, params.edgesSpin(1), params.edgesSpin(2));

% ---------- Post-Sham phase -----------
[subjectPSD.(str_subj).(str_SS).MaxSpindle_Sham] = ...
    f_get_frPeak(data_postSham, params, params.edgesSpin(1), params.edgesSpin(2));


%% ----- For slow Spindle range -----

% ---------- Post-Odor phase ----------
[subjectPSD.(str_subj).(str_SS).MaxFastSpindle_Odor] = ...
    f_get_frPeak(data_postOdor, params, params.edgesSpin(1), params.sepSpin);

% ---------- Post-Sham phase -----------
[subjectPSD.(str_subj).(str_SS).MaxFastSpindle_Sham] = ...
    f_get_frPeak(data_postSham, params, params.edgesSpin(1), params.sepSpin);


%% ------ For fast Spindle range -----

% ---------- Post-Odor phase ----------
[subjectPSD.(str_subj).(str_SS).MaxSlowSpindle_Odor] = ...
    f_get_frPeak(data_postOdor, params, params.sepSpin, params.edgesSpin(2));

% ---------- Post-Sham phase -----------
[subjectPSD.(str_subj).(str_SS).MaxSlowSpindle_Sham] = ...
    f_get_frPeak(data_postSham, params, params.sepSpin, params.edgesSpin(2));


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