C=0.9e-12;
L=820*1e-9;
Rs=50000;
Cstray=0.1e-20;

Z0=50;

Vd=10;
Vs=0.1;

f_res=1/sqrt(L*C)/2/pi


wax=linspace(0,500*1e6*2*pi,1001);
Rohmicax=linspace(0,100e3,1001);
[w,Rohmic]=meshgrid(wax,Rohmicax);
w=wax;
Rohmic=0;
Zc=1./(1i.*w.*C);
Zstray=1./(1i.*w.*Cstray);
Zl=1i.*w.*L;

%Z=Z_L+1./(1./Z_c+1./R_s);

Zcorr=Zl+1./(1./Zc+1./(Rohmic+1./(1./Rs+1./Zstray)));


Vd=Vs./...
    abs(1./(1./Zc+1./(Rohmic+1./(1./Rs+1./Zstray)))./Zcorr)*...
    1./(1./Rs+1./Zstray)./(Rohmic+1./(1./Rs+1./Zstray));

%figure, loglog(wax/2/pi,abs(Vd));
figure, plot(wax/2/pi,Vd,wax/2/pi,calcVd(0.1,wax,Rs,Rohmic,Cstray));

% %R=(Z-Z0)./(Z+Z0);
% Rcorr=(Zcorr-Z0)./(Zcorr+Z0);
% 
% dRdRs=diff(R)./diff(w);
% dRdRscorr=diff(Rcorr)./diff(w);
% 
% figure;
% hold on;
% imagesc(abs(Rcorr));
% %plot(w/2/pi,Rcorr);
% hold off;
% 
