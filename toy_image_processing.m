close all

%define a black and white image using a matrix, A
A = [0 0 0 0 0 0 0 0;
     0 0 0 1 1 0 0 0;
     0 0 1 0 0 1 0 0;
     0 1 0 1 1 0 1 0; 
     0 1 0 1 1 0 1 0; 
     0 0 1 0 0 1 0 0; 
     0 0 0 1 1 0 0 0; 
     0 0 0 0 0 0 0 0];
 
% A = [0 0 0 0 0 0 0 1;
%      0 0 0 1 1 0 1 0;
%      0 0 1 0 0 1 0 0;
%      0 1 0 1 1 0 1 0; 
%      0 1 0 1 1 0 1 0; 
%      0 0 1 0 0 1 0 0; 
%      0 1 0 1 1 0 0 0; 
%      1 0 0 0 0 0 0 0];
 
 %plot the image
 figure
 imagesc(A)
 axis square
 colormap gray
 colorbar
 title('original image','interpreter','latex')
 set(gca,'fontsize',18)
 
 [V,D] = eigs(A,8) 
 lams = diag(D);
 %columns of V = eigenvectors
  
 v1 = V(:,1) 
 %extract first eigenvector
 
 lam1 = D(1,1)
 %extract first eigenvalue
 
 block1 = lam1*v1*v1'
 %extract first ``building block''
 
 %check that block1 = V*D1*inv(V) 
 %where D1 is a diagonal matrix with only the 1st eigenvalue
 
 block2 = lams(2)*V(:,2)*V(:,2)';
 block3 = lams(3)*V(:,3)*V(:,3)';
 block4 = lams(4)*V(:,4)*V(:,4)';
 block5 = lams(5)*V(:,5)*V(:,5)';
 block6 = lams(6)*V(:,6)*V(:,6)';
 block7 = lams(7)*V(:,7)*V(:,7)';
 block8 = lams(8)*V(:,8)*V(:,8)';
 %extract the other ``building blocks''
 
 %plot some different blocks
 %imagesc(block1)    %uncomment/change the block number here
 axis square
 colormap gray
 colorbar
 
 %now plot combined blocks
 figure('Renderer', 'painters', 'Position', [100 100 1600 1000])
 
 subplot(2,4,1)
 imagesc(block1)
 axis square
 colormap gray
 colorbar
 title('first block','interpreter','latex')
 set(gca,'fontsize',18)
 
 block2 = lams(2)*V(:,2)*V(:,2)';
 block3 = lams(3)*V(:,3)*V(:,3)';
 block4 = lams(4)*V(:,4)*V(:,4)';
 %extract some other ``building blocks''
 
 %now plot the combined building blocks
 subplot(2,4,2)
 imagesc(block1+block2)
 axis square
 colormap gray
 colorbar
 title('first two blocks','interpreter','latex')
 set(gca,'fontsize',18)
 
 subplot(2,4,3)
 imagesc(block1+block2+block3)
 axis square
 colormap gray
 colorbar
 title('first three blocks','interpreter','latex')
 set(gca,'fontsize',18)
 
 subplot(2,4,4)
 imagesc(block1+block2+block3+block4)
 axis square
 colormap gray
 colorbar
 title('first four blocks','interpreter','latex')
 set(gca,'fontsize',18)
 
 subplot(2,4,5)
 imagesc(block1+block2+block3+block4+block5)
 axis square
 colormap gray
 colorbar
 title('first five blocks','interpreter','latex')
 set(gca,'fontsize',18)
 
 subplot(2,4,6)
 imagesc(block1+block2+block3+block4+block5+block6)
 axis square
 colormap gray
 colorbar
 title('first six blocks','interpreter','latex')
 set(gca,'fontsize',18)
 
 subplot(2,4,7)
 imagesc(block1+block2+block3+block4+block5+block6+block7)
 axis square
 colormap gray
 colorbar
 title('first seven blocks','interpreter','latex')
 set(gca,'fontsize',18)
 
 subplot(2,4,8)
 imagesc(block1+block2+block3+block4+block5+block6+block7+block8)
 axis square
 colormap gray
 colorbar
 title('all eight blocks','interpreter','latex')
 set(gca,'fontsize',18)
