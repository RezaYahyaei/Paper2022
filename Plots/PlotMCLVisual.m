% Plotting script for Fig. 1

load PREPROCDAT

signal = squeeze(PREPROCDAT.EC(1, 1, 1, 701:900)); % subject 1, segment 1, electrode 1
abs_signal_dot = abs(diff(signal));
mcl = mean(abs_signal_dot);

figure('Color', 'white')
plot(abs_signal_dot, 'k', 'LineWidth', 0.8)
hold on
plot(get(gca, 'XLim'), [mcl, mcl], '--k', 'LineWidth', 1.8)
set(get(gca, 'XAxis'), 'FontSize', 12), set(get(gca, 'YAxis'), 'FontSize', 12)
xlabel('n', 'FontSize', 16)
ylabel('\mid\Delta_1x(n)\mid', 'FontSize', 16)
tex = text(-1, mcl, ['MCL = ' num2str(round(mcl, 2))], 'Color', 'black', 'FontSize', 12, ...
                     'FontWeight', 'bold', 'HorizontalAlignment', 'right');%, 'FontName', 'Serif');
box off