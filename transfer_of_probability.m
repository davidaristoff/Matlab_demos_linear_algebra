%plots transfer of probability for a simple random walk

N = 20;           %N = number of states
P = zeros(N,N);   %P = Markov transition matrix
for n=1:N
    P(n,max(n-1,1)) = 1/2;
    P(n,min(n+1,N)) = 1/2;
end
close all
figure('Renderer', 'painters', 'Position', [50 50 900 500])
subplot(1,2,1)
hold on
line([1 N],[0 0],'linewidth',2)
for n=1:N
    plot(n,0,'.r','Markersize',18)
end
axis([0 N+1 -1 1])
set(gca,'Xtick',[])
set(gca,'Ytick',[])
title(['Simple random walk on ',num2str(N),' states'],...
    'interpreter','latex','fontsize',14)

subplot(1,2,2)
mu = [1,zeros(1,N-1)];  %mu = initial probability distribution
z = linspace(1,N,N);    %z = vector of states
plot(z,mu,'.','markersize',18)
pause(5)
title('Probability after $0$ steps','fontsize',14,'interpreter','latex')
axis([0 N+1 0 1])
T = 1000;               %T = total number of steps of random walk
for t=1:T
    mu = mu*P;
    plot(z,mu,'.','markersize',18)
    axis([0 N+1 0 1])
    title(['Probability after ',num2str(t),' steps'],...
    'interpreter','latex','fontsize',14)
    pause(0.01)
end


