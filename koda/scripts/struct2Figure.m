function [out] = struct2figure(f,S)

    %%%MISSING ARGUMENT PASSING
    %%%
    figure(f);
    X=get(gca,'xlim');
    Y=get(gca,'ylim');
    
    xRelativeOffset=0.1;
    yRelativeOffset=0.45;
    
    fn=fieldnames(S);
    for(i=1:length(fn))
        %S.(fn{i}) %acess structure element by index
        XX(i)={[cell2mat(fn(i)),' - ', num2str(S.(fn{i}))]};
    end
    
    text((X(2)-X(1))*xRelativeOffset+X(1),(Y(2)-Y(1))*yRelativeOffset+Y(1),XX');

end