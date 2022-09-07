%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%compress a "bitmap" image using JPEG algorithm%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all

%read and process an image 
A = imread('racecar.jpg');
A = rgb2gray(A);
A = double(A);

%extract size of A (m = number of rows, m = number of columns)
[M,N] = size(A);

%define change of basis matrix, TM, for the range of A
TM = zeros(M,M);
for p=1:M-1
    for q=0:M-1
        TM(p+1,q+1) = sqrt(2/M)*cos(pi*(2*q+1)*p/(2*M));
    end
end
for q=0:M-1
    TM(1,q+1) = 1/sqrt(M);
end

%define change of basis matrix, TN, for the domain of A
TN = zeros(N,N);
for p=1:N-1
    for q=0:N-1
        TN(p+1,q+1) = sqrt(2/N)*cos(pi*(2*q+1)*p/(2*N));
    end
end
for q=0:N-1
    TN(1,q+1) = 1/sqrt(N);
end

%change coordinates from standard to "cosine basis" coordinates
B = TM*A*TN';
%B is the same as A, but written in the "cosine basis" coordinates
%Note: TN' = inv(TN), and TM' = inv(TM) since these are orthonormal bases

%form compressed images by keeping only the lower frequencies
Xr = cell(8,1);    %Xr = 8 reconstructed images (cell array)
del = 1000;        %del = factor for increasing resolution between images 
r = zeros(8,1);    %compression ratios

for k=1:8 
    %store compression ratio
    r(k) = (k/24)^2;
    
    %form compressed matrix in frequency space, by zeroing out fast modes
    B_ = zeros(M,N);
    B_(1:floor(k*M/24),1:floor(k*N/24)) = ... 
        B(1:floor(k*M/24),1:floor(k*N/24));
    
    %change back to standard coordinates
    Xr{k} = TM'*B_*TN;
end

%plot the original image and compressed images
figure('Renderer', 'painters', 'Position', [100 100 1800 1000])
subplot(3,3,1)
imagesc(A)
colormap('gray')
axis square
title('original image','interpreter','latex')
set(gca,'fontsize',18)

subplot(3,3,2)
imagesc(Xr{1},[0 200])
colormap('gray')
axis square
title( ['compression ratio ' num2str(r(1))],'interpreter','latex')
set(gca,'fontsize',18)

subplot(3,3,3)
imagesc(Xr{2},[0 200])
colormap('gray')
axis square
title( ['compression ratio ' num2str(r(2))],'interpreter','latex')
set(gca,'fontsize',18)

subplot(3,3,4)
imagesc(Xr{3},[0 200])
colormap('gray')
axis square
title( ['compression ratio ' num2str(r(3))],'interpreter','latex')
set(gca,'fontsize',18)

subplot(3,3,5)
imagesc(Xr{4},[0 200])
colormap('gray')
axis square
title( ['compression ratio ' num2str(r(4))],'interpreter','latex')
set(gca,'fontsize',18)

subplot(3,3,6)
imagesc(Xr{5},[0 200])
colormap('gray')
axis square
title( ['compression ratio ' num2str(r(5))],'interpreter','latex')
set(gca,'fontsize',18)

subplot(3,3,7)
imagesc(Xr{6},[0 200])
colormap('gray')
axis square
title( ['compression ratio ' num2str(r(6))],'interpreter','latex')
set(gca,'fontsize',18)

subplot(3,3,8)
imagesc(Xr{7},[0 200])
colormap('gray')
axis square
title( ['compression ratio ' num2str(r(7))],'interpreter','latex')
set(gca,'fontsize',18)

subplot(3,3,9)
imagesc(Xr{8},[0 200])
colormap('gray')
axis square
title( ['compression ratio ' num2str(r(8))],'interpreter','latex')
set(gca,'fontsize',18)