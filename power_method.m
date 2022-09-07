A = [2 1; 1 2];
P = [1 -1; 1 1];
D = [3 0; 0 1];

disp('original matrix = ...')
A
disp('change of basis eigenvector matrix = ...')
P
disp('matrix A in eigenvector coordinates = ...')
D

A = A^10;
D = D^10;

while true 
    
close all
figure('Renderer', 'painters', 'Position', [100 100 1600 1000])
hold on

u = [1 0];
v = [0 1];
vec = [0 0;u;v;u+v];
m = min(vec);
M = max(vec);

subplot(1,2,1)
line([0 u(1)],[0 u(2)],'color','b','linewidth',2)
line([0 v(1)],[0 v(2)],'color','r','linewidth',2)
line([u(1) u(1)+v(1)],[u(2) u(2)+v(2)],'color','k','linestyle',':','linewidth',2)
line([v(1) v(1)+u(1)],[v(2) v(2)+u(2)],'color','k','linestyle',':','linewidth',2)
title('square $S$','interpreter','latex')
grid on
axis square
set(gca,'fontsize',18)
axis([m(1)-1 M(1)+1 m(2)-1 M(2)+1])

u = [1 0]*A';
v = [0 1]*A';
vec = [0 0;u;v;u+v];
m = min(vec);
M = max(vec);

subplot(1,2,2)
line([0 u(1)],[0 u(2)],'color','b','linewidth',2)
line([0 v(1)],[0 v(2)],'color','r','linewidth',2)
line([u(1) u(1)+v(1)],[u(2) u(2)+v(2)],'color','k','linestyle',':','linewidth',2)
line([v(1) v(1)+u(1)],[v(2) v(2)+u(2)],'color','k','linestyle',':','linewidth',2)
title('image $A^{10}(S)$','interpreter','latex')
grid on
axis square
set(gca,'fontsize',18)
axis([m(1)-1 M(1)+1 m(2)-1 M(2)+1])
pause(5)
    
close all
figure('Renderer', 'painters', 'Position', [100 100 1600 1000])
hold off

%subplot(1,3,3)
%hold off

uold = [1 0];
vold = [0 1];
unew = [1 0]*inv(P)';
vnew = [0 1]*inv(P)';
vec1 = [0 0;uold;vold;uold+vold;unew;vnew;unew+vnew];
m = min(vec1);
M = max(vec1);

h(1) = line([0 1],[0 0],'color','b','linewidth',2);
h(2) = line([0 0],[0 1],'color','r','linewidth',2);
h(3) = line([1 1],[0 1],'color','k','linestyle',':','linewidth',2);
h(4) = line([0 1],[1 1],'color','k','linestyle',':','linewidth',2);
title('original square, standard coordinates','interpreter','latex')
grid on
axis square
set(gca,'fontsize',18)
axis([m(1)-1 M(1)+1 m(2)-1 M(2)+1])
pause(2)
delete(h(1:4))

t = 0;
while t<1.01
    if t>0
        delete(h(1:4))
    end
    u = (1-t)*uold + t*unew;
    v = (1-t)*vold + t*vnew;
    h(1) = line([0 u(1)],[0 u(2)],'color','b','linewidth',2);
    h(2) = line([0 v(1)],[0 v(2)],'color','r','linewidth',2);
    h(3) = line([u(1) u(1)+v(1)],[u(2) u(2)+v(2)],'color','k','linestyle',':','linewidth',2);
    h(4) = line([v(1) v(1)+u(1)],[v(2) v(2)+u(2)],'color','k','linestyle',':','linewidth',2);
    title('changing to eigenvector coordinates (multiply by $P^{-1}$)','interpreter','latex')
    grid on
    axis square
    set(gca,'fontsize',18)
    axis([m(1)-1 M(1)+1 m(2)-1 M(2)+1])
    pause(0.01)
    t = t + 0.01;
end

uold = [1 0]*inv(P)';
vold = [0 1]*inv(P)';
unew = [1 0]*inv(P)'*D';
vnew = [0 1]*inv(P)'*D';
vec2 = [0 0;uold;vold;uold+vold;unew;vnew;unew+vnew];
m = min([vec1;vec2]);
M = max([vec1;vec2]);
t = 0; 
while t<1.01
    if t==0 
        pause(2)
    end
    delete(h(1:4))
    u = (1-t)*uold + t*unew;
    v = (1-t)*vold + t*vnew;
    h(1) = line([0 u(1)],[0 u(2)],'color','b','linewidth',2);
    h(2) = line([0 v(1)],[0 v(2)],'color','r','linewidth',2);
    h(3) = line([u(1) u(1)+v(1)],[u(2) u(2)+v(2)],'color','k','linestyle',':','linewidth',2);
    h(4) = line([v(1) v(1)+u(1)],[v(2) v(2)+u(2)],'color','k','linestyle',':','linewidth',2);
    title("mapping in eigenvector coordinates, with eigenvalues $3^{10}$, $1$ (multiply by $D^{10}$)",'interpreter','latex')
    grid on
    axis square
    set(gca,'fontsize',18)
    axis([m(1)-1 M(1)+1 m(2)-1 M(2)+1])
    pause(0.01)
    t = t + 0.01;
end

uold = [1 0]*inv(P)'*D';
vold = [0 1]*inv(P)'*D';
unew = [1 0]*A';
vnew = [0 1]*A';
vec3 = [0 0;uold;vold;uold+vold;unew;vnew;unew+vnew];
m = min([vec1;vec2;vec3]);
M = max([vec1;vec2;vec3]);
t = 0; 
while t<1.01
    if t==0
        pause(2)
    end
    delete(h(1:4))
    u = (1-t)*uold + t*unew;
    v = (1-t)*vold + t*vnew;
    h(1) = line([0 u(1)],[0 u(2)],'color','b','linewidth',2);
    h(2) = line([0 v(1)],[0 v(2)],'color','r','linewidth',2);
    h(3) = line([u(1) u(1)+v(1)],[u(2) u(2)+v(2)],'color','k','linestyle',':','linewidth',2);
    h(4) = line([v(1) v(1)+u(1)],[v(2) v(2)+u(2)],'color','k','linestyle',':','linewidth',2);
    title('changing back to standard coordinates (multiply by $P$)','interpreter','latex')
    grid on
    axis square
    set(gca,'fontsize',18)
    axis([m(1)-1 M(1)+1 m(2)-1 M(2)+1])
    pause(0.01)
    t = t + 0.01;
end
pause(5)

end
