%% TempFit
xFit=Temps;
yFit=dV0;

w=1./dV0std;

[xData, yData, weights] = prepareCurveData( Temps, dV0, w );

% Set up fittype and options.
ft = fittype( 'a*sqrt(b.^2+x.^2)', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.699079475052078 0.92679302400378];
opts.Weights = weights;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot(fitresult);
hold on
errorbar(xData,yData,dV0std,'o');
% Label axes
xlabel('T (mK)')
ylabel ('dV (mV)')
grid on
set(gca,'FontSize',20);
