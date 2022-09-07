
T = 50;    %number of steps of Markov chains
num = input('choose example number (1 through 6): ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
if num == 1

A = zeros(9,9);
for i=2:9
    A(1,i) = 1;
end
A(2,9) = 1;
A(2,3) = 1;
A(3,4) = 1; 
A(4,5) = 1;
A(5,6) = 1;
A(6,7) = 1;
A(7,8) = 1;
A(8,9) = 1;
A(4,6) = 1;
A(6,8) = 1;
A = A+A';

 P = A./sum(A,2);
 [V,D] = eigs(P');
 lams = diag(D);
 disp('eigenvalues are ...')
 lams
 
 close all
 G = graph(A);
 x = 1;
 figure('Renderer', 'painters', 'Position', [100 100 1600 1000])
 h = plot(G,'linewidth',1,'markersize',12,'nodefontsize',18);
 highlight(h,x,'NodeColor','g','markersize',18);
title('Largest eigenvalue is $\lambda_1 = 1$, associated eigenvector $v_1$ is steady state (or pagerank)', ... 
'interpreter','latex','fontsize',18)
 pause(2)
 
 for t=1:T
     y = find(rand < cumsum(P(x,:)),1);
     if x~=y
         path = shortestpath(G,x,y);
     else 
         path = [y y];
     end
     h = plot(G,'linewidth',1,'markersize',12,'nodefontsize',18);
     highlight(h,path,'EdgeColor','r','linewidth',2)
     x = y;
     highlight(h,x,'NodeColor','g','markersize',18);
      title('Largest eigenvalue is $\lambda_1 = 1$, associated eigenvector $v_1$ is steady state (or pagerank)', ... 
'interpreter','latex','fontsize',18)
     pause(.2)
 end
 
 h = plot(G,'linewidth',1,'markersize',6,'nodefontsize',18);
 
 for i=1:9
     highlight(h,i,'NodeColor',[0 abs(V(i,1))/max(abs(V(:,1))) 0],'markersize',12);
 end
 title('nodes colored by values of eigenvector $v_1$,  lighter color = larger value', ...
     'interpreter','latex','fontsize',18)  
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if num == 2
    
 B = ones(10,10);
 C = zeros(10,10);
 A = [B,C; C,B];
 for i=1:20
     A(i,i) = 0;
 end
 
 P = A./sum(A,2);
 [V,D] = eigs(P');
 lams = diag(D);
 disp('eigenvalues are ...')
 lams
 
 close all
 G = graph(A);
 x = 1;
 figure('Renderer', 'painters', 'Position', [100 100 1600 1000])
 h = plot(G,'linewidth',1,'markersize',6,'nodefontsize',11);
 highlight(h,x,'NodeColor','g','markersize',6);
 title("Largest eigenvalue is $\lambda_1 =1$, with multiplicity 2", ... 
      'interpreter','latex','fontsize',18)
 pause(2)
 
 for t=1:T
     y = find(rand < cumsum(P(x,:)),1);
     if x~=y
         path = shortestpath(G,x,y);
     else 
         path = [y y];
     end
     h = plot(G,'linewidth',1,'markersize',6,'nodefontsize',11);
     highlight(h,path,'EdgeColor','r','linewidth',2)
     x = y;
     highlight(h,x,'NodeColor','g','markersize',6);
      title("Largest eigenvalue is $\lambda_1 =1$, with multiplicity 2", ... 
      'interpreter','latex','fontsize',18)
     pause(.2)
 end
 
 figure('Renderer', 'painters', 'Position', [100 100 1800 1000])
 subplot(1,2,1)
  h = plot(G,'linewidth',1,'markersize',6,'nodefontsize',11);
 
 for i=1:20
     highlight(h,i,'NodeColor',[0 abs(V(i,1))/max(abs(V(:,1))) 0],'markersize',6);
 end
 title('nodes colored by values of first basic eigenvector for $\lambda_1 = 1$', ...
     'interpreter','latex','fontsize',18)
 
 subplot(1,2,2)
 h = plot(G,'linewidth',1,'markersize',6,'nodefontsize',11);
 
 for i=1:20
     highlight(h,i,'NodeColor',[0 (V(i,2)-min(V(:,2)))/(max(V(:,2))-min(V(:,2))) 0],'markersize',6);
 end
 title('nodes colored by values of second basic eigenvector for $\lambda_1 = 1$', ...
     'interpreter','latex','fontsize',18)
 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if num == 3
    
A = zeros(5,5);
A(1,1) = 1/2;
A(1,2) = 1/2;
A(2,1) = 1/2;
A(2,3) = 1/2;
A(3,2) = 1/2;
A(3,4) = 1/2;
A(4,3) = 1/2;
A(4,5) = 1/2;
A(5,5) = 1;

P = A./sum(A,2);
 [V,D] = eigs(P');
 lams = diag(D);
 disp('eigenvalues are ...')
 lams
 
 close all
 G = digraph(A);
 x = 1;
 figure('Renderer', 'painters', 'Position', [100 100 1600 1000])
 h = plot(G,'linewidth',1,'markersize',12,'nodefontsize',18,'arrowsize',16);
 highlight(h,x,'NodeColor','g','markersize',18);
title("Largest eigenvalue is $\lambda_1 = 1$, associated eigenvector $v_1$ is steady state (or pagerank); implied timescale = 1/(1-$\lambda_2$) = " + 1/(1-lams(2)), ... 
'interpreter','latex','fontsize',18)
 pause(2)
 
 for t=1:T
     y = find(rand < cumsum(P(x,:)),1);
     if x~=y
         path = shortestpath(G,x,y);
     else 
         path = [y y];
     end
     h = plot(G,'linewidth',1,'markersize',12,'nodefontsize',18,'arrowsize',16);
     highlight(h,path,'EdgeColor','r','linewidth',2)
     x = y;
     highlight(h,x,'NodeColor','g','markersize',18);
      title("Largest eigenvalue is $\lambda_1 = 1$, associated eigenvector $v_1$ is steady state (or pagerank); implied timescale = 1/(1-$\lambda_2$) = " + 1/(1-lams(2)), ... 
'interpreter','latex','fontsize',18)
     pause(.2)
 end
 
 figure('Renderer', 'painters', 'Position', [100 100 1800 1000])
 subplot(1,2,1)
 h = plot(G,'linewidth',1,'markersize',6,'nodefontsize',18,'arrowsize',16);
 
 for i=1:5
     highlight(h,i,'NodeColor',[0 V(i,1)/max(V(:,1)) 0],'markersize',12);
 end
 title('nodes colored by values of eigenvector $v_1$,  lighter color = larger value', ...
     'interpreter','latex','fontsize',18)  
    
subplot(1,2,2) 
 h = plot(G,'linewidth',1,'markersize',6,'nodefontsize',18,'arrowsize',16);
 
 for i=1:4
     highlight(h,i,'NodeColor',[0 abs(V(i,2))/max(abs(V(1:4,2))) 0],'markersize',10);
 end
 highlight(h,5,'NodeColor',[0 0 0],'markersize',12);
 title('transient nodes colored by eigenvector $v_2$,  lighter color = larger value', ...
     'interpreter','latex','fontsize',18)  
 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
if num == 4
    
 B = ones(10,10);
 C = zeros(10,10);
 A = [B,C; C,B];
 A(10,11) = 1;
 A(11,10) = 1;
 for i=1:20
     A(i,i) = 0;
 end
 
 P = A./sum(A,2);
 [V,D] = eigs(P');
 lams = diag(D);
 disp('eigenvalues are ...')
 lams
 
 close all
 G = graph(A);
 x = 1;
 figure('Renderer', 'painters', 'Position', [100 100 1600 1000])
 h = plot(G,'linewidth',1,'markersize',6,'nodefontsize',11);
 highlight(h,x,'NodeColor','g','markersize',6);
title("Second largest eigenvalue is $\lambda_2$, implied timescale = 1/(1-$\lambda_2$) = " + 1/(1-lams(2)), ... 
'interpreter','latex','fontsize',18)
 pause(2)
 
 for t=1:T
     y = find(rand < cumsum(P(x,:)),1);
     if x~=y
         path = shortestpath(G,x,y);
     else 
         path = [y y];
     end
     h = plot(G,'linewidth',1,'markersize',6,'nodefontsize',11);
     highlight(h,path,'EdgeColor','r','linewidth',2)
     x = y;
     highlight(h,x,'NodeColor','g','markersize',6);
      title("Second largest eigenvalue is $\lambda_2$, implied timescale = 1/(1-$\lambda_2$) = " + 1/(1-lams(2)), ... 
      'interpreter','latex','fontsize',18)
     pause(.2)
 end
 
 figure('Renderer', 'painters', 'Position', [100 100 1800 1000])
 subplot(1,2,1)
  h = plot(G,'linewidth',1,'markersize',6,'nodefontsize',11);
 
 for i=1:20
     highlight(h,i,'NodeColor',[0 abs(V(i,1))/max(abs(V(:,1))) 0],'markersize',6);
 end
 title("nodes colored by values of eigenvector $v_1$ associated to $\lambda_1 =$ " + lams(1), ...
     'interpreter','latex','fontsize',18)
 
 subplot(1,2,2)
 h = plot(G,'linewidth',1,'markersize',6,'nodefontsize',11);
 
 for i=1:20
     highlight(h,i,'NodeColor',[0 (V(i,2)-min(V(:,2)))/(max(V(:,2))-min(V(:,2))) 0],'markersize',6);
 end
 title("nodes colored by values of eigenvector $v_2$ associated to $\lambda_2=$" + lams(2), ...
     'interpreter','latex','fontsize',18)
 
end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if num == 5

 A = zeros(70,70);
 for i=1:10
     for j=1:10
         if i~=j
         A(i,j) = 1;
         A(i+10,j+10) = 1;
         end
     end
 end
 for i=21:70
     for j=21:70
         if i~=j
         A(i,j) = 1;
         end
     end
 end
 A(10,11) = 1;
 A(11,10) = 1;
 A(20,21) = 1;
 A(21,20) = 1;
 P = A./sum(A,2);
 [V,D] = eigs(P');
 lams = diag(D);
 disp('eigenvalues are ...')
 lams
 
 close all
 G = graph(A);
 x = 1;
 figure('Renderer', 'painters', 'Position', [100 100 1600 1000])
 h = plot(G,'linewidth',1,'markersize',6,'nodefontsize',11);
 highlight(h,x,'NodeColor','g','markersize',6);
title("Implied timescales = 1/(1-$\lambda_2$) = " + 1/(1-lams(2)) + " and 1/(1-$\lambda_3$) = " + 1/(1-lams(3)), ... 
'interpreter','latex','fontsize',18)
 pause(2)
 
 for t=1:T
     y = find(rand < cumsum(P(x,:)),1);
     if x~=y
         path = shortestpath(G,x,y);
     else 
         path = [y y];
     end
     h = plot(G,'linewidth',1,'markersize',6,'nodefontsize',11);
     highlight(h,path,'EdgeColor','r','linewidth',2)
     x = y;
     highlight(h,x,'NodeColor','g','markersize',6);
      title("Implied timescales = 1/(1-$\lambda_2$) = " + 1/(1-lams(2)) + " and 1/(1-$\lambda_3$) = " + 1/(1-lams(3)), ... 
'interpreter','latex','fontsize',18)
     pause(.2)
 end
 
 figure('Renderer', 'painters', 'Position', [100 100 1800 1000])
 subplot(1,2,1)
  h = plot(G,'linewidth',1,'markersize',6,'nodefontsize',11);
 
 for i=1:70
     highlight(h,i,'NodeColor',[0 (V(i,2)-min(V(:,2)))/max(V(:,2)-min(V(:,2))) 0],'markersize',6);
 end
 title("nodes colored by values of eigenvector $v_2$ associated to $\lambda_2=$" + lams(2), ...
     'interpreter','latex','fontsize',18)
 
 subplot(1,2,2)
 h = plot(G,'linewidth',1,'markersize',6,'nodefontsize',11);
 
 for i=1:70
     highlight(h,i,'NodeColor',[0 (V(i,3)-min(V(:,3)))/max(V(:,3)-min(V(:,3))) 0],'markersize',6);
 end
 title("nodes colored by values of eigenvector $v_3$ associated to $\lambda_3=$" + lams(3), ...
     'interpreter','latex','fontsize',18)
 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if num == 6

A = zeros(5,5);
A(1,2) = 1;
A(2,3) = 1;
A(3,4) = 1; 
A(4,5) = 1;
A(5,1) = 1;

P = A./sum(A,2);
 [V,D] = eigs(P');
 lams = diag(D);
 disp('eigenvalues are ...')
 lams
 
 close all
 G = digraph(A);
 x = 1;
 figure('Renderer', 'painters', 'Position', [100 100 1600 1000])
 h = plot(G,'linewidth',1,'markersize',12,'nodefontsize',18,'arrowsize',16);
 highlight(h,x,'NodeColor','g','markersize',18);
title("Eigenvalues $\lambda = \sqrt[5]{1}$", ... 
'interpreter','latex','fontsize',18)
 pause(2)
 
 for t=1:T
     y = find(rand < cumsum(P(x,:)),1);
     if x~=y
         path = shortestpath(G,x,y);
     else 
         path = [y y];
     end
     h = plot(G,'linewidth',1,'markersize',12,'nodefontsize',18,'arrowsize',16);
     highlight(h,path,'EdgeColor','r','linewidth',2)
     x = y;
     highlight(h,x,'NodeColor','g','markersize',18);
      title("Eigenvalues $\lambda = \sqrt[5]{1}$", ... 
'interpreter','latex','fontsize',18)
     pause(.2)
 end
    
end
    
 
