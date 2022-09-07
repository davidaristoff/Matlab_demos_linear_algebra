%analyze F Tularensis mouse data set

close all 

load Kingrynormalized.mat
X = Kingrynorm;
disp('find dimensions of data matrix')
[n,m] = size(X)
disp('check that data is centered, i.e. has mean zero')
norm(mean(X,2))

%plot the data matrix 

% figure
% imagesc(X)
% colorbar
% title('data matrix of mice infected with F. Tularensis','interpreter','latex')
% xlabel('samples','interpreter','latex')
% ylabel('gene expression','interpreter','latex')
% set(gca,'ydir','normal')
% set(gca,'FontSize',22)

%compute SVD and plot singular values

[U S V] = svd(X,0);    %take "thin" SVD of X
sigmas = diag(S);
figure
plot(sigmas.^2)

%check that singular values are square roots of eigenvalues of X^TX

disp('check that singular values are square roots of eigenvalues of X^TX')
lams = eig(X'*X);
lams = sort(lams,'descend');
norm(sigmas.^2-lams)

%check that columns of U are eigenvectors of XX^T

disp('check that first column of U is an eigenvector of XX^T')
u1 = U(:,1);       %pull first column of U
lam1 = lams(1);    %pull first eigenvalue of XX^T
norm(X*(X'*u1)-lam1*u1)    %this value should be "numerically zero"
%now repeat for a few other columns of U

%now project X onto the span of the first three eigenvectors of XX^T

U_3d = U(:,1:3);    %pull the first three columns of U
X_3d = U_3d'*X;     %project X onto the column span of U_3d

%then plot the results. This is a 3d PCA plot

figure
plot3(X_3d(1,13),X_3d(2,13),X_3d(3,13),'sy','linewidth',40)
hold on
plot3(X_3d(1,1:6),X_3d(2,1:6),X_3d(3,1:6),'b+')
plot3(X_3d(1,55:60),X_3d(2,55:60),X_3d(3,55:60),'bd')
plot3(X_3d(1,7:30),X_3d(2,7:30),X_3d(3,7:30),'ro')
plot3(X_3d(1,31:54),X_3d(2,31:54),X_3d(3,31:54),'gx')
plot3(X_3d(1,61:84),X_3d(2,61:84),X_3d(3,61:84),'m^')
plot3(X_3d(1,85:108),X_3d(2,85:108),X_3d(3,85:108),'kv')
legend('highlighted sample','control lung','control spleen',...
    'Schu4 lung','LVS lung','Schu4 spleen','LVS spleen')

%now analyze the spleen data
%project the Schu4 spleen data onto the span of the control spleen data
%and analyze the associated "novelties"
%then repeat for the LVS spleen data.

control_spleen = X(:,55:60);  %pull uninfected spleen samples
Schu4_spleen = X(:,61:84);    %pull Schu4 infected spleen samples
LVS_spleen = X(:,85:108);     %pull LVS infected spleen samples

U = orth(control_spleen);
a = 0;
for i=1:24
    v = Schu4_spleen(:,i);      %v = ith Schu4 spleen sample
    proj_Uv = U*(U'*v);         %proj_Uv = projection of v onto Im(U)
    norm(v - proj_Uv);          %display norm of v-proj_Uv
    a = a + norm(v - proj_Uv);
end
a = a/24

b = 0;
for i=1:24
    v = LVS_spleen(:,i);        %v = ith Schu4 spleen sample
    proj_Uv = U*(U'*v);         %proj_Uv = projection of v onto Im(U)
    norm(v - proj_Uv);          %display norm of v-proj_Uv
    b = b + norm(v - proj_Uv);
end
b = b/24

c = 0;
for i=1:6
    samples = [1:i-1,i+1:6]; 
    U = orth(control_spleen(:,samples));
    v = control_spleen(:,i);
    proj_Uv = U*(U'*v);
    norm(v-proj_Uv);
    c = c + norm(v-proj_Uv);
end
c = c/6

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

% figure('Renderer', 'painters', 'Position', [100 100 1800 1000])
% plot(Cm,zeros(6,1),'ob','linewidth',2)
% hold on
% plot(Cp,zeros(48,1),'xr','linewidth',2)
% title('Fisher discriminant analysis of gene expression in mice infected with F. Tularensis','interpreter','latex')
% legend('control spleen','infected spleen')
% set(gca,'FontSize',22)

