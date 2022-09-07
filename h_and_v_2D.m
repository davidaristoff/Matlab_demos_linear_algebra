close all

%periodic potential
%pot = @(x,y) sin(4*pi*x).*sin(4*pi*y);
%F = @(x,y) -[4*pi*cos(4*pi*x).*sin(4*pi*y), ... 
%             4*pi*cos(4*pi*y).*sin(4*pi*x)];

%trapping potential
%pot = @(x,y) (1-heaviside(norm([x,y]-[0.5,0.5])-0.5)) ... 
%             .*exp(-0.1/(norm([x,y]-[0.5,0.5])-0.5).^2);

%entropic barrier potential
a1 = 51;
b1 = 49;
a2 = 16;
b2 = 15;
pot = @(x,y) exp(-(a1*(x-0.5).^2+a1*(y-0.5).^2+2*b1*(x-0.5).*(y-0.5))) ... 
            -0.3*exp(-(a2*(x-0.5).^2+a2*(y-0.5).^2-2*b2*(x-0.5).*(y-0.5)));
F = @(x,y) -[4*pi*cos(4*pi*x).*sin(4*pi*y), ... 
             4*pi*cos(4*pi*y).*sin(4*pi*x)];

dt = 0.002;
bta = 5;
sig = sqrt(2*dt/bta);

n = 50;
P = zeros(n,n,n,n);
U = zeros(n,n);
for i=1:n
    i/n
    for j=1:n
        U(i,j) = pot((i-0.5)/n,(j-0.5)/n);
        if i>n-5 && j>n-5
            P(i,j,1,1) = 1;
        else
        for k=1:n
            for l=1:n
                x = (i-0.5)/n;
                y = (j-0.5)/n;
                z = (k-0.5)/n;
                w = (l-0.5)/n;
                P(i,j,k,l) = ...
                exp(-norm([z w] - ([x y] + F(x,y)*dt))^2/(2*sig^2));
            end
        end
        end
    end
end

f = [zeros(n,n-5),[zeros(n-5,5);ones(5,5)]];

P = reshape(P,n^2,n^2);
P = P./sum(P,2);
f = reshape(f,n^2,1);

[mu,lam] = eigs(P',1);
mu = mu/sum(mu);

h = linsolve(eye(n^2)-P-mu*mu',f-(mu'*f)*ones(n^2,1));
v = sqrt(P*h.^2-(P*h).^2);
Ph = P*h;

Ph = reshape(Ph,n,n);
h = reshape(h,n,n);
v = reshape(v,n,n);
mu = reshape(mu,n,n);

figure
imagesc(h)
set(gca,'YDir','normal')
colorbar
set(gca,'colorscale','log')
title('h')

figure
imagesc(v)
set(gca,'YDir','normal')
colorbar
set(gca,'colorscale','log')
title('v')

figure
imagesc(mu.*v)
set(gca,'YDir','normal')
colorbar
set(gca,'colorscale','log')
title('$\mu v$','interpreter','latex')

figure
imagesc(U)
set(gca,'YDir','normal')
colorbar
title('U')

figure
surf(U)