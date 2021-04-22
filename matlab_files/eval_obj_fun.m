function  [J, X] = eval_obj_fun(X,Dat)

Xpop=size(X,1);
Nvar=Dat.NVAR;
M=Dat.NOBJ;
J=ones(Xpop,M);

parfor xpop=1:Xpop
   
    % Our model
    [j1, j2] = objective_func(X(xpop,:),'opt',[]);
   J(xpop,:)=[j1 j2];       % j1= sensitivity^-1, j2= precision
   
end



