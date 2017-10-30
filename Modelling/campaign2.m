N=10;
%adjacency matrix
connect=epi(N,5);
Ncon=sum(sum(connect));

%array of political views
convince=elect(N,N/2)

probchange=abs(randn(1,N))/3;
probchange(probchange>1)=probchange(probchange>1)-floor(probchange(probchange>1));

change=zeros(1,N);

for k=1:20
    [positx posity]=find(connect==1)
    inspect=rand()
      for j=1:N
        if i>j
             if convince(i)~=convince(j)
                 if rand()<probchange(i)
                     convince(i)=-1*convince(i);
                 end
                 if rand()<probchange(j)
                     convince(j)=-1*convince(j);
                 end
             end
   
        end
      end
end
  convince         
end

             
             
        
