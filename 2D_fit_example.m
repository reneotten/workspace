function [fitresult, gof] = createFit1(x, R, z)
%CREATEFIT1(X,R,Z)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : x
%      Y Input : R
%      Z Output: z
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 11-May-2017 11:07:41


%% Fit: 'untitled fit 1'.
[xData, yData, zData] = prepareSurfaceData( x, R, z );

% Set up fittype and options.
ft = fittype( 'a.*abs(reflection(x.*1e6.*2.*pi,y-1000,b,1e-21,''L'',c,''C'',d))', 'independent', {'x', 'y'}, 'dependent', 'z' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 0 0 0];
opts.Robust = 'off';
opts.StartPoint = [0.6 0 470 0.97];
opts.Upper = [1 0 500 1];

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, [xData, yData], zData );
legend( h, 'untitled fit 1', 'z vs. x, R', 'Location', 'NorthEast' );
% Label axes
xlabel x
ylabel R
zlabel z
grid on
view( -62.7, -23.6 );


