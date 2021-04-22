%% Clustering and visualization with LD_modified

%Para dibujar PARETOS F and S

%Name of the parameters
varNames = {'Km_CCgC','Km_BCgB','d_B','d_C','\gamma_1','\gamma_3','\gamma_4','\gamma_5', 'kp_B','kp_C'};


%Resorting parameters
Resort = [2 3 9 5 6 7 8 1 4 10]; 

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
Data =log(OUT.PFront);
eucD = pdist(Data,   'euclidean'); %
clustTreeEuc = linkage(eucD,'median'); %
cophenet(clustTreeEuc,eucD) 
% Number of desired clusters 
N_Clusters =6;
Clusters_out = cluster(clustTreeEuc,'maxclust',N_Clusters);% 'Cutoff',1.125); %
 figure('Color',[1 1 1]);
[h,nodes] = dendrogram(clustTreeEuc,0);
h_gca = gca;
h_gca.TickDir = 'out';
h_gca.TickLength = [.002 0];
h_gca.XTickLabel = [];
Clusters_out =  orden(Clusters_out);


%% Using Clusters to build lgc struct and plot LD-modified with Clusters in Y axis.


      
Color_Map = [ 178,24,43;...
    239,138,98;...
    253,219,199;...
    209,229,240;...
    103,169,207;...
    33,102,172]/255;

Color_Clusters = zeros(length(Clusters_out),3);
for i=1:max(Clusters_out)
    Color_Clusters(Clusters_out==i,:) = ones(size( Color_Clusters(Clusters_out==i,:),1),1)*Color_Map(i,:);
end

%Normal LD cluster color

lgc = buildlgstruct6_color(OUT.PFront,PS,[],[],Color_Clusters);
layergraph6_colormap(lgc);


%ClusterLD
lgc = buildlgstruct6_color_cluster(OUT.PFront,PS,[],[],Color_Clusters,Clusters_out);
layergraph6_colormap(lgc);

cd ..

%% Temporal plot
N = length(OUT.PFront);
    figure('Color',[1 1 1 ]);
hold on;
for i=1:N
    objective_func(OUT.PSet(i,:),'plot',Color_Clusters(i,:));
end


