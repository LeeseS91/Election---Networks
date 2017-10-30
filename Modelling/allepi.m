function [Nwrk] = allepi(N,c)
 Nwrk = rand(N)<c/N;
 Nwrk = Nwrk - diag(diag(Nwrk));
 Nwrk = triu(Nwrk)+triu(Nwrk)';
 for i=1:N;
     if sum(Nwrk(i,:))==0 && i~=N
         Nwrk(i,i+randi(N-i))=1;
     elseif sum(Nwrk(i,:))==0 && i==N && sum(Nwrk(:,i))==0
         Nwrk(i-randi(N-1),i)=1;
     end
 end
Nwrk = triu(Nwrk)+triu(Nwrk)';