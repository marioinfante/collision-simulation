function outvar=Draw_Disks(l,x,y,a,b,r)
n=100;
for i=1:n
theta=i*(2*pi/n);
X(i)=x+r*cos(theta);
Y(i)=y+r*sin(theta);
A(i)=a+r*cos(theta);
B(i)=b+r*sin(theta);
end
fill(X,Y,'r',A,B,'b'); % fills (in red 'r') the 2-D polygon defined by vectors X and Y
axis equal;
limits = [0 l/2 0 l];
axis (limits);
title('Billiard Simulation','FontSize',14);
set(gca,'xtick',[]); set(gca,'xticklabel',[]);
set(gca,'ytick',[]); set(gca,'yticklabel',[]);
end