function [a] =  getXMLValue(XML,cellTarget) % [GK] returns XML value based on cell input a=getXMLvalue(XMLin,{'case','casedef','constantsdef','coefficient'})
    x=getXMLElement(XML,cellTarget);
    a=x.getAttributes.item(0).getValue;
end