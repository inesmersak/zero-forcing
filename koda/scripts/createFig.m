%simple figure extension with figure positioning regarding the grid
function [f] = figureCreate(varargin) %% puts figure on desired monitor
p = inputParser;

addOptional(p, 'monitor', 1);   %monitor
addOptional(p, 'pos', 1);       %position of figure
addOptional(p, 'divider', 2);   %if divider_y=0 then global divider
addOptional(p, 'divider_y', 0); %vertical divider if~=0 divider becomes horizontal
addOptional(p, 'ps', 0);        %full position overload  
                                %- m1 2x2 p2 means fist monitor 2x2 divider,
                                %2 position if no letter is supplied, default value is assumed 
addOptional(p, 'border', 2); %between figures
addOptional(p, 'header', 75); %header size
addOptional(p, 'taskbar', 40); %taskbar size
addOptional(p, 'paddingTop', 0); %taskbar size
addOptional(p, 'box', true);
addOptional(p, 'grid', true);
addOptional(p, 'title', '');
addOptional(p, 'xlabel', 'x');
addOptional(p, 'ylabel', 'y');
addOptional(p, 'zlabel', 'z');
addOptional(p, 'interpreter', 'latex');
addOptional(p, 'fontname', 0);
addOptional(p, 'fontsize', 0);
addOptional(p, 'scale', 0);
addOptional(p, 'view', 0);

try
    parse(p, varargin{:});
catch err
    disp('PARSER ERROR');
    disp('valid arguments >>')
    disp(p.Parameters);
    disp('error msg:')
    rethrow(err);
end
if (p.Results.fontsize ~= 0)
    set(0, 'defaultaxesfontsize', p.Results.fontsize);
end
if (p.Results.fontname ~= 0)
    set(0, 'defaultaxesfontname', p.Results.fontname);
end
gposition = p.Results.pos;
divider = p.Results.divider;
monitor = p.Results.monitor;
border = p.Results.border;
taskbar = p.Results.taskbar;
header = p.Results.header;
paddingTop = p.Results.paddingTop;
divider_y = p.Results.divider_y;

if p.Results.ps ~=0 
    a = p.Results.ps;
    if strfind(a, 'm')~= 0; monitor = str2num(a(strfind(a, 'm')+1));end
    if strfind(a, 'x')~= 0; divider = str2num(a(strfind(a, 'x')-1));end
    if strfind(a, 'x')~= 0; divider_y = str2num(a(strfind(a, 'x')+1));end
    if strfind(a, 'p')~= 0; gposition = str2num(a(strfind(a, 'p')+1:end));end
end

if (divider_y == 0) divider_y = divider; end

if (gposition > divider * divider_y) gposition = 1; end

MP = get(0, 'MonitorPositions');

if (size(MP, 1) < monitor); monitor = size(MP, 1); end
pos = MP(monitor, :);

mon_height = pos(4) - taskbar - paddingTop - header * divider_y;

dx = (pos(3)) / divider;
dy = mon_height / divider_y;

ix = mod(gposition, divider);
if (ix == 0); ix = divider; end;

iy = ceil(gposition/divider);
if (iy == 0); iy = divider; end;

MonPos(1) = pos(1) + dx * (ix - 1) + border;
MonPos(2) = pos(2) + taskbar + (dy + header) * (iy - 1);

if (p.Results.scale > 0)
    root = min(dx, dy);
    dx = root;
    dy = p.Results.scale * root;
end

MonPos(3) = dx - 2 * border;
MonPos(4) = dy - 2 * border;

f = figure('position', MonPos);
title(p.Results.title);
xlabel(p.Results.xlabel, 'interpreter', p.Results.interpreter);
ylabel(p.Results.ylabel, 'interpreter', p.Results.interpreter);
zlabel(p.Results.zlabel, 'interpreter', p.Results.interpreter);

if (p.Results.box); box on; end
if (p.Results.grid); grid on; end

if (p.Results.view ~= 0) view(p.Results.view);
    hold on;
end

%gkosec@ijs.si