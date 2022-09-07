%plot 3 planes of the form Ax+By+Cz=D. Note: C can't be zero for plotting!

As = [2 1 4];
Bs = [-1 0 -1];
Cs = [1 -2 -4];
Ds = [4 6 16];

disp('linear system is...')
[As',Bs',Cs',Ds']
disp('in reduced echelon form this is...')
rref([As',Bs',Cs',Ds'])

close all

for i=1:3
    A = As(i);
    B = Bs(i);
    C = Cs(i);
    D = Ds(i);
    [x y] = meshgrid(-10:1:10);  %generate x and y data
    z = -1/C.*(A*x + B*y - D);    %solve for z data
    surf(x,y,z)                  %plot the surface
    %xlim([-10 10])
    %ylim([-10 10])
    %zlim([-10 10])
    hold on
end