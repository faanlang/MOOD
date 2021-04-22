%% Dominance Filter
function PFront =PFilter_sinPSet(F,Nobj)

Xpop=size(F,1);
%Nobj=Dat.NOBJ;
%Nvar=size(C,2);
PFront=zeros(Xpop,Nobj);
%PSet=zeros(Xpop,Nvar);
k=0;

for xpop=1:Xpop
    Dominado=0; 
    
    for compare=1:Xpop
        if F(xpop,:)==F(compare,:)
            if xpop > compare
                Dominado=1;
                break;
            end
        else
            if F(xpop,:)>=F(compare,:)
                Dominado=1;
                break;
            end
        end
    end
    
    if Dominado==0
        k=k+1;
        PFront(k,:)=F(xpop,:);
        %PSet(k,:)=C(xpop,:);
    end
end
PFront=PFront(1:k,:);
%PSet=PSet(1:k,:);


%Ordena =sortrows(PFront ,[Nobj+1:Nobj 1:Nobj]);
%PFront = Ordena(:,1:Nobj);
%PSet   = Ordena(:,Nobj+1:Nobj+Nvar);
