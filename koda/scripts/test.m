
xx=[];
yy=[];
ff=[];

for x=0:0.1:1
for y=1:0.1:2
   ff=[ff,sin(3*x.*2*y)];
   xx=[xx,x];
   yy=[yy,y];
end
end

[xi,yi,fi]=interpolateToMeshGrid(xx,yy,ff,51,51,'interpolation','cubic','out','vec');
[xim,yim,fim]=interpolateToMeshGrid(xx,yy,ff,51,51,'interpolation','cubic','out','mesh');

createFig('pos',2);hold on;

plot3(xx,yy,ff,'+');
plot3(xi,yi,fi,'o');
surf(xim,yim,fim)
view(20,40)