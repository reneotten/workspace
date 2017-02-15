L=820e-9; % H
f=194e6; % Hz
w=2*pi*f; % 1/s
f1=220e6; % Hz
f2=230e6; % Hz
Rohmic=5000; % Ohm

C=1/(w^2*L)  % F
% C=0.82 pF

x=linspace(400e-9,900e-9,1000);
y=sensitivity(f1*2*pi,0.82e-12,x,5e4,'Rohmic',Rohmic);
y1=sensitivity(f2*2*pi,0.82e-12,x,5e4,'Rohmic',Rohmic);
figure,plot(x,y,x,y1);

[msens,index]=max(y);
L1=x(index);
[msens,index]=max(y1);
L2=x(index);

meanL=mean([L1,L2])

sens1=sensitivity(f1*2*pi,0.82e-12,meanL,5e4,'Rohmic',Rohmic)
sens2=sensitivity(f2*2*pi,0.82e-12,meanL,5e4,'Rohmic',Rohmic)
fun=@(x)sensitivity(f1*2*pi,0.82e-12,x,5e4,'Rohmic',Rohmic)-sensitivity(f2*2*pi,0.82e-12,x,5e4,'Rohmic',Rohmic);
[optL,~]=fsolve(fun,meanL);
optL
optsens=sensitivity(f1*2*pi,0.82e-12,optL,5e4)
%%
