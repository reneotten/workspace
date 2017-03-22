%% Scan gates with DecaDAC
clear scanGate;

scanGate.loops(1).npoints = 101;

%scanGate.loops(1).rng = [0 -1];
scanGate.loops(1).rng = [-1 0];

scanGate.loops(1).setchan = {'BA'};%, 'NAB', 'BB', 'SC'};
scanGate.loops(1).getchan = {'LIC'};
%scanTopGate.loops(1).setchan = 'SMU2_V';
%scanTopGate.loops(1).getchan = {'LIC','SMU2_I'};
scanGate.loops(1).ramptime = 0.1;

scanGate.figure = 1;
scanGate.disp(1).loop = 1;
scanGate.disp(1).channel = 1;
scanGate.disp(1).dim = 1;
scanGate.fighold = 1;
0
%%
smrun(scanGate, '003_A_2_14_O_6_19b')

%%
smset({'BA', 'NAB', 'BB', 'SC'},0)

%%
smget({'BA', 'NAB', 'BB', 'SC'})

%% Scan gates with Keithly
clear scanGate;

scanGate.loops(1).npoints = 101;
scanGate.loops(1).rng = [0.0 0.7];
% scanGate.loops(1).rng = [-1 0];
scanGate.loops(1).setchan = {'SMU2_V'};
scanGate.loops(1).getchan = {'SMU2_I'};
%scanTopGate.loops(1).setchan = 'SMU2_V';
%scanTopGate.loops(1).getchan = {'LIC','SMU2_I'};
scanGate.loops(1).ramptime = 0.1;

scanGate.figure = 1;
scanGate.disp(1).loop = 1;
scanGate.disp(1).channel = 1;
scanGate.disp(1).dim = 1;
scanGate.fighold = 1;

%% Keithly Gate Test RUN
smset('ISV', 1e-6);
smcKeithley2400([6 5 1], 1)
smrun(scanGate);
smset('SMU2_V', 0);


%% Plots
close all

fileNames = { ...
    'sm_002_A_8_9_19_20_O_16_2a.mat',  ...
    'sm_002_A_8_9_19_20_O_16_24a',  ...
    'sm_002_A_13_10_O_16_12a_v3.mat', ...
    'sm_002_A_17_10_O_2_12a.mat', ...
    'sm_002_A_19_10_O_2_12.mat', ...
    'sm_002_A_19_10_O_2_12a.mat', ...
    'sm_002_A_19_10_O_2_12a_v2.mat', ...
    'sm_002_A_19_10_O_2_12b.mat' };

clearvars data
for k = 1:numel(fileNames)
    figure
	data{k} = load(fileNames{k});
    rng = data{k}.scan.loops(1).rng;
       
    plot(linspace(rng(1), rng(2), data{k}.scan.loops(1).npoints), data{k}.data{1});
    title(strrep(fileNames{k}, '_', ' '));
end