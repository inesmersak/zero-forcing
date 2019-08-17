function [] = exportfig(f, filename, varargin)
% Exports figure f to filename with white background,
% passing additional arguments to export_fig.

pause(1)
set(0, 'CurrentFigure', f);
set(gcf, 'color', 'w')
export_fig(filename, varargin{:})
set(gcf, 'color', 'default')

end
