%% standart, no ohmic, no stray dot
wax=linspace(100e6*2*pi,300*1e6*2*pi,1001);
Lax=linspace(400,900,101);
[w,L]=meshgrid(wax,Lax);
Rohmic=0;
Cstray=1e-20;
Rdot=5e4;
C=0.94;

sens=sensitivity(w,0.9e-12,L,Rdot,'Cstray',Cstray,'Rohmic',Rohmic);


f=figure;
a=axes;
imagesc(a,wax/2/pi/1e6,Lax*1e9,sens); 
xlabel('f (MHz)','FontSize',14);
ylabel('L (nH)','FontSize',14);
set(gca,'YDir','normal');
c=colorbar;
ylabel(c,'sensitivity (a.u.)')
set(a,'FontSize',14);

%%

wax=linspace(100e6,300*1e6*2*pi,1001);
Rohmicax=linspace(0,10e3,1001);
Cstrayax=linspace(0.1e-12,1e-12,1001);
[~,Rohmic]=meshgrid(wax,Rohmicax);
[w,Cstray]=meshgrid(wax,Cstrayax);

Vs=0.1;

Vd1=calcVd(Vs,w,5e4+1,Rohmic,1e-20,'L',600);
Vd2=calcVd(Vs,w,5e4+1,0,Cstray,'L',600);

dRcorr=(reflection(w,5e4+1,Rohmic,1e-20)-reflection(w,5e4-1,Rohmic,1e-20))/2; % numerical diff dRs
dRcorr2=(reflection(w,5e4+1,0,Cstray)-reflection(w,5e4-1,0,Cstray))/2;

figure;
subplot(2,3,1)
imagesc(wax/2/pi,Rohmicax,abs(dRcorr)); 
set(gca,'YDir','normal');
colorbar;

subplot(2,3,2)
imagesc(wax/2/pi,Rohmicax,abs(Vd1)); 
set(gca,'YDir','normal');
colorbar;

subplot(2,3,3)
imagesc(wax/2/pi,Rohmicax,abs(dRcorr).*abs(Vd1)); 
set(gca,'YDir','normal');
colorbar;

subplot(2,3,4)
imagesc(wax/2/pi,Cstrayax,abs(dRcorr2)); 
set(gca,'YDir','normal');
colorbar;

subplot(2,3,5)
imagesc(wax/2/pi,Cstrayax,abs(Vd2)); 
set(gca,'YDir','normal');
colorbar;

subplot(2,3,6)
imagesc(wax/2/pi,Cstrayax,abs(dRcorr2).*abs(Vd2)); 
set(gca,'YDir','normal');
colorbar;

%%

wax=linspace(0,1000*1e6*2*pi,1001);
Rohmicax=linspace(0,10e3,101);
Cstrayax=linspace(0.1,1,101);
Cax=linspace(0,1,101);
Lax=linspace(400,900,101);

%[~,Rohmic]=meshgrid(wax,Rohmicax);
%%
[w,Cstray,Rohmic]=meshgrid(wax,Cstrayax,Rohmicax);

sens=sensitivity(w,0.9e-12,820e-9,5e4,'Cstray',Cstray,'Rohmic',Rohmic);




%figure,imagesc(reshape(sens(1,:,:),101,101));

figure, imagesc(Cstrayax,Rohmicax,reshape((max(sens,[],2)),101,101));
set(gca,'YDir','normal');
colorbar;

%% vary Ohmic and Cstray
n=numel(Rohmicax);
m=numel(Cstrayax);
result=zeros(n,m);
for i=1:n
    for j=1:m
        sens=sensitivity(wax,0.9e-12,820e-9,5e4,'Cstray',Cstrayax(j),'Rohmic',Rohmicax(i));
        result(i,j)=max(sens);
        if (index==1 || index==numel(wax)), warning('X');end
    end 
end
figure,imagesc(Rohmicax,Cstrayax,result);
set(gca,'YDir','normal');
colorbar;

%% vary Ohmic and C instead of adding Cstray
n=numel(Rohmicax);
m=numel(Cstrayax);
result=zeros(n,m);
for i=1:n
    for j=1:m
        sens=sensitivity(wax,0.9e-12+Cstrayax(j),820e-9,5e4,'Cstray',Cstrayax(1),'Rohmic',Rohmicax(i));
        [result(i,j),index]=max(sens);
        if (index==1 || index==numel(wax)), warning('X');end
    end 
end
figure,imagesc(Rohmicax,0.9e-12+Cstrayax,result);
set(gca,'YDir','normal');
colorbar;

%%
%% vary Ohmic and C instead of adding Cstray
n=numel(Rohmicax);
m=numel(Cstrayax);
result=zeros(n,m);
for i=1:n
    for j=1:m
        sens=sensitivity(wax,Cax(j),820e-9,5e4,'Cstray',Cstrayax(1),'Rohmic',Rohmicax(i));
        [result(i,j),index]=max(sens);
        if (index==1 || index==numel(wax)), warning(['X' num2str(i) ',' num2str(j)]);end
    end 
end
figure,imagesc(Rohmicax,Cax,result);
set(gca,'YDir','normal');
colorbar;

%% vary C and L
n=numel(Lax);
m=numel(Cax);
result=zeros(n,m);
freq=zeros(n,m);
for i=1:n
    for j=1:m
        sens=sensitivity(wax,Cax(j),Lax(i),5e4,'Cstray',0.1e-12,'Rohmic',500);
        [result(i,j),index]=max(sens);
        freq(i,j)=wax(index);
        if (index==1 || index==numel(wax)), warning(['X' num2str(i) ',' num2str(j)]);end
    end 
end
mask=(freq>=230e6*2*pi & freq<=240e6*2*pi);
[x,y]=find(mask);

figure,imagesc(Lax,Cax,result);
hold on
set(gca,'YDir','normal');
colorbar;
plot(Lax(y),Cax(x),'r.');
hold off

figure,imagesc(Lax,Cax,freq/2./pi);
hold on
set(gca,'YDir','normal');
colorbar;
plot(Lax(y),Cax(x),'r.');
hold off

%%
Rsax=linspace(0,8e6,1000);
wax=linspace(0,400e6,1000);

figure;
plot(wax,reflection(wax*2*pi,5e4,0,1e-10));

%%
figure;
hold on
for Rohmic=0:1000:10000
phi=angle(reflection(226e6*2*pi,Rsax,Rohmic,1e-10));
r=abs(reflection(226e6*2*pi,Rsax,Rohmic,1e-21));
%r=r+r.*-2.*(phi<pi/2);
plot(Rsax,r);
end
legend
hold off

%%
figure;
hold on
for Rohmic=300
r=0.3*abs(reflection(181e6*2*pi,Rsax,Rohmic,1e-21,'L',820,'C',0.9429));
%r=r+r.*-2.*(phi<pi/2);
plot(Rsax,r);
end
legend
hold off

%%
Rsax=linspace(0,5e4,1000);
[w,Rs]=meshgrid(wax,Rsax);


for Cstray=1e-21:1e-13:1e-12
figure;
y=abs(reflection(w*2*pi,Rs,0,Cstray));
%plot(Rsax,y);
imagesc(wax,Rsax,y)
end
hold off