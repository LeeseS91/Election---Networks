clear all
N=10;
%adjacency matrix
connect=epi(N,5);
Ncon=sum(sum(connect));

%array of political views
convince=elect(N,N/2)

% probchange=abs(randn(1,N))/3;
% probchange(probchange>1)=probchange(probchange>1)-floor(probchange(probchange>1));

change=zeros(1,N);
k=1;
stuckcount=1;
while k<=10^2&&stuckcount<=100
    rec=1;
    k;
    [positx posity]=find(connect==1)
    inspect=randi(Ncon);
    
    % To try and find opinions of linking neighbours
	links=find(positx==positx(inspect));
    count=1;
    agree=0;
    %remove the link being examined
    while count<=length(links)
        if links(count)==inspect;
            links(count)=[];
        %find the number of people connected that agree with the opinion of the 
        %selected person    
        elseif convince(positx(links(count)))==convince(posity(links(count)))
            agree=agree+1;
        end
        count=count+1;
        
    end
    links;
    %new probability of someone being concvinced based on number of
    %neighbours who also agree with them
    probchange=agree/length(links);
    
    if convince(positx(inspect))~=convince(posity(inspect))
        if rand()<probchange(positx(inspect))
            convince(positx(inspect))=-1*convince(positx(inspect));
        else
            poswire=sum((convince==convince(positx(inspect))));
            if poswire>1
                newcon=randi(Ncon);
                personxlinks=connect(:,positx(inspect));
                xindex=find(personxlinks==0);
                friendindex=find(convince==convince(positx(inspect)));
                posfriend=[];
                for j=1:length(xindex)
                    if sum(friendindex==xindex(j))
                        posfriend=[posfriend xindex(j)];
                    end
                end
                posfriend=posfriend(posfriend~=positx(inspect));
                
                if posfriend>=1
                    friendindex=randi(length(posfriend));
                    friend=posfriend(friendindex);
                    connect(positx(inspect),posity(inspect))=0;
                    connect(posity(inspect),positx(inspect))=0;
                    connect(positx(inspect),friend)=1;
                    connect(friend,positx(inspect))=1;
                    
                    
                    
                else
                    k=k-1;
                    rec=0;
                    stuckcount=stuckcount+1;
                end
                
                
            else
                break
            end
            
            
        end
        
   

    else
        k=k-1;
        rec=0;
        stuckcount=stuckcount+1;
    end
    
    k=k+1;
    if rec==1;
        kk(k)=k;
        pos(k)=sum((convince==1));
        neg(k)=sum((convince==-1)) ;
    end

end
convince
plot(kk,pos,'rx',kk,neg,'bx')



