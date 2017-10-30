function prob=getprob(personx,persony,views,NP)
prob=zeros(NP,1);
cap=1;
probtemp=abs(randn(1,NP))*cap/3;
probtemp(probtemp>cap)=probtemp(probtemp>cap)-floor(probtemp(probtemp>cap));
orderedprobtemp=(sort(probtemp,'descend'));
pos=zeros(1,NP);
neg=pos;
stub=neg;
for i=1:NP
    knows=persony(personx==i);
    othersviews=views(knows);
    pos(i)=length(othersviews(othersviews==1));
    neg(i)=length(othersviews(othersviews==-1));
    
    if views(i)==1
        stub(i)=1+(pos(i)+1)/(neg(i)+1);
    else
        stub(i)=1+(neg(i)+1)/(pos(i)+1);
    end
    
       
end
orderedstub=sort(stub);
%orderedstub
i=1;
while i<=NP
  person=(stub==orderedstub(i));
  prob(~~(person))= orderedprobtemp(i:i-1+sum(person));
       
  
  
  
  if i+sum(person)==i
      prob(prob==0)=orderedprobtemp(i:NP);
      i=NP+1;
  end
  i=i+sum(person); 
  
end
