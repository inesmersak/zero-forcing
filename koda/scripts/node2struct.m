function s = node2struct(node)

s.name = char(node.getNodeName);

if node.hasAttributes
   attributes = node.getAttributes;
   nattr = attributes.getLength;
   s.attributes = struct('name',cell(1,nattr),'value',cell(1,nattr));
   for i = 1:nattr
      attr = attributes.item(i-1);
      s.attributes(i).name = char(attr.getName);
      s.attributes(i).value = char(attr.getValue);
   end
else
   s.attributes = [];
end