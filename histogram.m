function [counts,values] = histogram(source, min, max)
%   Summary of this function goes here
%   Detailed explanation goes here

values = (min:max)';
counts = zeros(length(values),1);

for i=1:length(source)
    counts(values==source(i)) = counts(values==source(i))+1;
end

end

