function [f] = densityPlot(pX,pY,pZ,pT,varargin) %% densityPlot see below example
                                                 
    p = inputParser;
    
    addOptional(p,'alpha',0.2); 
    addOptional(p,'view',[45 45]); 
    addOptional(p,'numPatches',50); 
    addOptional(p,'scale',[0]); 
    addOptional(p,'colorMap','hot'); 
    try
        parse(p,varargin{:});
    catch err
        disp('PARSER ERROR');
        disp('valid arguments >>')
        disp(p.Parameters);
        disp('error msg:')
        rethrow(err);
    end

    hold on;
    % X,Y,Z iz the meshgrid and V is my function evaluated at each meshpoint
    if p.Results.scale==0 
        minV=min(min(min(pT)));
        maxV=max(max(max(pT)));
    else
        minV=p.Results.scale(1);
        maxV=p.Results.scale(2);
    end
    numPatches=p.Results.numPatches;
    
    i=0;
    for a = linspace(minV,maxV,numPatches) % 'a' defines the isosurface limits
        pp = patch(isosurface(pX,pY,pZ,pT,a)); % isosurfaces at max(V)/a
        isonormals(pX,pY,pZ,pT,pp); % plot the surfaces
        i=i+1;
        set(pp,'FaceColor',getColorMapColor(p.Results.colorMap,i/numPatches),'EdgeColor','none'); % set colors
        
%         lighting gouraud
    end
    daspect([1 1 1]); box on; axis tight;
    alpha(p.Results.alpha); % set the transparency for the isosurfaces
    view(p.Results.view)
    hold off;

    %% EXAMPLE
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
    %densityPlot(pX,pY,pZ,pT,'numPatches',10,'alpha',0.5);