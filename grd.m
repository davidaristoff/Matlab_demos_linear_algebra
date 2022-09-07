close all
figure
hold on
axis([-1 4 -1 4])
xticks([ -1 0 1 2 3 4])
yticks([-1 0 1 2 3 4])
line([0 0],[-4 4],'color','k','linewidth',3)
line([-4 4],[0 0],'color','k','linewidth',3)
axis square
grid on;
ax = gca
ax.GridLineStyle = '-'
ax.GridColor = 'k'
ax.GridAlpha = 1;
set(ax,'fontsize',16)

figure
hold on
plot(3,3,'.b','markersize',35)
plot(2,0,'.b','markersize',35)
plot(0,2,'.b','markersize',35)
plot(1,-1,'.b','markersize',35)
plot(-1,1,'.b','markersize',35)
plot(-1,-1,'.b','markersize',35)
plot(-3,-1,'.b','markersize',35)
plot(-1,-3,'.b','markersize',35)

axis([-5 5 -5 5])
xticks([-5 -4 -3 -2 -1 0 1 2 3 4 5])
yticks([-5 -4 -3 -2 -1 0 1 2 3 4 5])
line([0 0],[-5 5],'color','k','linewidth',3)
line([-5 5],[0 0],'color','k','linewidth',3)
legend('data','interpreter','latex','fontsize',16)
axis square
grid on;
ax = gca
ax.GridLineStyle = '-'
ax.GridColor = 'k'
ax.GridAlpha = 1;
set(ax,'fontsize',16)