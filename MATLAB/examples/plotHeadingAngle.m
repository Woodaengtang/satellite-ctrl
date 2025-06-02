function plotHeadingAngle(lat, lon, heading)
color = [0, 0.4470, 0.7410];
lineStyle = '-';
lineWidth = 1.5;

% figure()
hold on
plot(lat, heading, ...
    'Color', color, 'LineStyle', lineStyle, 'LineWidth', lineWidth);
grid on
ax = gca;
ax.GridColor = [0.35, 0.35, 0.35];
ax.GridAlpha = 1;
ax.GridLineStyle = ':';

xlim([-90, 90])
xticks(-90:15:90)
ylim([-180, 180])
yticks(-180:30:180)
xlabel("Latitude, $\phi\;[^{\circ}]$", 'Interpreter', 'latex',...
    'FontSize', 18)
ylabel("Heading, $\psi\;[^{\circ}]$", 'Interpreter', 'latex', ...
    'FontSize', 18)

j = [];
for i = 2:length(lon)
    if ((lon(i) > 170) && (lon(i - 1) < -170)) || ...
            ((lon(i) < -170) && (lon(i - 1) > 170))
        j = [j, i];
    end
end

j = [j, length(lon)];
% figure()
hold on
plot(lon(1:j(1) - 1), heading(1:j(1) - 1), ...
    'Color', color, 'LineStyle', lineStyle, 'LineWidth', lineWidth);
for i = 1:length(j) - 1
    plot(lon(j(i):j(i + 1) - 1), ...
        heading(j(i):j(i + 1) - 1), ...
        'Color', color, 'LineStyle', lineStyle, 'LineWidth', lineWidth, ...
        'HandleVisibility', 'off');
end
grid on
ax = gca;
ax.GridColor = [0.35, 0.35, 0.35];
ax.GridAlpha = 1;
ax.GridLineStyle = ':';

xlim([-180, 180])
xticks(-180:30:180)
ylim([-180, 180])
yticks(-180:30:180)
xlabel("Longitude, $\lambda\;[^{\circ}]$", 'Interpreter', 'latex',...
    'FontSize', 18)
ylabel("Heading, $\psi\;[^{\circ}]$", 'Interpreter', 'latex', ...
    'FontSize', 18)
end