% Feature extraction script for MCL

EO = zeros(109, 6, 64);
EC = zeros(109, 6, 64);
for S_i = 1:109
    
    % Eyes Open
    EO(S_i, :, :) = mean(abs(diff(squeeze(PREPROCDAT.EO(S_i, :, :, :)), 1, 3)), 3);
    
    % Eyes Close
    EC(S_i, :, :) = mean(abs(diff(squeeze(PREPROCDAT.EC(S_i, :, :, :)), 1, 3)), 3);
    
    disp(['Subject ' num2str(S_i) ' processed.'])
end
save MCL EO EC