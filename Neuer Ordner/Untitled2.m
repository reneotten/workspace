syms x;
syms l;
syms mu;
syms B;
syms hbar;
syms a;
syms m

U=[cos(x/l) sin(x/l);-sin(x/l) cos(x/l)];
Ut=[cos(x/l) -sin(x/l);sin(x/l) cos(x/l)];
H=[mu*B 0;0 -mu*B];


H1Ut=[-1/4/m^2*cos(x/l)/l^2 1/4/m^2*sin(x/l)/l^2;...
    -1/4/m^2*sin(x/l)/l^2 -1/4/m^2*cos(x/l)/l^2];


H2Ut=[mu*B*cos(x/l)-a*1i*hbar*cos(x/l)/l -mu*B*sin(x/l)+a*1i*hbar*sin(x/l)/l;...
    -mu*B*sin(x/l)+a*1i*hbar*sin(x/l)/l -mu*B*cos(x/l)+a*1i*hbar*cos(x/l)/l];