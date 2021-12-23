% Plotting script for Fig. 2

load MCL
MCL.EO = EO;
MCL.EC = EC;
load KFD
KFD.EO = EO;
KFD.EC = EC;

mcl = [MCL.EO(:); MCL.EC(:)];
kfd = [KFD.EO(:); KFD.EC(:)];
outliers = mcl > 110;
mcl(outliers) = [];
kfd(outliers) = [];

figure('Color', 'white', 'WindowState', 'maximized')
scatter(mcl, kfd, 100, '.k')
set(get(gca, 'XAxis'), 'FontSize', 14), set(get(gca, 'YAxis'), 'FontSize', 14)
x = xlabel('MCL', 'FontSize', 18); y = ylabel('KFD', 'FontSize', 18);
axis tight square