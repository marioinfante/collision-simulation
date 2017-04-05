r = 0.1; % radius
t = 0;
dt = 0.03; % time step
a = 0.8; % normal damping
b = 0.99; % tangential damping
t_final = 5;
u1 = 0.5;
v1 = 1;
x1 = r;
y1 = r;
u2 = 0;
v2 = 0;
x2 = l/4;
y2 = l/2;
l = 2;
while t < t_final
if t+dt > t_final
dt = t_final - t;
end
% update positions
x1 = x1 + dt*u1;
y1 = y1 + dt*v1;
x2 = x2 + dt*u2;
y2 = y2 + dt*v2;
%left wall
if(x1 + r >= l/2)
u1 = a * -u1;
v1 = b * v1;
x1 = l/2 - r;
end
if(x2 + r >= l/2)
    u2 = a * -u2;
v2 = b * v2;
x2 = l/2 - r;
end
%right wall
if(x1 - r <= 0)
u1 = a * -u1;
v1 = b * v1;
x1 = r;
end
if(x2 - r <= 0)
u2 = a * -u2;
v2 = b * v2;
x2 = r;
end
%bottom wall
if(y1 + r >= l)
v1 = a * -v1;
u1 = b * u1;
y1 = l - r;
end
if(y2 + r >= l)
v2 = a * -v2;
u2 = b * u2;
y2 = l - r;
end
%top wall
if(y1 - r <= 0)
v1 = a * -v1;
u1 = b * u1;
y1 = r;
end
if(y2 - r <= 0)
v2 = a * -v2;
u2 = b * u2;
y2 = r;
end
if(sqrt((x2 - x1)^2 + (y2 - y1)^2) - 2*r <= 0)
tempdt = dt;
dt = (sqrt((x2 - x1)^2 + (y2 - y1)^2) - 2*r)/sqrt((u2-u1)^2 + (v2-v1)^2);
x2 = x2 + dt*u2;
y2 = y2 + dt*v2;
x1 = x1 + dt*u1;
y1 = y1 + dt*v1;
pause(.0001);
Draw_Disks(l,x1,y1,x2,y2,r);
angle=atan2(y2-y1,x2-x1);
if abs(y2-y1)<1e-12
if x2-x1>0
angle = 0;
else
angle = pi;
end
end
N=[cos(angle) sin(angle)];
T=[-sin(angle) cos(angle)];
% Shifting coordinates from XY to Normal/Tangent with dot product
vrnt = [u1*N(1)+v1*N(2) u1*T(1)+v1*T(2)];
vbnt = [u2*N(1)+v2*N(2) u2*T(1)+v2*T(2)];
%swap x velocities
temp = vbnt(1);
vbnt(1) = vrnt(1);
vrnt(1) = temp;
% Shifting coordinates back to XY and swapping x velocities
% inverted dot products
vrac = [vrnt(1)*T(2)+vrnt(2)*T(1) vrnt(1)*N(2) + vrnt(2)*N(1)];
vbac = [vbnt(1)*T(2)+vbnt(2)*T(1) vbnt(1)*N(2) + vbnt(2)*N(1)];
u1 = vrac(1);
v1 = vrac(2);
u2 = vbac(1);
v2 = vbac(2);
dt = tempdt;
x2 = x2 + dt*u2;
y2 = y2 + dt*v2;
x1 = x1 + dt*u1;
y1 = y1 + dt*v1;
end
pause(.001);
Draw_Disks(l,x1,y1,x2,y2,r);
t = t + dt;
end

