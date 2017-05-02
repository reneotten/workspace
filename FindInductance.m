L=820e-9; % H
f=181e6; % Hz
w=2*pi*f; % 1/s
f1=220e6; % Hz
f2=240e6; % Hz
Rohmic=150; % Ohm

C=1/(w^2*L)*1e12  % F
% C=0.82 pF

x=linspace(300,700,1000);
y=sensitivity(f1*2*pi,C,x,5e4,'Rohmic',Rohmic);
yu=sensitivity(f1*2*pi,C+C/20,x,5e4,'Rohmic',Rohmic);
yd=sensitivity(f1*2*pi,C-C/20,x,5e4,'Rohmic',Rohmic);
y1=sensitivity(f2*2*pi,C,x,5e4,'Rohmic',Rohmic);
y1u=sensitivity(f2*2*pi,C+C/20,x,5e4,'Rohmic',Rohmic);
y1d=sensitivity(f2*2*pi,C-C/20,x,5e4,'Rohmic',Rohmic);

figure,plot(x,y,'b',x,y1,'r');

[~,index]=max(yu);
util.plot.vline(x(index),'b-.');
[~,index]=max(yd);
util.plot.vline(x(index),'b--');
[~,index]=max(y1u);
util.plot.vline(x(index),'r-.');
[~,index]=max(y1d);
util.plot.vline(x(index),'r--');

[msens,index]=max(y);
L1=x(index);
[msens,index]=max(y1);
L2=x(index);

L1b=1/((2*pi*f1)^2*C*1e-12)*1e9
diff1=L1-L1b
L2b=1/((2*pi*f2)^2*C*1e-12)*1e9
diff2=L2-L2b
util.plot.vline(L1b,'k');
util.plot.vline(L2b,'k');




%% 
meanL=mean([L1,L2])

sens1=sensitivity(f1*2*pi,0.9429,meanL,5e4,'Rohmic',Rohmic)
sens2=sensitivity(f2*2*pi,0.9429,meanL,5e4,'Rohmic',Rohmic)
fun=@(x)sensitivity(f1*2*pi,0.9429,x,5e4,'Rohmic',Rohmic)-sensitivity(f2*2*pi,0.9429,x,5e4,'Rohmic',Rohmic);
[optL,~]=fsolve(fun,meanL);
optL
optsens=sensitivity(f1*2*pi,0.9429,optL,5e4)

set(gca,'FontSize',20);
xlabel('L (nH)')
ylabel('sensitivity (V/\Omega)')
%%
