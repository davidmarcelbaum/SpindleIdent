% |===USER INPUT===|
chan_Mastoids       = {'E57', 'E100'};
chan_EOG            = {'E8', 'E14', 'E21', 'E25', 'E126', 'E127'};
chan_EMG            = {'E43', 'E120'};
chan_VREF           = {'E129'};
chan_Face           = {'E49', 'E48', 'E17', 'E128', 'E32', 'E1', ...
                        'E125', 'E119', 'E113'};
% |=END USER INPUT=| 


%% From PDF HCGSN58 128 channel system list
c_chans = {...
    'C3',   'C4',   'Cz',   'F3',   'F4',   'F7',   'F8',   'FP1',  ...
    'FP2',  'FPZ',  'FPZ',  'FPZ',  'FZ',   'O1',   'O2',   'P3',   ...
    'P4',   'T5-P7','T6-P8','AF3',  'AF4',  'AF7',  'AF8',  'AFZ',  ...
    'C1',   'C2',   'C5',   'C6',   'CP1',  'CP2',  'CP3',  'CP4',  ...
    'CP5',  'CP6',  'CPZ',  'F1',   'F10',  'F2',   'F5',   'F6',   ...
    'F9',   'FC1',  'FC2',  'FC3',  'FC4',  'FC5',  'FC6',  'FCZ',  ...
    'FT10', 'FT7',  'FT8',  'FT9',  'Oz',   'P1',   'P10',  'P2',   ...
    'P5',   'P6',   'P9',   'PO3',  'PO4',  'PO7',  'PO8',  'POZ',  ...
    'PZ',   'T10',  'T11',  'T12',  'T9',   'TP10', 'TP7',  'TP8',  ...
    'TP9'};


chanNum_HCGSN = [...
    36;     104;    129;    24;     124;    33;     122;    22;     ...
    9;      14;     21;     15;     11;     70;     83;     52;     ...
    92;     58;     96;     23;     3;      26;     2;      16;     ...
    30;     105;    41;     103;    37;     87;     42;     93;     ...
    47;     98;     55;     19;     1;      4;      27;     123;    ...
    32;     13;     112;    29;     111;    28;     117;    6;      ...
    121;    34;     116;    38;     75;     60;     95;     85;     ...
    51;     97;     64;     67;     77;     65;     90;     72;     ...
    62;     114;    45;     108;    44;     100;    46;     102;    ...
    57]';


%% Eliminate channels
chans2del   = str2double(extractAfter(...
    [chan_Mastoids, chan_EOG, chan_EMG, chan_VREF, chan_Face], 'E'));

pos2del     = find(ismember(chans2del, chanNum_HCGSN));
for i_del = numel(pos2del) : -1 : 1
    
    idx_del                 = find(...
        chanNum_HCGSN == chans2del(pos2del(i_del)));
    chanNum_HCGSN(idx_del)  = [];
    c_chans(idx_del)        = [];
    
end


%% Bring the channel label sequency in order based on sorting chanNum_HCGSN
chansOrdered = sort(chanNum_HCGSN);
for i_chan = 1 : numel(chansOrdered)
   
    pos_chan                = find(chanNum_HCGSN == chansOrdered(i_chan));
    c_chansOrdered(i_chan)  = c_chans(pos_chan);
    
end

get_names_generic   = strcat('E', string(num2cell(chansOrdered)));
get_names           = c_chansOrdered;
