%Para dibujar PARETOS F and S

%Name of the parameters
varNames = {'Km_CCgC','Km_BCgB','d_B','d_C','\gamma_1','\gamma_3','\gamma_4','\gamma_5', 'kp_B','kp_C'};

%Calculating norm of pareto front
pf = OUT.PFront(1:10,:);
PS = OUT.PSet(1:10,:);

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

%% Using Clusters to build lgc struct and plot LD-modified with Clusters in Y axis.

Clusters_out = 1:length(pf);
Color_Map = jet(max(Clusters_out));
%  Color_Clusters = zeros(length(Clusters_out),3)
%  for i=1:max(Clusters_out)
%      Color_Clusters(Clusters_out==i,:) = ones(size( Color_Clusters(Clusters_out==i,:)),1)*Color_Map(i,:);
%  end
%Color_Clusters = Color_Map;

%lgc = buildlgstruct6_color_cluster(OUT.PFront,PS,[],[],Color_Clusters,Clusters_out);

Color_Clusters = Color_Map;

lgc = buildlgstruct6_color(OUT.PFront,PS,[],[],Color_Clusters);


layergraph6_colormap(lgc);


%% Temporal plot
N = length(OUT.PFront)
figure;
hold on;
for i=1:10
    objective_func_for_plot_color(OUT.PSet(i,:),Color_Clusters(i,:));
end

figure;
hold on;
for i=10:N
    objective_func_for_plot_color(OUT.PSet(i,:),Color_Clusters(i,:));
end