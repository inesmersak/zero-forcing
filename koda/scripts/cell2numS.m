function [O]=cell2num_S(i) % convert cell array of strings into array of numbers
fun = @(i) str2num(cell2mat(i));
O=arrayfun(fun,i);
end