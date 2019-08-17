function [O]=cell2num_S(i) % convert cell array into array of numbers
fun = @(i) (cell2mat(i));
O=arrayfun(fun,i);
end