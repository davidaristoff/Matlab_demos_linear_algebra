%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%compress a "bitmap" image using eigenvectors%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all

%read and process an image
A = imread('racecar.jpg');
A = rgb2gray(A);
A = double(A);

%extract size of matrix A
[M,N] = size(A);

%now do PCA on the image
%look at B = A^T*A -- symmetrization necessary for eigenvector basis
B = A'*A;       

%compute largest 8 eigenvalues of B, and associated eigenvectors
[V,S] = eigs(B,8);

%compute associated eigenvectors of A*A^T
U = A*V*inv(S);

%form compressed images using building blocks 
Xr = cell(8,1);
Xr{1} = S(1,1)*U(:,1)*V(:,1)';
for k=2:8
    Xr{k} = Xr{k-1}+S(k,k)*U(:,k)*V(:,k)';
end

%plot the original image and compressed images
figure('Renderer', 'painters', 'Position', [100 100 1800 1000])
subplot(3,3,1)
imagesc(A)
colormap('gray')
axis square
title('original image','interpreter','latex')
set(gca,'fontsize',18)

c = (M+N+1)/(M*N);
 
subplot(3,3,2)
imagesc(Xr{1})
colormap('gray')
axis square
title( ['compression ratio ' num2str(c)],'interpreter','latex')
set(gca,'fontsize',18)

subplot(3,3,3)
imagesc(Xr{2})
colormap('gray')
axis square
title( ['compression ratio ' num2str(2*c)],'interpreter','latex')
set(gca,'fontsize',18)

subplot(3,3,4)
imagesc(Xr{3})
colormap('gray')
axis square
title( ['compression ratio ' num2str(3*c)],'interpreter','latex')
set(gca,'fontsize',18)

subplot(3,3,5)
imagesc(Xr{4})
colormap('gray')
axis square
title( ['compression ratio ' num2str(4*c)],'interpreter','latex')
set(gca,'fontsize',18)

subplot(3,3,6)
imagesc(Xr{5})
colormap('gray')
axis square
title( ['compression ratio ' num2str(5*c)],'interpreter','latex')
set(gca,'fontsize',18)

subplot(3,3,7)
imagesc(Xr{6})
colormap('gray')
axis square
title( ['compression ratio ' num2str(6*c)],'interpreter','latex')
set(gca,'fontsize',18)

subplot(3,3,8)
imagesc(Xr{7})
colormap('gray')
axis square
title( ['compression ratio ' num2str(7*c)],'interpreter','latex')
set(gca,'fontsize',18)

subplot(3,3,9)
imagesc(Xr{8})
colormap('gray')
axis square
title( ['compression ratio ' num2str(8*c)],'interpreter','latex')
set(gca,'fontsize',18)