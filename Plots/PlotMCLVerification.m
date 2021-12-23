% Plotting script for Fig. 5

load MCL

n_S = 5; % number of subjects (first n_S subjects)
subjects = {'A', 'B', 'C', 'D', 'E'};

figure('color', [1 1 1])
hold on
for S_i = 1:n_S
    for s_i = 1:6
        
        plot((1:64)+(S_i-1)*75, squeeze(EC(S_i, s_i, :))-(s_i-1)*30, 'k', 'linew', 1)
        text(32+(S_i-1)*75, 35, subjects{S_i}, 'fontsize', 14, 'fontweight', 'bold')
        
    end
end

xlim([-5, 70+(n_S-1)*75])
ylim([-160 50])
xticks(reshape(bsxfun(@plus, (1:9:64)', (0:(n_S-1))*75), 1, 8*n_S)), xticklabels(repmat(1:9:64, 1, n_S))
yticks(flip(MCL.EC(1, 1, 1)-(0:5)*30)), yticklabels(6:-1:1)
set(get(gca, 'XAxis'), 'FontSize', 14), set(get(gca, 'YAxis'), 'FontSize', 14)
xlabel('Channels', 'fontsize', 18), ylabel('Segments', 'fontsize', 18)

% plot right and top side of boundary box
x = get(gca, 'xlim'); y = get(gca, 'ylim');
plot(x, [y(2), y(2)], 'k')
plot([x(2), x(2)], y, 'k')