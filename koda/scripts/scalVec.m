function [output,factor,offset,offset2] = scalVec(input,varargin) %% scales vector params: 'range',[-1,1]
	p = inputParser;
    
	addOptional(p,'range',[-1,1]);
	parse(p,varargin{:});
	range=p.Results.range;
    if(sum(abs(range))==0)
       factor=1;
       offset=0;
       offset2=0;
       output=input;
       return;
    end
    
	lo=min(input);
	hi=max(input);

    output=input-min(input);
    
	factor=(range(2)-range(1))/(hi-lo);
    offset=range(1);
    output=output*factor + offset;
	offset=offset;
    offset2=min(input);