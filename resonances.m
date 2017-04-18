
A=importdata('/Users/reneotten/Desktop/OttenRF/TRACE_-0,5075.CSV');

x=A.data(:,1);
y=A.data(:,2);
y2=10.^(y./20);
%figure,plot(x,y);
%figure,plot(x,y2);
%%
 %YPRIME(X) = a*c./((X - b).^2 + c) + d.
start=0.1;
stop=2.5;
xData=x*1e-9;
yData=y2;
mask=xData > start & xData < stop;

[xFit,yFit]=prepareCurveData(xData(mask),yData(mask));
 %% Set up fittype and options.
ft = fittype( 'a*c/((x - b)^2 + c^2) + d', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf 0.15 0 0.9];
opts.StartPoint = [-0.8 0.155 0.141886338627215 1];
opts.Upper = [Inf 0.16 Inf 1.1];

% Fit model to data.
[fitresult, gof] = fit( xFit, yFit, ft, opts );
L=22*1e-9;

temp = confint(fitresult);
w=fitresult.b
sigma_w = abs(temp(1,2) - temp(2,2))/2
C=1/L/(2*pi*fitresult.b*1e9)^2
sigma_C=sigma_w/fitresult.b*C
dw=2*fitresult.c
sigma_dw = sqrt(2)*abs(temp(1,3) - temp(2,3))/2
Q=w/dw
sigma_Q=sqrt((sigma_dw/dw)^2+(sigma_w/w)^2)*Q
% Plot fit with data.
%% PLOT
% Plot fit with data.

title='LC1';
figure1 = figure('Name',title);

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
xFitRes=linspace(start,stop,1000);
yFitRes=fitresult(xFitRes);
h = plot(xData, yData, '.',xFitRes,yFitRes,'-','LineWidth',2 );
legend1 = legend( h, 'Data', 'Fit', 'Location', 'Best' );
% Label axes
xlim(axes1,[0 0.3]);
ylim(axes1,[0.1 1.05]);
xlabel('$f$  (GHz)','Interpreter','latex');

% Create ylabel
ylabel('$\mathrm{\Gamma}$','Interpreter','latex');

box(axes1,'on');
grid(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',20,'TickLabelInterpreter','latex');
% Create legend
set(legend1,'Interpreter','latex','FontSize',20);

outerpos = axes1.OuterPosition;
ti = axes1.TightInset;
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3)-0.01;
ax_height = outerpos(4) - ti(2) - ti(4);
axes1.Position = [left bottom ax_width ax_height];
figure1.PaperPositionMode = 'auto';
fig_pos = figure1.PaperPosition;
figure1.PaperSize = [fig_pos(3) fig_pos(4)];
print(figure1,['pictures/',title],'-dpdf')

%%
A=importdata('./data/SERIELL_3_PHASE.CSV');

x=A(:,1);
y=A(:,2);
xData=x.*1e-9;
yData=y;


title='LC1_PHASE';
figure1 = figure('Name',title);

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

h = plot(xData, yData, '.');


xlim(axes1,[0 0.3]);
xlabel('$f$  (GHz)','Interpreter','latex');

% Create ylabel
ylabel('$\phi \;\mathrm{(deg.)}$','Interpreter','latex');

box(axes1,'on');
grid(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontSize',20,'TickLabelInterpreter','latex');


outerpos = axes1.OuterPosition;
ti = axes1.TightInset;
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3)-0.01;
ax_height = outerpos(4) - ti(2) - ti(4);
axes1.Position = [left bottom ax_width ax_height];
figure1.PaperPositionMode = 'auto';
fig_pos = figure1.PaperPosition;
figure1.PaperSize = [fig_pos(3) fig_pos(4)];
print(figure1,['pictures/',title],'-dpdf')
