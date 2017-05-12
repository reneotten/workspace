%% Load and Process VNA Traces
filenames=cell2mat(util.glob(osPath('Otten/master/PCB Testing/data/working_seinsing_dots/run2_08/*.CSV'),'-ignorecase'));

V=str2num(filenames(:,end-7:end-4))';

Vint=-V*1e-4;
mins=zeros(size(Vint));
z=zeros(numel(V),1001);
for k=1:numel(V)

A=util.osDepLoad(['Otten/master/PCB Testing/data/working_seinsing_dots/run2_08/' num2str(V(k)) '.CSV'],'operation','importdata');
  
x=A.data(:,1)*1e-6;
y=A.data(:,2);
y2=10.^(y./20);
z(k,:)=y2;
mins(k)=min(y2);

end

figure();
plot(Vint,mins,'o');
set(gca,'FontSize',20);
xlabel('V_G (V)')
ylabel('\Gamma')

%% Load and process pinch off data
% Load File
data=util.osDepLoad('Common/Projects/proj/001_tqg_gt/data/002-2/002-2_res_vs_freq_08__36_39_40_O_31_37a');
% create voltage range
Vg=linspace(data.scan.loops.rng(1),data.scan.loops.rng(2),data.scan.loops.npoints);
% Interpolate current values
I=data.data{1};
If=@(V)interp1(Vg,I,V);

% plot for testing
figure();
plot(Vg,I,Vint,If(Vint),'o');
xlabel('V_G (V)')
ylabel('I (A)')


%% convert to R as x-axis
R=40e-6./If(Vint);

figure();
plot(R,mins,'o');
set(gca,'FontSize',20);
xlabel('R_S (\Omega)')
ylabel('\Gamma')



%% Try fit_suite fit

% Define function externally

% Prepare Fit Parameters
% All of the fit parameters are collected in a struct that is passed to
% fit_suite.start_fit along with the data. fit_suite.start_fit tries to provide sensible
% defaults for all of the parameters.
% DISCLAIMER: There are many more useful parameters, that are well
% documented in fit_suite.start_fit's source code.

% choose start parameters
args.paramsStart.a = 0.6; 
args.paramsStart.L= 470;
args.paramsStart.C = 0.97; 
args.paramsStart.Rohmic = 0;
args.paramsStart.x = x;
args.paramsStart.y = R;

% choose, which parameters to fit and which are fixed
% 1 indicates fit, 0 a fixed parameter
args.paramsMask.a = 1; % fit both frequencies
args.paramsMask.L = 1;
args.paramsMask.C = 1;
args.paramsMask.Rohmic = 0;

% add some sensible bounds to parameters. some fit algorithms require
% bounds. phase and offset are unbounded.
args.lowerBounds.a =  0;
args.lowerBounds.L =   450;
args.lowerBounds.C = 0.6;
args.lowerBounds.Rohmic = -10;

args.upperBounds.a =  1;
args.upperBounds.L =   550;
args.upperBounds.C = 1.6;
args.upperBounds.Rohmic = 500;


% set up data and solver
args.data = z; % data can also be masked and weighted
optimOptions = optimset('fsolve');
optimOptions = optimset(optimOptions, 'TolX', 1e-12, 'TolFun', 1e-12, 'DiffMaxChange', 1e-8);
optimOptions.solverName = 'fsolve';

args.optimPlotFcn = {};

result = fit_suite.start_fit(@fit_suite_reflection, optimOptions, args);
% result.runs.params contains the optimal parameters
util.disp_struct(result.runs.params,1);

%%
% Nice Plot

resArgs=result.runs(1).params;
resArgs.x=args.paramsStart.x;
resArgs.y=linspace(args.paramsStart.y(1),args.paramsStart.y(end),1001);
% figure, imagesc(resArgs.x,resArgs.y,fit_suite_reflection(result.runs(1).params))
figure, imagesc(resArgs.x,resArgs.y/1000,fit_suite_reflection(resArgs));

xlabel('Frequency (MHz)')
ylabel('Sensing Dot Resistance (k\Omega)')

c=colorbar;
ylabel(c,'\Gamma')
set(gca,'FontSize',18);