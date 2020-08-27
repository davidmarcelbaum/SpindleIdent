params.fpass    = [1 35];
params.Fs       = subjectPSD.Srate;
params.tapers   = [5 9];
params.trialave = 0;
params.err      = 0;

params.edgesSpin = [7, 16];
params.sepSpin = 11;


if strcmp(str_triggers, 'switchedOFF_switchedON')
    data_Odor  = Data_SS_Odor(...
        size(Data_SS_Odor,1) / 2 + 1 : size(Data_SS_Odor,1), :);
    data_Sham = Data_SS_Sham(...
        size(Data_SS_Sham,1) / 2 + 1 : size(Data_SS_Sham,1), :);
elseif strcmp(str_triggers, 'switchedON_switchedOFF')
    data_Odor = Data_SS_Odor(...
        1 : size(Data_SS_Odor,1) / 2, :);
    data_Sham = Data_SS_Sham(...
        1 : size(Data_SS_Sham,1) / 2, :);
end


%% --- For total Spindle range ---

% ---------- Odor phase ----------
[subjectPSD.(str_subj).(str_SS).MaxSpindle_Odor] = ...
    f_get_frPeak(data_Odor, params, params.edgesSpin(1), params.edgesSpin(2));

% ---------- Sham phase ----------
[subjectPSD.(str_subj).(str_SS).MaxSpindle_Sham] = ...
    f_get_frPeak(data_Sham, params, params.edgesSpin(1), params.edgesSpin(2));


%% --- For slow Spindle range ---

% ---------- Odor phase ---------
[subjectPSD.(str_subj).(str_SS).MaxSlowSpindle_Odor] = ...
    f_get_frPeak(data_Odor, params, params.edgesSpin(1), params.sepSpin);

% ---------- Sham phase -----------
[subjectPSD.(str_subj).(str_SS).MaxSlowSpindle_Sham] = ...
    f_get_frPeak(data_Sham, params, params.edgesSpin(1), params.sepSpin);


%% ---- For fast Spindle range ---

% ---------- Odor phase ----------
[subjectPSD.(str_subj).(str_SS).MaxFastSpindle_Odor] = ...
    f_get_frPeak(data_Odor, params, params.sepSpin, params.edgesSpin(2));

% ---------- Sham phase ----------
[subjectPSD.(str_subj).(str_SS).MaxFastSpindle_Sham] = ...
    f_get_frPeak(data_Sham, params, params.sepSpin, params.edgesSpin(2));


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