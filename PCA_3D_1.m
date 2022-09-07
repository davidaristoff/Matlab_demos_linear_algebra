%%%%%%%%%%%%projecting 3D data onto a the line of best fit%%%%%%%%%%%%%%%%%

%create data set consisting of points that approximately lie on a plane
n = 100;           %number of data points
del = 1;          %noise parameter
x1 = del*rand(n,1);
x2 = 2*del*rand(n,1);
x3 = -2+ rand(n,1) + 2*x1 + x2;
X = [x1,x2,x3];                  %X = data matrix
Xm = mean(X);                    %Xm = (column) mean of X, or mean of data

%plot the points in the data set, together with their mean
close all
figure('Renderer', 'painters', 'Position', [20 20 1800 1000]);

subplot(2,2,1)
plot3(X(:,1),X(:,2),X(:,3),'.b','markersize',15)  %plot original data
hold on
plot3(Xm(1),Xm(2),Xm(3),'s','color',[.5 0 .5],'linewidth',5)     %plot mean of data
plot3([0 Xm(1)],[0 Xm(2)],[0 Xm(3)],'r')
legend('data','mean of data','interpreter','latex','fontsize',14)
axis([-1.5 1.5 -1.5 1.5 -1.5 1.5])
title('original data set','interpreter','latex','fontsize',14)
set(gca,'fontsize',14)

%now do a PCA analysis of the data set, using projections
Xc = X-Xm;                              %Xc = centered version of X
[u,lam] = eigs(Xc'*Xc,3,'largestabs');  %u = 1st principal component
Xp = (Xc*u(:,1))*u(:,1)'+(Xc*u(:,2))*u(:,2)'; %Xp = projected centered data
Xr = Xm + Xp;                           %Xr = 1-term reconstructed data set


subplot(2,2,2)
plot3(Xc(:,1),Xc(:,2),Xc(:,3),'.b','markersize',15) 
hold on
plot3(0,0,0,'sr','linewidth',5)
plot3([0 u(1,1)],[0 u(2,1)],[0 u(3,1)],'color',[.5 0 .5],'linewidth',2)
plot3([0 u(1,2)],[0 u(2,2)],[0 u(3,2)],'color',[.5 0 .5],'linewidth',2)
plot3([0 u(1,3)],[0 u(2,3)],[0 u(3,3)],'color',[.5 0 .5],'linewidth',2)
axis([-1.5 1.5 -1.5 1.5 -1.5 1.5])
legend('data','origin','principal axes','interpreter','latex','fontsize',14)
title('mean-subtracted or centered data set','interpreter','latex','fontsize',14)
set(gca,'fontsize',14)

subplot(2,2,3)
plot3(Xp(:,1),Xp(:,2),Xp(:,3),'.','color',[0 .5 0],'markersize',15)
hold on
plot3(0,0,0,'sr','linewidth',5)
plot3([0 u(1,1)],[0 u(2,1)],[0 u(3,1)],'color',[.5 0 .5],'linewidth',2)
plot3([0 u(1,2)],[0 u(2,2)],[0 u(3,2)],'color',[.5 0 .5],'linewidth',2)
plot3([0 u(1,3)],[0 u(2,3)],[0 u(3,3)],'color',[.5 0 .5],'linewidth',2)
axis([-1.5 1.5 -1.5 1.5 -1.5 1.5])
legend('projected data','origin','principal axes','interpreter','latex','fontsize',14)
title('projected and centered data set','interpreter','latex','fontsize',14)
set(gca,'fontsize',14)

subplot(2,2,4)
plot(Xp(:,1),Xp(:,2),'.','color',[0 .5 0],'markersize',15)
axis([-1.5 1.5 -1.5 1.5])
legend('first two principal coordinates','interpreter','latex','fontsize',14)
 title('2D PCA plot','interpreter','latex','fontsize',14)
 axis square
 set(gca,'fontsize',14)
