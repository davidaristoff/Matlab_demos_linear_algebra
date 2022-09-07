%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set up and simulate a 1D random walk (i.e., Markov chain) 
%that mimicks ``Brownian dynamics,'' a molecular dynamics model
%based on a potential energy V and inverse temperature bta
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%define parameters for random walk
T = 10^4;                                       %T = total # of RW steps
N = 100;                                        %N = mesh size
dt = 0.001;                                     %dt = step size
bta = 5;                                       %bta = inverse temperature       
U = @(x) 1/2+100*(x-1/4).^2.*(x-3/4).^2;        %U = potential energy
F = @(x) -200*(x-1/4).*(x-3/4).^2 ...           %F = force = -V'
    -200*(x-3/4).*(x-1/4).^2;         

%construct transition matrix for random walk
P = zeros(N,N);    %transition matrix
for i=1:N
    for j=1:N
        x = i/N;   %convert discrete state i into mesh point x
        y = j/N;   %convert discrete state j into mesh point y
        P(i,j) = exp(-(x-(y+F(y)*dt))^2/(4*dt/bta));
                   %P(i,j) is Gaussian centered at y-F(y)*dt
    end
end
P = P./sum(P);     %normalize transition matrix

%now do a spectral analysis
[V,D] = eigs(P,10);         %V = eigenvector matrix, D = eigenvalue matrix
v1 = V(:,1)/sum(V(:,1));    %v1 = stationary distribution
v2 = V(:,2)/sum(V(:,2));
v3 = V(:,3)/sum(V(:,3));
disp('largest 10 eigenvalues = ...')
lam = diag(D)
disp('implied largest timescale = 1/(1-lam(2)) = ...')
1/(lam(2)*dt)

%simulate and plot dynamics of Markov chain
close all
figure('Renderer', 'painters', 'Position', [20 20 1800 1000]);
xs = linspace(1/N,1,N);
plot(xs,U(xs),'-b','linewidth',2)
hold on
h(1)=plot(x,0,'.','markersize',50,'color',[0 .5 0]);
legend('potential energy','current RW position','fontsize',24,...
       'interpreter','latex','autoupdate','off')
title('Brownian dynamics = gradient descent + fluctuations',...
       'fontsize',24,'interpreter','latex')
line([0 1],[0 0],'color','k','linewidth',2)
axis([0 1 -1/2 3/2])
set(gca,'ytick',[])
set(gca,'xtick',[])

%loop over T steps of random walk
xi = 25;                  %initial position of RW
for t=1:T
    x = xi/N;
    delete(h(1:end))
    h(1) = plot(x,0,'.','markersize',50,'color',[0 .5 0]);
    h(2) = plot(x,U(x),'.r','markersize',50);
    xi = find((rand<cumsum(P(:,xi))),1);    %sample next position of RW
    pause(0.01)
end

