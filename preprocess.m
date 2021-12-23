% Preprocess EEG signals script
% Subject EEG data are located at the current directory in folders
% of the format Sxxx

PREPROCDAT.EO = zeros(109, 6, 64, 1600);
PREPROCDAT.EC = zeros(109, 6, 64, 1600);

for S_i = 1:109
    
    sdir = num2str(S_i, '%03d');
    
    % Eyes Open
    [~, record] = edfread(['S' sdir '/S' sdir 'R01.edf']);
    
    % lowpass filter records and segment them into 6
    for s_i = 1:6
        PREPROCDAT.EO(S_i, s_i, :, :) = lowpass(record(1:64, (s_i-1)*1600+1:s_i*1600)', ...
                                             50, 160, 'ImpulseResponse', 'fir')';
    end
    
    
    % Eyes Close
    [~, record] = edfread(['S' sdir '/S' sdir 'R02.edf']);
    
    % lowpass filter records and segment them into 6
    for s_i = 1:6
        PREPROCDAT.EC(S_i, s_i, :, :) = lowpass(record(1:64, (s_i-1)*1600+1:s_i*1600)', ...
                                             50, 160, 'ImpulseResponse', 'fir')';
    end
    
    disp(['Subject ' num2str(S_i) ' preprocessed.'])
end