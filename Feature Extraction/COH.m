% Feature extraction script for COH

% construct filters
filt_beta = fir1(3*fix(160/12), [12, 30]/80);
filt_gamma = fir1(3*fix(160/30), [30, 45]/80);

EO = zeros(109, 6, 64, 2);
EC = zeros(109, 6, 64, 2);

cum = cumsum(flip(1:63));
cum = [0, cum(1:end-1)];
for S_i = 1:109
    for s_i = 1:6
        
        % Eyes Open
        % beta band
        anal_beta = hilbert(filtfilt(filt_beta, 1, squeeze(PREPROCDAT.EO(S_i, s_i, :, :))'));
        autospec_beta = mean(anal_beta.*conj(anal_beta), 1);
        for e_i = 1:63
            for e_j = e_i+1:64
                crossspec = mean(anal_beta(:, e_i).*conj(anal_beta(:, e_j)), 1);
                EO(S_i, s_i, cum(e_i)+e_j-e_i, 1) = abs(crossspec)^2 ...
                                                  /(autospec_beta(e_i)*autospec_beta(e_j));
            end
        end
        % gamma band
        anal_gamma = hilbert(filtfilt(filt_gamma, 1, squeeze(PREPROCDAT.EO(S_i, s_i, :, :))'));
        autospec_gamma = mean(anal_gamma.*conj(anal_gamma), 1);
        for e_i = 1:63
            for e_j = e_i+1:64
                crossspec = mean(anal_gamma(:, e_i).*conj(anal_gamma(:, e_j)), 1);
                EO(S_i, s_i, cum(e_i)+e_j-e_i, 2) = abs(crossspec)^2 ...
                                                  /(autospec_gamma(e_i)*autospec_gamma(e_j));
            end
        end
        
        
        % Eyes Close
        % beta band
        anal_beta = hilbert(filtfilt(filt_beta, 1, squeeze(PREPROCDAT.EC(S_i, s_i, :, :))'));
        autospec_beta = mean(anal_beta.*conj(anal_beta), 1);
        for e_i = 1:63
            for e_j = e_i+1:64
                crossspec = mean(anal_beta(:, e_i).*conj(anal_beta(:, e_j)), 1);
                EC(S_i, s_i, cum(e_i)+e_j-e_i, 1) = abs(crossspec)^2 ...
                                                  /(autospec_beta(e_i)*autospec_beta(e_j));
            end
        end
        % gamma band
        anal_gamma = hilbert(filtfilt(filt_gamma, 1, squeeze(PREPROCDAT.EC(S_i, s_i, :, :))'));
        autospec_gamma = mean(anal_gamma.*conj(anal_gamma), 1);
        for e_i = 1:63
            for e_j = e_i+1:64
                crossspec = mean(anal_gamma(:, e_i).*conj(anal_gamma(:, e_j)), 1);
                EC(S_i, s_i, cum(e_i)+e_j-e_i, 2) = abs(crossspec)^2 ...
                                                  /(autospec_gamma(e_i)*autospec_gamma(e_j));
            end
        end
    end
    
    disp(['Subject ' num2str(S_i) ' processed.'])
end
save COH EO EC