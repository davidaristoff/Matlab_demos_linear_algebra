%plot what a 2x2 matrix does to the unit square at the origin
%and compute determinants associated to elementary matrices

close all

A=input('Input a 2x2 matrix: \n');
A

original = figure('Renderer', 'painters', 'Position', [100 100 500 500]);
hold on
line([0 0],[0 1],'linewidth',2,'color','r')
line([0 1],[0 0],'linewidth',2,'color','b')
line([0 1],[1 1],'linewidth',2,'color',[.5 0 .5])
line([1 1],[0 1],'linewidth',2,'color',[0 .5 0])
plot(0,0,'s','linewidth',4)
plot(1,0,'d','linewidth',4)
plot(0,1,'>','linewidth',4)
plot(1,1,'h','linewidth',4)
axis([-1 2 -1 2])
axis square
title('Original square, $S$','interpreter','latex','fontsize',14)
set(gca,'FontSize',14)

mapped = figure('Renderer', 'painters', 'Position', [600 100 500 500]);
hold on
v1 = A*[1;0];
v2 = A*[0;1];
line([0 v1(1)],[0 v1(2)],'linewidth',2,'color','b')
line([0 v2(1)],[0 v2(2)],'linewidth',2,'color','r')
line([v1(1) v1(1)+v2(1)],[v1(2) v1(2)+v2(2)],'linewidth',2,'color',[0 .5 0])
line([v2(1) v2(1)+v1(1)],[v2(2) v2(2)+v1(2)],'linewidth',2,'color',[.5 0 .5])
plot(0,0,'s','linewidth',4)
plot(v1(1),v1(2),'d','linewidth',4)
plot(v2(1),v2(2),'>','linewidth',4)
plot(v1(1)+v2(1),v1(2)+v2(2),'h','linewidth',4)
a = min([v1(1)-1,v2(1)-1,v1(1)+v2(1)-1,-1]);
b = max([v1(1)+1,v2(1)+1,v1(1)+v2(1)+1,1]);
c = min([v1(2)-1,v2(2)-1,v1(2)+v2(2)-1,-1]);
d = max([v1(2)+1,v2(2)+1,v1(2)+v2(2)+1,1]);
axis([a b c d])
axis square
title('Mapped square, $A(S)$','interpreter','latex','fontsize',14)
set(gca,'FontSize',14)

B = A;
ct = 1;
chg_vol = 1;

while true

E=input(['Input a 2x2 elementary matrix, E_' num2str(ct) ':\n']);
disp('new matrix = ...')
new = E*B

if det(E)==1
    disp('shear')
else if det(E)==-1
        disp('reflection')
    else if abs(det(E)) > 1
            disp('stretch')
        else if abs(det(E)) < 1
                disp('compression')
            end
        end
    end
end
if det(E)<0 && abs(det(E))~=1
    disp('plus reflection')
end
disp(['change of volume factor corresponding to E_' num2str(ct) '=...'])
det(E)
chg_vol = chg_vol*det(E);
disp('total change of volume factor = ...')
chg_vol
            
        

 close all
if ct>1
original = figure('Renderer', 'painters', 'Position', [100 100 500 500]);
hold on
v1 = B*[1;0];
v2 = B*[0;1];
line([0 v1(1)],[0 v1(2)],'linewidth',2,'color','b')
line([0 v2(1)],[0 v2(2)],'linewidth',2,'color','r')
line([v1(1) v1(1)+v2(1)],[v1(2) v1(2)+v2(2)],'linewidth',2,'color',[0 .5 0])
line([v2(1) v2(1)+v1(1)],[v2(2) v2(2)+v1(2)],'linewidth',2,'color',[.5 0 .5])
plot(0,0,'s','linewidth',4)
plot(v1(1),v1(2),'d','linewidth',4)
plot(v2(1),v2(2),'>','linewidth',4)
plot(v1(1)+v2(1),v1(2)+v2(2),'h','linewidth',4)
a = min([v1(1)-1,v2(1)-1,v1(1)+v2(1)-1,-1]);
b = max([v1(1)+1,v2(1)+1,v1(1)+v2(1)+1,1]);
c = min([v1(2)-1,v2(2)-1,v1(2)+v2(2)-1,-1]);
d = max([v1(2)+1,v2(2)+1,v1(2)+v2(2)+1,1]);
axis([a b c d])
axis square
if ct-1 > 1
title(['Mapped square, $E_' num2str(ct-1) '\ldots E_1 A(S)$'],'interpreter','latex','fontsize',14)
else
      title('Mapped square, $E_1 A(S)$','interpreter','latex','fontsize',14)
end
set(gca,'FontSize',14)
else
original = figure('Renderer', 'painters', 'Position', [100 100 500 500]);
hold on
v1 = B*[1;0];
v2 = B*[0;1];
line([0 v1(1)],[0 v1(2)],'linewidth',2,'color','b')
line([0 v2(1)],[0 v2(2)],'linewidth',2,'color','r')
line([v1(1) v1(1)+v2(1)],[v1(2) v1(2)+v2(2)],'linewidth',2,'color',[0 .5 0])
line([v2(1) v2(1)+v1(1)],[v2(2) v2(2)+v1(2)],'linewidth',2,'color',[.5 0 .5])
plot(0,0,'s','linewidth',4)
plot(v1(1),v1(2),'d','linewidth',4)
plot(v2(1),v2(2),'>','linewidth',4)
plot(v1(1)+v2(1),v1(2)+v2(2),'h','linewidth',4)
a = min([v1(1)-1,v2(1)-1,v1(1)+v2(1)-1,-1]);
b = max([v1(1)+1,v2(1)+1,v1(1)+v2(1)+1,1]);
c = min([v1(2)-1,v2(2)-1,v1(2)+v2(2)-1,-1]);
d = max([v1(2)+1,v2(2)+1,v1(2)+v2(2)+1,1]);
axis([a b c d])
axis square
title(['Mapped square, $A(S)$'],'interpreter','latex','fontsize',14)
set(gca,'FontSize',14)
end

B = E*B;
mapped = figure('Renderer', 'painters', 'Position', [600 100 500 500]);
hold on
v1 = B*[1;0];
v2 = B*[0;1];
line([0 v1(1)],[0 v1(2)],'linewidth',2,'color','b')
line([0 v2(1)],[0 v2(2)],'linewidth',2,'color','r')
line([v1(1) v1(1)+v2(1)],[v1(2) v1(2)+v2(2)],'linewidth',2,'color',[0 .5 0])
line([v2(1) v2(1)+v1(1)],[v2(2) v2(2)+v1(2)],'linewidth',2,'color',[.5 0 .5])
plot(0,0,'s','linewidth',4)
plot(v1(1),v1(2),'d','linewidth',4)
plot(v2(1),v2(2),'>','linewidth',4)
plot(v1(1)+v2(1),v1(2)+v2(2),'h','linewidth',4)
a = min([v1(1)-1,v2(1)-1,v1(1)+v2(1)-1,-1]);
b = max([v1(1)+1,v2(1)+1,v1(1)+v2(1)+1,1]);
c = min([v1(2)-1,v2(2)-1,v1(2)+v2(2)-1,-1]);
d = max([v1(2)+1,v2(2)+1,v1(2)+v2(2)+1,1]);
axis([a b c d])
axis square
if ct > 1
title(['Mapped square, $E_' num2str(ct) '\ldots E_1 A(S)$'],'interpreter','latex','fontsize',14)
else
    title('Mapped square, $E_1 A(S)$','interpreter','latex','fontsize',14)
end
    set(gca,'FontSize',14)

original = mapped;
ct = ct+1;
end