function [LG] = plotc(arg1x,arg1y,arg2,arg3)  %plot with variable existance checking example plotc('var_name','r+')
    if(~ischar(arg1x)) error('first two arguments have to be string var names');end
   	if(~ischar(arg1y)) error('first two arguments have to be string var names');end

    if(exist('arg2')) if(iscell(arg2)) LG=arg2;end;end
    if(exist('arg2')) if(ischar(arg2)) plt_arg=arg2;end;end
    if(exist('arg3')) if(iscell(arg3)) LG=arg3;end;end
    if(exist('arg3')) if(ischar(arg3)) plt_arg=arg3;end;end

    fail=0;
    try
		str=['plot(',arg1x,',',arg1y,',','''',plt_arg,'''',')'];
		disp(['plotting ::',str]);
		evalin('caller',str);	
    catch 
    	disp(['variables ',arg1x,' or ',arg1y,' does not exists, skipping plot']);
        fail=1;
    end
    if(~fail) LG=[LG,{arg1y}]; end
    
  %  plt_arg=[];
  %  if(~ischar(arg1x)) error('first two arguments have to be string var names');end
  % 	if(~ischar(arg1y)) error('first two arguments have to be string var names');end
%
  %  if(exist('arg2')) if(iscell(arg2)) LG=arg2;end;end
  %  if(exist('arg2')) if(ischar(arg2)) plt_arg=arg2;end;end
  %  if(exist('arg3')) if(iscell(arg3)) LG=arg3;end;end
  %  if(exist('arg3')) if(ischar(arg3)) plt_arg=arg3;end;end
%
	%I=find(arg1x=='.',1);
	%if(isempty(I)) 
	%    str=['exist(''',arg1x,''',''var'')'];
	%else
	%    str=['isfield(',arg1x(1:I-1),',''',arg1x(I+1:end),''')'];
	%end
	%if(~evalin('caller',str)) 
	%    disp(['variable ',arg1x,' does not exists, skipping plot']); 
	%    return
	%end
%
	%I=find(arg1y=='.',1);
	%if(isempty(I)) 
	%    str=['exist(''',arg1y,''',''var'')'];
	%else
	%    str=['isfield(',arg1y(1:I-1),',''',arg1y(I+1:end),''')'];
	%end
	%if(~evalin('caller',str)) 
	%    disp(['variable ',arg1y,' does not exists, skipping plot']); 
	%    return
	%end
 %	
  %  hold on 
  %  str=['plot(',arg1x,',',arg1y,',','''',plt_arg,'''',')'];
  %  disp(['plotting ::',str]);
  %  evalin('caller',str);
  %  LG=[LG,{arg1y}];
  %  hold off	
end