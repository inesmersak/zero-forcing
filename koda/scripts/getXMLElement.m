function [a] =  getXMLElement(XML,cellTarget); %[GK] gets you XML tag base on cell array input::getXMLElement(XMLin,{'case','casedef','constantsdef','coefficient'})
   a=recurse(XML,cellTarget,1);
end
function [a2] = recurse(a1,cellTarget,i)
    a2=a1.getElementsByTagName(cellTarget(i)).item(0);
    if(i<length(cellTarget))
        i=i+1;
        a2=recurse(a2,cellTarget,i);
    end
end