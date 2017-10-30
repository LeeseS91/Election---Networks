function [Nwrk] = epi(N,c)
 Nwrk = rand(N)<c/N;
 Nwrk = Nwrk - diag(diag(Nwrk));
 Nwrk = triu(Nwrk)+triu(Nwrk)';
