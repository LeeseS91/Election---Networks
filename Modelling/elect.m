function [pview] = elect(N,I)
 
pview = ones(N,1);
 c = randi(N,I,1);
 for i = 1:length(c)
 pview(c(i)) = -1;
 end