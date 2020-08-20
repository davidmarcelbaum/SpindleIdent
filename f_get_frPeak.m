function [maxpeakLoc] = f_get_frPeak(data_vector, params, highPassFr, lowPassFr)

[OdorS,OdorFreq]    = mtspectrumc(data_vector, params); 

% Get all frequency points in frequency range of interest
highpass = OdorFreq(OdorFreq > highPassFr);
lowpass = OdorFreq(OdorFreq < lowPassFr);

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


end