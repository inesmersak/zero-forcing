function [f] = pltCycleMarker(i) %cycles markers
	  MaS={'+','square','>','o','<','.','pentagram','diamond','*','x','^'};
% 	  if(i>length(MaS))
		i=mod(i,length(MaS));
% 	  end	
		f=cell2mat(MaS(i+1));
end