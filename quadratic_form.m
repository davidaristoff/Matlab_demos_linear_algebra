
%close all
A = input('enter 2x2 matrix: ')

figure('Renderer', 'painters', 'Position', [20 20 1000 1000]);


f = @(x) x'*A*x;
[V,D] = eig(A);
n = 100;
x = linspace(-1,1,n);
Z = zeros(n,n);
for i=1:n
    for j=1:n
        Z(i,j) = f([x(j);x(i)]);
    end
end
contourf(x,x,Z,40)
colorbar
hold on
plot(0,0,'sw','linewidth',6)
line([0 V(1,1)], [0 V(2,1)],'color','w','linewidth',2)
line([0 V(1,2)], [0 V(2,2)],'color','w','linewidth',2)
th = 0:pi/50:2*pi;
xunit = cos(th);
yunit = sin(th);
xlabel('$x_1$','interpreter','latex')
ylabel('$x_2$','interpreter','latex')
h = plot(xunit, yunit,'color','w','linewidth',2);
axis square
title('contour plot of quadratic form $q(x) = x^T A x$','interpreter','latex')
set(gca,'fontsize',22)
%colorbar
%set(gca,'ydir','normal')

    