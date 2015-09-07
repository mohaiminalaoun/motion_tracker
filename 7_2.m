function [com] = alaounm7_2 (d)
[numRows,numCols] = size(d); 
num = 0; 
den = 0; 
for x = 1:numCols 
    for y = 1:numRows 
        num = num + x*d(y,x);
        den = den + d(y,x); 
    end
end
com = num/den;
end