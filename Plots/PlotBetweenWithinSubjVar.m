% Plotting script for Fig. 4

load MCL
EO(79, :, :) = []; % subject 79, electrode 50 artifact outlier
EC([21, 103], :, :) = []; % subject 21 and 103 outliers

conditions = {'EO', 'EC'};
titles = {'Eyes Open', 'Eyes Close'};

for c_i = 1:2
    
    eval(['mcl = ' conditions{c_i} ';'])
    wsv = squeeze(mean(var(mcl, 0, 2), 1)); % within-subject variation
    bsv = squeeze(var(mean(mcl, 2), 0, 1)); % between-subject variation
    
    figure
    hold on
    plot(wsv, 'k', 'linewidth', 1.5)
    plot(bsv, 'r', 'linewidth', 1.5)
    xlim([0 65]), ylim([-5 180])
    set(gca, 'FontSize', 12)
    xlabel('Channel', 'FontSize', 16), ylabel('Variance', 'FontSize', 16)
    title(titles{c_i}, 'FontSize', 18, 'FontWeight', 'normal')
    legend('Within-subject Variance', 'Between-subject Variance', 'FontSize', 12)
    
    grid on
    
end