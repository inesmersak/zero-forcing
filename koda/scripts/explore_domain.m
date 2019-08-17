function explore_domain(fig, series, pos, support, types)
% Explores domain drawn as a scatterplot. Shows support domains,
% distances and node types. Double click to start exploring, single
% click to pause, right click to restore.
%
% fig -- figure where the domain is drawn
% series -- comain color series handle
% pos -- domain positions
% support -- domain support, if ragged can be padded with -1s.
% types -- domain types, filled with zeros if not given

if nargin < 5, types = zeros(length(pos), 1); end

xx = pos(1, :);
yy = pos(2, :);

[mind, p1, p2] = closest_pair(xx, yy);
if mind < 1e-6
    warning('Closest pair of points is very close, only %g away. Points: %s and %s',...
        mind, mat2str([xx(p1), yy(p1)], 2), mat2str([xx(p2), yy(p2)], 2))
end

control.fig = fig;
control.start = 0;
control.series = series;
control.pos = pos;
control.sup = support;
control.types = types;
control.old_colors = get(control.series, 'cdata');
control.current_tooltip = 0;

function toggle_nodeinfo(o, event)
    button = get(control.fig, 'SelectionType');
    if strcmp(button, 'open')
        control.start = 1;
    elseif strcmp(button, 'normal')
        control.start = 0;
    else
        control.start = 0;
        set(control.series, 'cdata', control.old_colors);
        delete(control.current_tooltip)
        refresh(control.fig)
    end
end

function show_nodeinfo(o, event)
    if control.start ~= 1, return, end

    pt = get(gca(control.fig), 'CurrentPoint');
    pointx = pt(1, 1);
    pointy = pt(1, 2);

    x = control.pos(1, :);
    y = control.pos(2, :);

    dist = (x-pointx).^2 + (y-pointy).^2;
    [~, I] = min(dist);
    csup = control.sup(:, I);
    csup = csup(csup ~= 0);

    dist = sqrt((x(csup)-x(I)).^2 + (y(csup)-y(I)).^2);

    str = sprintf(['Node with index %d at pos [%g, %g] of type %d.'...
                   '\nClosest node is %g away.\nSupport (%d): %s'...
                   '\nDistances: %s.\nTypes: %s.'], I, x(I), y(I), control.types(I), dist(2),...
                   length(csup), mat2str([x(csup); y(csup)]', 2), mat2str(dist, 2), mat2str(control.types(csup)));


    set(gcf, 'units', 'normalized')
    if (control.current_tooltip ~= 0), delete(control.current_tooltip), end
    control.current_tooltip = uicontrol('Style', 'edit', 'String', str,...
              'units', 'normalized', 'Max', 3, 'Min', 1,...
              'HorizontalAlignment', 'left', 'Position',...
              [get(gcf, 'CurrentPoint')+ [0.05, -0.1], 0.6, 0.2]);
%     set(t, 'units', 'normalized')
%     h1 = get(t, 'position');
%     set(t, 'position', [0 h1(2) h1(3)])


    z = zeros(size(x));
    z(csup) = 1.4;
    z(I) = 2;

    set(control.series, 'cdata', z);
    refresh(control.fig)
end

set(fig, 'WindowButtonMotionFcn', @(o, e) show_nodeinfo(o, e));
set(fig, 'WindowButtonDownFcn', @(o, e) toggle_nodeinfo(e, e));

end
