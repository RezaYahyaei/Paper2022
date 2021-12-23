% Feature extraction script for KFD

EO = zeros(109, 6, 64);
EC = zeros(109, 6, 64);
for S_i = 1:109
    
    % Eyes Open
    data = squeeze(PREPROCDAT.EO(S_i, :, :, :));
    n = size(data, 3)-1;
    Ly = diff(data, 1, 3);
    ux = 1; % unit of time
    Lx = ones(size(Ly)).*ux;
    L = sum(sqrt(Ly.^2 + Lx.^2), 3);
    dy = bsxfun(@minus, data(:, :, 2:end), data(:, :, 1));
    dx = repmat(reshape(1:n, 1, 1, n), [size(dy, 1), size(dy, 2), 1]).*ux;
    d = max(sqrt(dy.^2 + dx.^2), [], 3);
    EO(S_i, :, :) = log10(n)./(log10(n)+log10(d./L));
    
    % Eyes Close
    data = squeeze(PREPROCDAT.EC(S_i, :, :, :));
    n = size(data, 3)-1;
    Ly = diff(data, 1, 3);
    ux = 1; % unit of time
    Lx = ones(size(Ly)).*ux;
    L = sum(sqrt(Ly.^2 + Lx.^2), 3);
    dy = bsxfun(@minus, data(:, :, 2:end), data(:, :, 1));
    dx = repmat(reshape(1:n, 1, 1, n), [size(dy, 1), size(dy, 2), 1]).*ux;
    d = max(sqrt(dy.^2 + dx.^2), [], 3);
    EC(S_i, :, :) = log10(n)./(log10(n)+log10(d./L));
    
    disp(['Subject ' num2str(S_i) ' processed.'])
end
save KFD EO EC