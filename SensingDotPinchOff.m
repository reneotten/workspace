V=[4400 4500 4600 4700 ...
   4800 4825 4850 4875 ...
   4900 4925 4950 4975 ...
   5000 5025 5050 5075 ...
   5100 5125 5150 5175 ...
   5200 5225 5250 5275 ...
   5300 5325];

Vint=-V*1e-4;
mins=zeros(size(Vint));


for k=1:numel(V)
    
A=importdata(['/Users/reneotten/Desktop/OttenRF/TRACE_-0,' num2str(V(k)) '.CSV']);

x=A.data(:,1);
y=A.data(:,2);
y2=10.^(y./20);

mins(k)=min(y2);

end

figure();
plot(Vint,mins,'o');
set(gca,'FontSize',20);
xlabel('V_G (V)')
ylabel('\Gamma')

%%
data=load('/Volumes/User Ag Bluhm/Common/Projects/proj/001_tqg_gt/data/002-2/002-2_40muV_34_38_35_36_39_40_30_CH16_O_31_37.mat');
Vg=linspace(data.scan.loops.rng(1),data.scan.loops.rng(2),data.scan.loops.npoints);
I=data.data{1};
If=@(V)interp1(Vg,I,V);
figure();
plot(Vg,I,Vint,If(Vint),'o');
set(gca,'FontSize',20);
xlabel('V_G (V)')
ylabel('I (A)')

%%

R=40e-6./If(Vint);

figure();
plot(R,mins,'o');
set(gca,'FontSize',20);
xlabel('R_S (\Omega)')
ylabel('\Gamma')

%%
for k=16
    
A=importdata(['/Users/reneotten/Desktop/OttenRF/TRACE_-0,' num2str(V(k)) '.CSV']);

x=A.data(:,1);
y=A.data(:,2);
y2=10.^(y./20);

mins(k)=min(y2);

end

figure,plot(x,y2)