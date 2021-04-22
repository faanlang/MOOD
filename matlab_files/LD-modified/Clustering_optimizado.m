%% Clustering and visualization with LD_modified

%Para dibujar PARETOS F and S

%Name of the parameters
varNames = {'Km_CCgC','Km_BCgB','d_B','d_C','\gamma_1','\gamma_3','\gamma_4','\gamma_5', 'kp_B','kp_C'};


%Resorting parameters
%Resort = [2 3 9 5 6 7 8 1 4 10]; 
Resort = 1:10;
%Calculating norm of pareto front
pf = OUT.PFront;
PS = OUT.PSet(:,Resort);
varNames = varNames(Resort);


Points = size(PS,1);
%Calculate norm of points
maxpf=max(pf);
minpf=min(pf);
Maxpf=repmat(maxpf,Points,1);
Minpf=repmat(minpf,Points,1);
norpf=(pf-Minpf)./(Maxpf-Minpf);  %normalizing norm
% Computing distance to the ideal point, according the selected norm
distancia=zeros(Points,1);
for m=1:Points
    distancia(m)=norm(norpf(m,:),2);
end
%%%
%%
%Constructiong the Data matrix with Objectives and Desicion Variables
Data =log([OUT.PFront OUT.PSet]);
eucD = pdist(Data,   'euclidean'); %
clustTreeEuc = linkage(eucD,'median'); %
cophenet(clustTreeEuc,eucD) 
% Number of desired clusters 
P_buenos_vec = zeros(10,1)
for k=1:6
    
N_Clusters =k;
Clusters_out = cluster(clustTreeEuc,'maxclust',N_Clusters);% 'Cutoff',1.125); %
 figure('Color',[1 1 1]);
% [h,nodes] = dendrogram(clustTreeEuc,0);
% h_gca = gca;
% h_gca.TickDir = 'out';
% h_gca.TickLength = [.002 0];
% h_gca.XTickLabel = [];
Clusters_out =  orden(Clusters_out);

P_vec = zeros(10,1);
for i=1:10
    [P,ANOVATAB,STATS] = kruskalwallis(OUT.PSet(:,i),Clusters_out,'off');
    P_vec(i) = P;
    %[c,m,h,nms] = multcompare(STATS);
end
P_buenos = P_vec < 0.01;
P_buenos_vec(k) = sum(P_buenos);

end

%Find the clustering that maximize the number of parameters that are good
%(explain)
I =find(P_buenos_vec == max(P_buenos_vec));
%% %Re clustering with that number

N_Clusters =I;
Clusters_out = cluster(clustTreeEuc,'maxclust',N_Clusters);% 'Cutoff',1.125); %
 figure('Color',[1 1 1]);
 [h,nodes] = dendrogram(clustTreeEuc,0);
 h_gca = gca;
 h_gca.TickDir = 'out';
 h_gca.TickLength = [.002 0];
 h_gca.XTickLabel = [];
Clusters_out =  orden(Clusters_out);


P_vec = zeros(10,1);
for i=1:10
    [P,ANOVATAB,STATS] = kruskalwallis(OUT.PSet(:,i),Clusters_out,'off')
    P_vec(i) = P;
    %figure
   % [c,m,h,nms] = multcompare(STATS);
    
end
%% Using Clusters to build lgc struct and plot LD-modified with Clusters in Y axis.
% 
 Color_Map = [ 178,24,43;...
     239,138,98;...
     253,219,199;...
     209,229,240;...
     103,169,207;...
     33,102,172]/255;
if (I == 2);
    sele= [1 6];
end
if (I == 3);
    sele= [1 3 6];
end
if (I == 4);
    sele= [1 2 4 6];
end
 Color_Map = Color_Map(sele,:);
 
 Color_Clusters = zeros(length(Clusters_out),3);
 for i=1:max(Clusters_out)
     Color_Clusters(Clusters_out==i,:) = ones(size( Color_Clusters(Clusters_out==i,:),1),1)*Color_Map(i,:);
 end
% 
% %Normal LD cluster color
 lgc = buildlgstruct6_color(OUT.PFront,PS,[],[],Color_Clusters);
 layergraph6_colormap(lgc);
% 
% 
% %ClusterLD
 lgc = buildlgstruct6_color_cluster(OUT.PFront,PS,[],[],Color_Clusters,Clusters_out);
 layergraph6_colormap(lgc);
 
%% % 
 cd ..

% %% Temporal plot
 N = length(OUT.PFront);
     figure('Color',[1 1 1 ]);
 hold on;
 for i=1:N
     objective_func(OUT.PSet(i,:),'plot',Color_Clusters(i,:));
 end


 
 %% For guidelines
 
% 
I_p = P_vec < 0.05;
I_general = 1 - I_p;

%General
P_general = OUT.PSet(:,I_general == 1);
P_g_names = varNames(I_general == 1)
P_g_int =[ min(P_general,[],1);  max(P_general,[],1)]

%Cluster 1

P_c1 = OUT.PSet(Clusters_out == 1, I_p == 1);
P_c1_names = varNames(I_p == 1)
P_c1_int =[ min(P_c1,[],1);  max(P_c1,[],1)]

%Cluster 1

P_c2 = OUT.PSet(Clusters_out == 2, I_p == 1);
P_c2_names = varNames(I_p == 1);
P_c2_int =[ min(P_c2,[],1);  max(P_c2,[],1)]


