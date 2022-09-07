
close all

%try inputs: u = [1;0;0], v = [0;1;0], w = [1/2;2;1]
%try inputs: u = [1;1;0], v = [0;1;1], w = [1;1;2]

u = input('input a vector: ');
v = input('input another vector: ');

disp('orthogonal basis for the plane, S, spanned by these vectors ...')
if dot(u,v)~=0
    orthonormal_basis = orth([u v]);
    if(sum(sum(orthonormal_basis))<0)
        orthonormal_basis = -orthonormal_basis;
    end
else
    orthonormal_basis = [u v];
end
orthonormal_basis
 
w = input('input a vector to project onto S: ')

while(true)

    close all
u = orthonormal_basis(:,1);
v = orthonormal_basis(:,2);
n = cross(u,v);
wu = dot(w,u)*u;     %projection of w onto u
wv = dot(w,v)*v;     %projection of w onto v
wuv = wu + wv;
mx = min([0;u(1);v(1);w(1);wu(1);wv(1);wuv(1)])-0.2;
Mx = max([0;u(1);v(1);w(1);wu(1);wv(1);wuv(1)])+0.2;
my = min([0;u(2);v(2);w(2);wu(2);wv(2);wuv(2)])-0.2;
My = max([0;u(2);v(2);w(2);wu(2);wv(2);wuv(2)])+0.2;

h = zeros(7,1);
figure('Renderer', 'painters', 'Position', [100 50 1800 900])
h(1) = plot3([0 u(1)],[0 u(2)],[0 u(3)],':b','linewidth',7);
hold on
h(2) = plot3([0 v(1)],[0 v(2)],[0 v(3)],':r','linewidth',7);
h(3) = plot3([0 w(1)],[0 w(2)],[0 w(3)],'linestyle',':','color',[0 .5 0],'linewidth',7);

[x y] = meshgrid(linspace(mx,Mx,20),linspace(my,My,20));
z = -1/n(3).*(n(1)*x + n(2)*y);
h(4) = surf(x,y,z,'facecolor','none','edgecolor','m');

xlabel('$x$','interpreter','latex')
ylabel('$y$','interpreter','latex')
zlabel('$z$','interpreter','latex')
legend(h(1:4),' basis vector $u$',' basis vector $v$', ... 
    ' vector $w$ to project onto $S$','plane $S$', 'interpreter','latex','autoupdate','off')
title('projecting $w$ onto $S = \textup{span}\{u,v\}$','interpreter','latex')
set(gca,'fontsize',20)
pause(3)

handle = [];

T = 10^2;
for t=0:T
    wut = (t/T)*wu + (1-t/T)*w;
    if t>0
    delete(handle)
    end
    handle = plot3([w(1) wut(1)],[w(2) wut(2)],[w(3) wut(3)], ...
             ':k','linewidth',3);
    pause(0.02)
end
h(5) = plot3([0 wu(1)],[0 wu(2)],[0 wu(3)],'-b','linewidth',3);

title("$\textup{proj}_u w =  ($" + dot(w,u) + "$)u$", ...
            'interpreter','latex')
legend(h(1:5),' basis vector $u$',' basis vector $v$', ... 
    ' vector $w$ to project onto $S$','plane $S$','$\textup{proj}_u w$', ... 
    'interpreter','latex')

for t=0:T
    wvt = (t/T)*wv + (1-t/T)*w;
    if t>0
    delete(handle)
    end
    handle = plot3([w(1) wvt(1)],[w(2) wvt(2)],[w(3) wvt(3)], ...
             ':k','linewidth',3);
    pause(0.02)
end
h(6) = plot3([0 wv(1)],[0 wv(2)],[0 wv(3)],'-r','linewidth',3);
title("$\textup{proj}_u w =  ($" + dot(w,u) + "$)u, \,\,\textup{proj}_v w =  ($" + dot(w,v) + "$)v$", ...
            'interpreter','latex')
legend(h(1:6),' basis vector $u$',' basis vector $v$', ... 
    ' vector $w$ to project onto $S$','plane $S$','$\textup{proj}_u w$', ... 
    '$\textup{proj}_v w$', ... 
    'interpreter','latex')

for t=0:T
    wuvt = (t/T)*wuv + (1-t/T)*w;
    if t>0
    delete(handle)
    end
    handle = plot3([w(1) wuvt(1)],[w(2) wuvt(2)],[w(3) wuvt(3)], ...
             ':k','linewidth',3);
    pause(0.02)
end
h(7) = plot3([0 wuv(1)],[0 wuv(2)],[0 wuv(3)],'-','color', ... 
    [.5 0 .5],'linewidth',3);
legend(h(1:7),' basis vector $u$',' basis vector $v$', ... 
    ' vector $w$ to project onto $S$','plane $S$','$\textup{proj}_u w$', ... 
    '$\textup{proj}_v w$', ... 
    '$\textup{proj}_S w$', ... 
    'interpreter','latex')

title("$\textup{proj}_u w =  ($" + dot(w,u) + "$)u, \,\,\textup{proj}_v w =  ($" + dot(w,v) + "$)v, \,\, \textup{proj}_S w =  ($" + dot(w,u) + "$)u + ($" + dot(w,v) + "$)v$", ...
            'interpreter','latex')
pause(4)
legend(h(1:7),' basis vector $u$',' basis vector $v$', ... 
    ' vector $w$ to project onto $S$','plane $S$','$\textup{proj}_u w$', ... 
    '$\textup{proj}_v w$', ... 
    '$\textup{proj}_S w = \textup{proj}_u w + \textup{proj}_v w$', ... 
    'interpreter','latex')

plot3([wu(1) wuv(1)],[wu(2) wuv(2)],[wu(3) wuv(3)],':b','linewidth',3)
plot3([wv(1) wuv(1)],[wv(2) wuv(2)],[wv(3) wuv(3)],':r','linewidth',3)
set(gca,'fontsize',20)

pause(6)

end

