function [pview] = elect2(N)

pview=ones(N,1);
perm=randperm(N);
for i=1:N/2
    pview(perm(i))=-1;
end
end
    