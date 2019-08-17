function [x,y] = plotCircle(x,y,r,varargin) 
	p = inputParser;
	addOptional(p,'N',50);
	addOptional(p,'style','r:');
	try
        parse(p,varargin{:});
    catch err
        disp('PARSER ERROR');
        disp('valid arguments >>')
        disp(p.Parameters);
        disp('error msg:')
        rethrow(err);
    end
	
	N=p.Results.N;
	style=p.Results.style;
	
	fi=0:2*pi/N:(2*pi-2*pi/N);

	x=cos(fi)*r+x;
	y=sin(fi)*r+y;	
end