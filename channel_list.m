% [    1,    2,    3,    4,    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,   20, 
A={'NaN','NaN','NaN','NaN','NaN','NaN','NaN','NaN','Fp2','NaN','Fz','NaN','NaN','NaN','NaN','NaN','NaN','NaN','NaN','NaN'};

%     21,   22,   23,   24,   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,   35,   36,   37,   38,   39,   40, 
B={'NaN', 'Fp1','NaN','F3','NaN','NaN','NaN','NaN','NaN','NaN','NaN','NaN', 'F7','NaN','NaN', 'C3','NaN','NaN','NaN','NaN'};

%     41,   42,   43,   44,   45,   46,   47,   48,   49,   50,   51,   52,   53,   54,   55,   56,   57,   58,   59,   60, 
C={'NaN','NaN','NaN','NaN', 'T3','NaN','NaN','NaN','NaN','NaN','NaN', 'P3','NaN','NaN','NaN','NaN', 'LM', 'T5','NaN','NaN'};

%     61,   62,   63,   64,   65,   66,   67,   68,   69,   70,   71,   72,   73,   74,   75,   76,   77,   78,   79,   80, 
D={'NaN', 'Pz','NaN','NaN','NaN','NaN','NaN','NaN','NaN', 'O1','NaN','NaN','NaN','NaN', 'Oz','NaN','NaN','NaN','NaN','NaN'};

%     81,   82,   83,   84,   85,   86,   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,   97,   98,   99,  100,
E={'NaN','NaN', 'O2','NaN','NaN','NaN','NaN','NaN','NaN','NaN','NaN', 'P4','NaN','NaN','NaN', 'T6','NaN','NaN','NaN', 'RM'};

%    101,  102,  103,  104,  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
F={'NaN','NaN','NaN', 'C4','NaN','NaN','NaN', 'T4','NaN','NaN','NaN','NaN','NaN','NaN','NaN','NaN','NaN','NaN','NaN','NaN'};

%    121,  122,  123,  124,  125,  126,  127,  128]
G={'NaN', 'F8','NaN', 'F4','NaN','NaN','NaN','NaN'};

c_chans = [A, B, C, D, E, F, G];

clear A B C D E F G

get_chans = find(~strcmp(c_chans,'NaN'));