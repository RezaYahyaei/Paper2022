% Feature extraction script for PSD

% construct filters
filt_beta = fir1(3*fix(160/12), [12, 30]/80);
filt_gamma = fir1(3*fix(160/30), [30, 45]/80);

EO = zeros(109, 6, 64, 2);
EC = zeros(109, 6, 64, 2);
for S_i = 1:109
    for s_i = 1:6
        
        % Eyes Open
        anal_beta = hilbert(filtfilt(filt_beta, 1, squeeze(PREPROCDAT.EO(S_i, s_i, :, :))'));
        EO(S_i, s_i, :, 1) = mean(anal_beta.*conj(anal_beta), 1);
        anal_gamma = hilbert(filtfilt(filt_gamma, 1, squeeze(PREPROCDAT.EO(S_i, s_i, :, :))'));
        EO(S_i, s_i, :, 2) = mean(anal_gamma.*conj(anal_gamma), 1);
        
        % Eyes Close
        anal_beta = hilbert(filtfilt(filt_beta, 1, squeeze(PREPROCDAT.EC(S_i, s_i, :, :))'));
        EC(S_i, s_i, :, 1) = mean(anal_beta.*conj(anal_beta), 1);
        anal_gamma = hilbert(filtfilt(filt_gamma, 1, squeeze(PREPROCDAT.EC(S_i, s_i, :, :))'));
        EC(S_i, s_i, :, 2) = mean(anal_gamma.*conj(anal_gamma), 1);
    end
    
    disp(['Subject ' num2str(S_i) ' processed.'])
end
save PSD EO EC