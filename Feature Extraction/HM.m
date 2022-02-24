% Feature extraction script for HM

kmax = 16; % k_max parameter
eo = zeros(109, 6, 64, kmax);
ec = zeros(109, 6, 64, kmax);
for S_i = 1:109
    
    % Eyes Open
    for k = 1:kmax 
        l = zeros(6, 64, k);
        for m = 1:k
            s = floor((1600-m)/k);
            l(:, :, m) = squeeze(sum(abs(diff( ...
                                 PREPROCDAT.EO(S_i, :, :, m:k:m+s*k), ...
                                 1, 4)), 4)/(s*k*k));
        end
        eo(S_i, :, :, k) = mean(l, 3);
    end
    
    % Eyes Close
    for k = 1:kmax 
        l = zeros(6, 64, k);
        for m = 1:k
            s = floor((1600-m)/k);
            l(:, :, m) = squeeze(sum(abs(diff( ...
                                 PREPROCDAT.EC(S_i, :, :, m:k:m+s*k), ...
                                 1, 4)), 4)/(s*k*k));
        end
        ec(S_i, :, :, k) = mean(l, 3);
    end
    
end
save HM EO EC