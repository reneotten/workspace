wax=linspace(100e6,300*1e6*2*pi,1001);
Rohmicax=linspace(0,10e3,1001);
Cstrayax=linspace(0.1e-12,1e-12,1001);
[~,Rohmic]=meshgrid(wax,Rohmicax);
[w,Cstray]=meshgrid(wax,Cstrayax);

Vs=0.1;

Vd1=calcVd(Vs,w,5e4+1,Rohmic,1e-20,'L',600e-9);
Vd2=calcVd(Vs,w,5e4+1,0,Cstray,'L',600e-9);

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
Cstrayax=linspace(0.1e-12,1e-12,101);
Cax=linspace(0,1e-12,101);
Lax=linspace(400e-9,900e-9,101);

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

