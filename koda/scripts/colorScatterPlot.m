function [f] = colorScatterPlot(X,Y,Z,T,varargin) %% scatter plot with colors see below example
                                                 
    p = inputParser;
    
    addOptional(p,'view',[45 45]); 
    addOptional(p,'size',5); 
    addOptional(p,'marker','o'); 
    
    try
        parse(p,varargin{:});
    catch err
        disp('PARSER ERROR');
        disp('valid arguments >>')
        disp(p.Parameters);
        disp('error msg:')
        rethrow(err);
    end


%%COLORED SCATTER PLOT

    colors=zeros(length(T),3);
    sizes=ones(length(T),1)*p.Results.size;
    colors(:,1)=T(:)/max(T);
    scatter3(X,Y,Z,sizes,colors.^2,p.Results.marker);
    view([45 45]);

    %close all;
    %clear;
    %domain.lo=[0,0,0];
    %domain.hi=[1,1,1];
    %domain.size=[10,10,10];
    %clc;
    %%data generation
    %f=@(x,y,z) sin(((x-0.5)^2+(y-0.5)^2+(z-0.5)^2));
    %
    %i=0;for x=[0:0.1:1];for y=[0:0.1:1];for z=[0:0.1:1];i=i+1;;pos(i,1)=x;pos(i,2)=y;pos(i,3)=z;T(i)=f(x,y,z);end;end;end
    %
    %pX=linspace(domain.lo(1),domain.hi(1),domain.size(1));
    %pY=linspace(domain.lo(2),domain.hi(2),domain.size(2));
    %pZ=linspace(domain.lo(3),domain.hi(3),domain.size(3));
    %
    %[pX,pY,pZ]=meshgrid(pX,pY,pZ);
    %pT=griddata(pos(:,1),pos(:,2),pos(:,3),T,pX,pY,pZ,'linear'); 
    %
    %f=createFig('pos',2);
    %colorScatterPlot(pos(:,1),pos(:,2),pos(:,3),T,'size',15)