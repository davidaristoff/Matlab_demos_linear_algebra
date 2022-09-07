load Kingrynormalized.mat    %load the data matrix
X = Kingrynorm;              %store the data matrix as X

[n,m] = size(X)

norm(mean(X,2))

[U S V] = svd(X,0);    %X = USV^T is the thin SVD of X
sigmas = diag(S);      %sigmas are the singular values of X
figure                 %open new figure
plot(sigmas.^2)        %plot the squares of the singular values

lams = eig(X'*X);             %lams are the eigenvalues of X^T*X
lams = sort(lams,'descend');  %sort the eigenvalues largest to smallest
norm(sigmas.^2-lams)          %compare the eigenvalues with the singular values

u1 = U(:,1);              %pull first column of U
lam1 = lams(1);           %pull first eigenvalue of XX^T
norm(X*(X'*u1)-lam1*u1)   %verify that u1 is an eigenvector with eigenvalue lam1

U_3d = U(:,1:3);    %U_3d is formed from the first three columns of U
X_3d = U_3d'*X;     %X_3d is a 3d representation of X

figure                                                        %create new figure
plot3(X_3d(1,13),X_3d(2,13),X_3d(3,13),'sy','linewidth',10)   %highlight one sample
hold on
plot3(X_3d(1,1:6),X_3d(2,1:6),X_3d(3,1:6),'b+')               %plot control lung
plot3(X_3d(1,55:60),X_3d(2,55:60),X_3d(3,55:60),'bd')         %plot control spleen
plot3(X_3d(1,7:30),X_3d(2,7:30),X_3d(3,7:30),'ro')            %plot Schu4 lung
plot3(X_3d(1,31:54),X_3d(2,31:54),X_3d(3,31:54),'gx')         %plot LVS lung
plot3(X_3d(1,61:84),X_3d(2,61:84),X_3d(3,61:84),'m^')         %plot Schu4 pleen
plot3(X_3d(1,85:108),X_3d(2,85:108),X_3d(3,85:108),'kv')      %plot LVS spleen
legend('highlighted sample','control lung','control spleen',...
    'Schu4 lung','LVS lung','Schu4 spleen','LVS spleen')      %create legend

control_spleen = X(:,55:60);    %control spleen samples
Schu4_spleen = X(:,61:84);      %Schu4 spleen samples

U = orth(control_spleen);       %columns of U are orthogonal unit vectors forming 
                                %a basis for the span of the control spleen samples
                                
v = Schu4_spleen(:,1);      %v = first Schu4 spleen sample
proj_Uv = U*(U'*v);         %proj_Uv = projection of v onto span of cols of U
norm(v - proj_Uv)           %display the distance between v and its projection

for i=1:24                      %loop over all 24 Schu4 spleen samples
    v = Schu4_spleen(:,i);      %v = ith Schu4 spleen sample
    proj_Uv = U*(U'*v);         %proj_Uv = projection of v onto span of cols of U
    norm(v - proj_Uv)           %display novelty of v with respect to cols of U
end                             %end loop