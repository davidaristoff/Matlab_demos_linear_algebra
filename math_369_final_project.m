%analyze F Tularensis mouse data set

close all 

load Kingrynormalized.mat
X = Kingrynorm;

%compute SVD and plot singular values

figure('Renderer', 'painters', 'Position', [100 100 1800 1000])
imagesc(X')
colorbar
title('data matrix of mice infected with F. Tularensis (LVS and Schu4 strains)','interpreter','latex')
ylabel('samples (from lung \& spleen of mice)','interpreter','latex')
xlabel('gene expression','interpreter','latex')
set(gca,'ydir','normal')
set(gca,'FontSize',22)


[U S V] = svd(X, 0);
s = diag(S);
% figure
% plot(s)
% xlabel('index')
% ylabel('singular value')

control_lung = X(:,1:6);
control_spleen = X(:,55:60);
Schu4_lung = X(:,7:30);
LVS_lung = X(:,31:54);
Schu4_spleen = X(:,61:84);
LVS_spleen = X(:,85:108);

U3 = U(:,1:3);    %3 principal directions

%project data onto 3 principal directions.
control_lung_3d = control_lung'*U3;
control_spleen_3d = control_spleen'*U3;
Schu4_lung_3d = Schu4_lung'*U3;
LVS_lung_3d = LVS_lung'*U3;
Schu4_spleen_3d = Schu4_spleen'*U3;
LVS_spleen_3d = LVS_spleen'*U3;

figure('Renderer', 'painters', 'Position', [100 100 1800 1000])
a = X'*U(:,1:3);
plot3(control_lung_3d(:,1),control_lung_3d(:,2),control_lung_3d(:,3),'b+','linewidth',2)
hold on
plot3(control_spleen_3d(:,1),control_spleen_3d(:,2),control_spleen_3d(:,3),'bd','linewidth',2)
plot3(Schu4_lung_3d(:,1),Schu4_lung_3d(:,2),Schu4_lung_3d(:,3),'ro','linewidth',2)
plot3(LVS_lung_3d(:,1),LVS_lung_3d(:,2),LVS_lung_3d(:,3),'gx','linewidth',2)
plot3(Schu4_spleen_3d(:,1),Schu4_spleen_3d(:,2),Schu4_spleen_3d(:,3),'kv','linewidth',2)
plot3(LVS_spleen_3d(:,1),LVS_spleen_3d(:,2),LVS_spleen_3d(:,3),'m^','linewidth',2)
legend('control lung','control spleen', ...
    'Schu4 lung','LVS lung','Schu4 spleen','LVS spleen')
title('PCA plot of gene expression in mice infected with F. Tularensis','interpreter','latex')
xlabel('first principal axis','interpreter','latex')
ylabel('second principal axis','interpreter','latex')
zlabel('third principal axis','interpreter','latex')
set(gca,'FontSize',22)

%now project Schu4 lung and LVS lung onto control lung

% U = orth(control_lung);    %U = orthonormal basis for control lung
% figure
% hist(vecnorm(Schu4_lung - U*(U'*Schu4_lung)))
% figure
% hist(vecnorm(LVS_lung - U*(U'*LVS_lung)))
% 
% %now project Schu4 spleen and LVS spleen onto control spleen
% 
% U = orth(control_spleen);    %U = orthonormal basis for control lung
% figure
% hist(vecnorm(Schu4_spleen - U*(U'*Schu4_spleen)))
% figure
% hist(vecnorm(LVS_spleen - U*(U'*LVS_spleen)))

%COMMENT ON WHAT NOVELTIES ARE LARGER. WHAT DOES THIS MEAN QUALITATIVELY

%now do Fisher discriminant analysis on the data

Cm = X(:,55:60);
Cp = X(:,61:108);

Y = [Cm,Cp];
[U,Sigma,V] = svd(Y,0);

A = Sigma*V';     %reduced spleen data
mean_Am = mean(A(:,1:6),2);
mean_Ap = mean(A(:,7:54),2);

S = zeros(54,54);
for i=1:6
    S = S + (A(:,i)-mean_Am)*(A(:,i)-mean_Am)';
end
for i=7:54
    S = S + (A(:,i)-mean_Ap)*(A(:,i)-mean_Ap)';
end

%S = S + 0.00001*diag(ones(54,1));
w = pinv(S)*(mean_Ap-mean_Am);
w = w/norm(w);

Cm = zeros(6,1);
Cp = zeros(48,1);
for i=1:6
    Cm(i) = w'*A(:,i);
end
for i=7:54
    Cp(i-6) = w'*A(:,i);
end

figure('Renderer', 'painters', 'Position', [100 100 1800 1000])
plot(Cm,zeros(6,1),'ob','linewidth',2,'markersize',10)
hold on
plot(Cp,zeros(48,1),'xr','linewidth',2,'markersize',10)
title('Fisher discriminant analysis of gene expression in mice infected with F. Tularensis','interpreter','latex')
legend('control spleen','infected spleen')
set(gca,'FontSize',22)

