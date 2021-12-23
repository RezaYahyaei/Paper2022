% Feature extraction script for PLV

% construct filters
filt_beta = fir1(3*fix(160/12), [12, 30]/80);
filt_gamma = fir1(3*fix(160/30), [30, 45]/80);

EO = zeros(109, 6, 64*63/2, 2);
EC = zeros(109, 6, 64*63/2, 2);

cum = cumsum(flip(1:63));
cum = [0, cum(1:end-1)];
for S_i = 1:109
    for s_i = 1:6
        
        % Eyes Open
        % beta band
        ang_beta = angle(hilbert(filtfilt(filt_beta, 1, squeeze(PREPROCDAT.EO(S_i, s_i, :, :))')));
        for e_i = 1:63
            for e_j = e_i+1:64
                EO(S_i, s_i, cum(e_i)+e_j-e_i, 1) = ...
                    abs(mean(exp(1i*(ang_beta(:, e_i)-ang_beta(:, e_j)))));
            end
        end
        % gamma band
        ang_gamma = angle(hilbert(filtfilt(filt_gamma, 1, squeeze(PREPROCDAT.EO(S_i, s_i, :, :))')));
        for e_i = 1:63
            for e_j = e_i+1:64
                EO(S_i, s_i, cum(e_i)+e_j-e_i, 2) = ...
                    abs(mean(exp(1i*(ang_gamma(:, e_i)-ang_gamma(:, e_j)))));
            end
        end
        
        % Eyes Close
        % beta band
        ang_beta = angle(hilbert(filtfilt(filt_beta, 1, squeeze(PREPROCDAT.EC(S_i, s_i, :, :))')));
        for e_i = 1:63
            for e_j = e_i+1:64
                EC(S_i, s_i, cum(e_i)+e_j-e_i, 1) = ...
                    abs(mean(exp(1i*(ang_beta(:, e_i)-ang_beta(:, e_j)))));
            end
        end
        % gamma band
        ang_gamma = angle(hilbert(filtfilt(filt_gamma, 1, squeeze(PREPROCDAT.EC(S_i, s_i, :, :))')));
        for e_i = 1:63
            for e_j = e_i+1:64
                EC(S_i, s_i, cum(e_i)+e_j-e_i, 2) = ...
                    abs(mean(exp(1i*(ang_gamma(:, e_i)-ang_gamma(:, e_j)))));
            end
        end
    end
    
    disp(['Subject ' num2str(S_i) ' processed.'])
end
save PLV EO EC