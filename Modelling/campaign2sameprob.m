% function f=campaign2sameprob(No)

loop=10000;
MAX=5;
positive=zeros(10,1);
negative=zeros(10,1);
posaverage=zeros(MAX,loop);
negaverage=zeros(MAX,loop);
probvals=[0 0.25 0.5 0.75 1];
n0vals=500*[0.2 0.3 0.7 0.8 1];

for prob=probvals
    for n0=n0vals
        for count=1:MAX
            
            probcount=find(prob==probvals);
            kcount=find(n0==n0vals);
            
            N=1000;
            %adjacency matrix
            connect=epi(N,50);
            Ncon=sum(sum(connect));
            
            %array of political views
            convince=elect(N,n0);%N/100);
            
            probval=prob; % all probs the same as this value. Try 1 0 and a few in betwean
            k=1;
            stuckcount=1;
            
            [positx posity]=find(connect==1);
            probchange=probval*ones(1,N);
            randlist=randi(Ncon,1000*loop,1);
            prevxy=[];
            while k<=loop&&stuckcount<=loop
                rec=1;
                
                
                inspect=randlist(k+stuckcount-1);
                
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
                            
                            if length(posfriend)>=1
                                friendindex=randi(length(posfriend));
                                friend=posfriend(friendindex);
                                connect(positx(inspect),posity(inspect))=0;
                                connect(posity(inspect),positx(inspect))=0;
                                connect(positx(inspect),friend)=1;
                                connect(friend,positx(inspect))=1;
                                positx(positx==posity(inspect)&posity==positx(inspect))=friend;
                                posity(inspect)=friend;
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
                
                
                if rec==1;
                    kk(k)=k;
                    pos(k)=sum((convince==1));
                    neg(k)=sum((convince==-1)) ;
                end
                k=k+1;
            end
            convince;
%             figure
%             plot(kk,pos,'rx',kk,neg,'bx')
            positive(count)=pos(end);
            negative(count)=neg(end);
            posaverage(count,1:length(pos))=pos;
            negaverage(count,1:length(neg))=neg;
            clear kk
            clear pos
            clear neg
            
            
            for i=1:N
                personxlinks=connect(:,i);
                xindex=find(personxlinks==1);
                posbadfriends=(find(convince~=convince(i)));
                badfriend=[];
                for j=1:length(xindex)
                    if sum(posbadfriends==xindex(j))
                        badfriend=[badfriend xindex(j)];
                    end
                end
                NBF(i)=length(badfriend);
            end
            
            f=sum(NBF);
            
            
        end
        
        
        stop =0;
        stop2=0;
        for i=1:10000
            for j=1:MAX
                if negaverage(j,i)==0 && stop==0
                    stop=i-1;
                end
                if posaverage(j,i)==0 && stop2==0
                    stop2=i-1;
                end
            end
        end
        
        a=mean(posaverage);
        b=mean(negaverage);
        figure;
        plot(1:stop, a(1:stop), 'bx', 1:stop, b(1:stop), 'rx')
        
        varpos(probcount,kcount)=var(positive);
        varneg(probcount,kcount)=var(negative);
        
    end
end
%profile on

