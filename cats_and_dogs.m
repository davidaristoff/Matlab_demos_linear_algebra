%Experiment with projecting cat and dog images onto spans of cats/dogs

close all
load CatsDogsData.mat
X = Y;                  %store data matrix as X
[n,m] = size(X)         %evaluate size of X

%Columns 1-99 of X are images of cats.
%Columns 100-198 of X are images of dogs.

%Each column has 64^2 entries of a "flattened" image.
%Use matlab's "reshape" command to undo the flattening.

figure('Renderer', 'painters', 'Position', [100 100 1600 1000])
subplot(1,2,1)
imagesc(reshape(X(:,1),64,64))     %plot first cat
xlabel('first cat')
set(gca,'fontsize',18)
subplot(1,2,2)
imagesc(reshape(X(:,100),64,64))    %plot first dog
xlabel('first dog')
set(gca,'fontsize',18)

U = X(:,1:5);          %pull first 5 columns of X (i.e., first 5 cats)
U = orth(U);           %cols of U = orthogonal unit vectors 
                       %forming a basis for the span of the first 5 cats

v = X(:,109);          %v = 6th dog
proj_Uv = U*U'*v;      %proj_Uv = projection of last dog onto span of first 5 cats

figure('Renderer', 'painters', 'Position', [100 100 1600 1000])
subplot(1,2,1)
imagesc(reshape(v,64,64))
xlabel('10th dog')
set(gca,'fontsize',18)
subplot(1,2,2)
imagesc(reshape(proj_Uv,64,64))
xlabel('projection of 10th dog onto span of first 5 cats')
set(gca,'fontsize',18)

W = X(:,100:104);      %pull first 5 dogs
W = orth(W);           %cols of W = orthogonal unit vectors
                       %forming a basis for the span of the first 5 dogs

proj_Wv = W*W'*v;      %proj_Wv = projection of last dog onto span of first 5 dogs

figure('Renderer', 'painters', 'Position', [100 100 1600 1000])
subplot(1,2,1)
imagesc(reshape(v,64,64))
xlabel('10th dog')
set(gca,'fontsize',18)
subplot(1,2,2)
imagesc(reshape(proj_Wv,64,64))
xlabel('projection of 10th dog onto span of first 5 dogs')
set(gca,'fontsize',18)

%now compare novelties

disp('novelty for projection of dog onto cats = ...')
norm(v - proj_Uv)
disp('novelty for projection of dog onto dogs = ...')
norm(v - proj_Wv)



