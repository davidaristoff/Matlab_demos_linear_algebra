A = [0     1     0     0     1
     0     0     1     0     1
     1     0     0     1     0
     0     0     1     0     1
     0     1     0     0     1];
 
 P = A./sum(A,2);
 [mu,lam] = eigs(P');
 vec = null(P'-eye(5)).^2;
 
 close all
 G = digraph(P);
 x = 1;
 h = plot(G,'linewidth',2,'markersize',10,'nodefontsize',18,'arrowsize',20);
 highlight(h,x,'NodeColor','g','markersize',12);
 pause(5)
 
 for t=1:1000
     y = find(rand < cumsum(P(x,:)),1);
     if x~=y
         path = shortestpath(G,x,y);
     else 
         path = [y y];
     end
     h = plot(G,'linewidth',2,'markersize',10,'nodefontsize',18,'arrowsize',20);
     highlight(h,path,'EdgeColor','r')
     x = y;
     highlight(h,x,'NodeColor','g','markersize',12);
     pause(.5)
 end
    
 
