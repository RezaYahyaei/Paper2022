% Feature extraction script for HM

kmax = 6; % k_max parameter
EO = zeros(109, 6, 64);
EC = zeros(109, 6, 64);
for S_i = 1:109
    
    % Eyes Open
    logk = log(1:kmax);
    logL = zeros(6, 64, kmax);
    for k = 1:kmax 
        l = zeros(6, 64, k);
        for m = 1:k
            s = floor((1600-m)/k);
            l(:, :, m) = squeeze(sum(abs(diff( ...
                                 PREPROCDAT.EO(S_i, :, :, m:k:m+s*k), ...
                                 1, 4)), 4)*(1600-1)/(s*k*k));
        end
        logL(:, :, k) = log(mean(l, 3));
    end
    for s_i = 1:6
        for e_i = 1:64
            a = polyfit(logk, squeeze(logL(s_i, e_i, :))', 1);
            EO(S_i, s_i, e_i) = -a(1);
        end
    end
    
    % Eyes Close
    logL = zeros(6, 64, kmax);
    for k = 1:kmax 
        l = zeros(6, 64, k);
        for m = 1:k
            s = floor((1600-m)/k);
            l(:, :, m) = squeeze(sum(abs(diff( ...
                                 PREPROCDAT.EC(S_i, :, :, m:k:m+s*k), ...
                                 1, 4)), 4)*(1600-1)/(s*k*k));
        end
        logL(:, :, k) = log(mean(l, 3));
    end
    for s_i = 1:6
        for e_i = 1:64
            a = polyfit(logk, squeeze(logL(s_i, e_i, :))', 1);
            EC(S_i, s_i, e_i) = -a(1);
        end
    end
    
    disp(['Subject ' num2str(S_i) ' processed.'])
end
save HM EO EC