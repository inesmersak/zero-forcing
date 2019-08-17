function ax = zoomin(f, zoom, axpos) % Displays a zoomed in subplot area
% 
% f: figure to zoom in to
% zoom: 4-vector of square to zoom in [x, y, w, h]
% axpos: 4-vector of new axis position in normalized figure coordinates [x, y, w, h]

line_color = [1 1 1]*0.3;

zoomx = [zoom(1) zoom(1) + zoom(3)];
zoomy = [zoom(2) zoom(2) + zoom(4)];

% small square
plot([zoomx(1) zoomx(1) zoomx(2) zoomx(2) zoomx(1)],...
     [zoomy(2) zoomy(1) zoomy(1) zoomy(2) zoomy(2)],...
     '-k', 'LineWidth', 0.5, 'Color', line_color)

% lines
[xf, yf] = ds2nfu(zoomx(1), zoomy(1));
annotation('line', [xf axpos(1)], [yf axpos(2)], 'Linewidth', 0.5, 'Color', line_color)
[xf, yf] = ds2nfu(zoomx(2), zoomy(2));
annotation('line', [xf axpos(1)+axpos(3)], [yf axpos(2)+axpos(4)], 'Linewidth', 0.5, 'Color', line_color)
[xf, yf] = ds2nfu(zoomx(1), zoomy(2));
annotation('line', [xf axpos(1)], [yf axpos(2)+axpos(4)], 'Linewidth', 0.5, 'Color', line_color)
[xf, yf] = ds2nfu(zoomx(2), zoomy(1));
annotation('line', [xf axpos(1)+axpos(3)], [yf axpos(2)], 'Linewidth', 0.5, 'Color', line_color)
annotation('rectangle', axpos, 'FaceColor', 'white', 'LineWidth', 0.5, 'Color', line_color)

% 2nd plot
mrg = 0.004;
p = uipanel(f, 'Position', [axpos(1)+mrg, axpos(2)+mrg axpos(3)-2*mrg axpos(4)-2*mrg], 'BackgroundColor', 'white',...
            'HighLightColor', line_color, 'BorderType', 'none');
ax = axes('Parent', p);
axis tight
box on % put box around new pair of axes
grid on
hold on
xlim(zoomx)
ylim(zoomy)

end
