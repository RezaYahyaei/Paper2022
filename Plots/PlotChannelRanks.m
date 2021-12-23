% Plotting script for Fig. 6b

load channel_ranks % produced in python code
load ELOC

figure

% Eyes Open
topo1 = subplot(121);
topoplot(EO+1, eloc, 'maplimits', 'maxmin', 'style', 'map');
set(gca, 'CLim', [1, 64]);
text(0.10, 0.55, 'Eyes Open', 'FontSize', 36, 'FontWeight', 'normal', ...
     'HorizontalAlignment', 'left');

% Eyes Close
topo2 = subplot(122);
topoplot(EC+1, eloc, 'maplimits', 'maxmin', 'style', 'map');
set(gca, 'CLim', [1, 64]);
text(-0.10, 0.55, 'Eyes Close', 'FontSize', 36, 'FontWeight', 'normal', ...
     'HorizontalAlignment', 'right');

% colorbar
b = colorbar;
pos = get(b, 'Position');
b.Position = [0.511-pos(3)/2, pos(2)-0.2, pos(3), pos(4)+0.4];
set(get(b, 'Label'), 'String', 'Rank', 'FontWeight', 'bold', 'FontSize', 28)
b2 = b.Label.Position;
b.Label.Position = [b2(1)+2.06, b2(2)-38, b2(3)];
b.Label.Rotation = 0;
set(b, 'Ticks', [5, 60], 'TickLabels', {'Low', 'High'}, 'FontSize', 28)

% adjusting positions
topo1.OuterPosition = [0 0 0.5 1];
topo2.OuterPosition = [0.5 0 0.5 1];
w = min([topo1.Position(3), topo2.Position(3)]);
h = min([topo1.Position(4), topo2.Position(4)]);
topo1.Position(3) = w; topo1.Position(4) = h;
topo2.Position(3) = w; topo2.Position(4) = h;