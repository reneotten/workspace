offset=0;

epsilons=[0]*1e-3;

count=0;
for epsilon=epsilons
count=count+1;
defaultArgs = struct(...
	'nDots',        4, ...
    'N0',           5*ones(4, 1), ...
	'Cg',           1e-17*[1 1 1 1], ...
	'Cl',           1e-17*[1 1 1 1], ...
	'Cm',           15e-18*[1 1 1], ...
    'Cij',          1e-18*[1 1 1; 1 1 1 ], ...
    'Vl',           1e-3*[1 1 1 1], ...
    'coeff',        [0 0 offset+epsilon; ...
                     0 0 offset+epsilon;...
                     1 0 offset-epsilon; ...
                     0 1 offset-epsilon], ...
	'lims',         1e-3*[-15, -0; -30, -15], ...
    'nPoints',      [150, 150], ...
    'distances',    2e-7*[5 8 11 14;14 11 8 5]', ...
    'useEnergies',  false, ...
    'Ec',           [7.2 11.5 11.5 7.2]*1e-3*util.const.e, ...
    'Ecm',          [1.5 1.2 1.5 .2 .2 .02]*1e-3*util.const.e, ...
    'smearing',     false, ...
    'sweepSpeed',   1e-3, ...
    'tau',          0.5, ...
    'diff',         true, ...
	'e' ,           util.const.e, ...
	'e2',           util.const.e^2, ...
    'eps_0',        util.const.eps_0 ...
	);

[E,info]=dot_tune.capacitive_gate_model(defaultArgs);
figure,imagesc(info.dU); % add axis here
hold on;
colorbar;
set(gca,'Ydir','normal');
plot(110,30,'r.','MarkerSize',20);
hold off;
print(gcf,['plots/',num2str(count),'_epsilon_',num2str(epsilon),'.png'],'-dpng');
close(gcf);
end