function [color] = getColorMapColor(clrMap,val) %arguments: clrMap - string, e.g. 'hot', val - value between 0 and 1
    clrmap=colormap(clrMap);
    S=length(clrmap)-1;
    if val>1 || val<0 disp('check val');end
    dx=mod(S*val,1)/S;
    i=floor(S*val)+1;

    if i==S+1  
        R=clrmap(i,1) + (clrmap(i,1) - clrmap(i-1,1))*S*dx; 
        G=clrmap(i,2) + (clrmap(i,2) - clrmap(i-1,2))*S*dx; 
        B=clrmap(i,3) + (clrmap(i,3) - clrmap(i-1,3))*S*dx; 
    else
        R=clrmap(i,1) + (clrmap(i+1,1) - clrmap(i,1))*S*dx; 
        G=clrmap(i,2) + (clrmap(i+1,2) - clrmap(i,2))*S*dx; 
        B=clrmap(i,3) + (clrmap(i+1,3) - clrmap(i,3))*S*dx; 
    end  
%     color=[clrmap(i,1),clrmap(i,2),clrmap(i,3),R,G,B];
    color=[R,G,B];
end