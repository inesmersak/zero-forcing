function [f] = setfig(code, dimensions, varargin)
% Positions figure window on a monitor.
% Monitors are abcd, positions are:
% 1  2
% 3  4
% Second argument is size. If empty, half or quarter of the screen is used.
% Additional arguments are passed on to figure.
% Returns a figure handle.
%
% Exmaple:
% f = setfig('b1');
% f = setfig('b2', [500 300]);   % A 500x300 image in the second quadrant.

defaultpos = 1;
monitors = get(0, 'MonitorPositions');
[n,~] = size(monitors);
if nargin < 1, monitor = n; pos = defaultpos; code = [char ('a'+n-1) '1']; end
if length(code) < 1, pos = defaultpos;
elseif isempty(code), monitor = n;
else monitor = code(1) - 'a' + 1;
end
if monitor < 1, warning('Cannot access monitor %d, defaulting to 1.', monitor), monitor = 1; end
if monitor > n, warning('Cannot access monitor %d, defaulting to %d.', monitor, n), monitor = n; end
x = monitors(monitor, 1);
y = monitors(monitor, 2);
w = monitors(monitor, 3);
h = monitors(monitor, 4); % toolsbars and stuff
if length(code) == 1, code = strcat(code, '1'); end
if length(code) >= 2,
    if code(2) == 'o'
        assert(length(code) >= 3, 'Missing third character.')
        pos = str2double(code(3:end));
        sx = w/4;
        sy = h/4 - 25;
        y = y + h/4*(3 - floor((pos - 1) / 4));
        x = x + w/4*mod(pos-1, 4);
    else
        pos = code(2) - '0';
        sx = w/2;
        sy = h/2 - 50;
        switch pos
            case 1, y = y + h/2;
            case 2, y = y + h/2; x = x + w/2;
            case 3;
            case 4, x = x + w/2;
            otherwise, error('Position % d not known', pos);
        end
    end
end

% focus
if nargin >= 2
    if numel(dimensions) == 0, dimensions = [sx sy]; end
    assert(numel(dimensions) == 2, 'Size vector must be of length 2, got %s.', mat2str(dimensions))
    sx = dimensions(1);
    sy = dimensions(2);
end

f = figure('Position', [x y sx sy], 'MenuBar', 'none',...
    'ToolBar', 'figure', varargin{:});
hold on
grid on
box on
xlabel('$x$')
ylabel('$y$')
zlabel('$z$')
%set(gca,'Position', [.1 .1 .85 .85])
%set(0, 'DefaultTextFontName', 'CMU Serif')
%set(0, 'DefaultAxesFontName', 'CMU Serif')
set(0, 'DefaultTextInterpreter','latex')
set(0, 'DefaultAxesTickLabelInterpreter', 'latex')
set(0, 'DefaultColorbarTickLabelInterpreter', 'latex')
set(0, 'DefaultLegendInterpreter', 'latex')

set(0, 'DefaultTextFontSize', 12);
set(0, 'DefaultAxesFontSize', 12);
set(0, 'DefaultLineLineWidth', 1.2);
set(0, 'DefaultLineMarkerSize', 5);

% figure(f)

end
