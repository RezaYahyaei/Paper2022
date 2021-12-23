% Feature extraction script for AR

EO = zeros(109, 6, 64, 6);
EC = zeros(109, 6, 64, 6);
for S_i = 1:109
    for s_i = 1:6
        
        % Eyes Open
        EO(S_i, s_i, :, :) = arburg(squeeze(PREPROCDAT.EO(S_i, s_i, :, :))', 5);
        
        % Eyes Close
        EC(S_i, s_i, :, :) = arburg(squeeze(PREPROCDAT.EC(S_i, s_i, :, :))', 5);
        
    end
    
    disp(['Subject ' num2str(S_i) ' processed.'])
end
save AR EO EC