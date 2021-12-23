% Feature extraction script for AP (aperiodic component of PSD)

% parameters
hanning = hann(320);
freqs = 0:0.5:80;
f_range = [1, 40];
settings.peak_width_limits = [1, 12];

EO = zeros(109, 6, 64, 2);
EC = zeros(109, 6, 64, 2);
for S_i = 1:109
    for s_i = 1:6
        
        % Eyes Open
        psd = pwelch(squeeze(PREPROCDAT.EO(S_i, s_i, :, :))', hanning, 160, 320);
        tmp = fooof_group(freqs, psd, f_range, settings);
        for e_i = 1:64
            EO(S_i, s_i, e_i, :) = tmp(e_i).aperiodic_params;
        end
        
        % Eyes Close
        psd = pwelch(squeeze(PREPROCDAT.EC(S_i, s_i, :, :))', hanning, 160, 320);
        tmp = fooof_group(freqs, psd, f_range, settings);
        for e_i = 1:64
            EC(S_i, s_i, e_i, :) = tmp(e_i).aperiodic_params;
        end
    end
    
    disp(['Subject ' num2str(S_i) ' processed.'])
end
save AP EO EC