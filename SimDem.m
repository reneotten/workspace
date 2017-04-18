wax=linspace(0,1000*1e6*2*pi,1001);
Rohmicax=linspace(0,10e3,101);
Cstrayax=linspace(0.1,1,101);
Cax=linspace(0,1,101);
Lax=linspace(400,900,101);

%%
[w,L]=meshgrid(wax,Lax);

z=abs(reflection(w,5e4,300,0.1,'L',L,'C',0.9429));

figure,imagesc(wax/2/pi/1e6,Lax,z);
set(gca,'FontSize',20);
xlabel('f (MHz)')
ylabel('L (nH)')

c=colorbar;
ylabel(c,'\Gamma')

%%
[w,C]=meshgrid(wax,Cax);

z=abs(reflection(w,5e4,300,0.1,'L',820,'C',C));


figure,imagesc(wax,Cax,z);
colorbar;

set(gca,'FontSize',20);
xlabel('f (MHz)')
ylabel('L (nH)')

c=colorbar;
ylabel(c,'\Gamma')
%%

[w,L]=meshgrid(wax,Lax);

z=sensitivity(w,0.9429,L,5e4,'Cstray',0.1,'Rohmic',300) ;
figure,imagesc(wax./2./pi/1e6,Lax,z);
colorbar;

set(gca,'FontSize',20);
xlabel('f (MHz)')
ylabel('L (nH)')

c=colorbar;
ylabel(c,'d\Gamma/dR_S (1/\Omega)')
%%

z2=calcVd(1, w,5e4, 0, 1e-10, 'L',L,'C',0.9429);
figure,imagesc(wax,Lax,z2);
colorbar;
