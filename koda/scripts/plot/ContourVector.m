%iz vector oblike naredi contour plot

    if(PlotTemp==1)
        plot3(Grid(:,2),Grid(:,3),Grid(:,12),'LineStyle','none','marker','.','markersize',5)
    end
    if(ContourTemp==1)
        TempMatrix=Grid(:,2:3);
        TempMatrix(:,3)=Grid(:,12);
        x=unique(TempMatrix(:,1));
        y=unique(TempMatrix(:,2));
        xsize=size(x);ysize=size(y);
        %dodajanje manjkajocih tock
            matsize=size(TempMatrix);
            TempMatrix(matsize(1)+1,:)=[x(1),y(1),0];
            TempMatrix(matsize(1)+2,:)=[x(1),y(ysize(1)),0];
            TempMatrix(matsize(1)+3,:)=[x(xsize(1)),y(1),0];
            TempMatrix(matsize(1)+4,:)=[x(xsize(1)),y(ysize(1)),0];
        
        TempMatrix=sortrows(TempMatrix);

        for i=1:xsize(1);
           %if (i==1 ||i==xsize(1)) offset=1; else offset=0; end %vrstica uposteva da 4 tocke manjkajo
            PlotMatrix(i,1:ysize(1)) = TempMatrix(1+(i-1)*ysize:i*ysize,3);
        end        
    end