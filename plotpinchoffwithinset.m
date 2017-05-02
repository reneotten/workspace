
data=load('/Volumes/User Ag Bluhm/Common/Projects/proj/001_tqg_gt/data/002-1/auto_scan/sm_002-1_19_10_O_7_37a.mat')
x1=linspace(data.scan.loops(1).rng(1),data.scan.loops(1).rng(2),data.scan.loops(1).npoints);
y1=data.data{1}*1e9;
data=load('/Volumes/User Ag Bluhm/Common/Projects/proj/001_tqg_gt/data/002-1/auto_scan/sm_002-1_19_10_O_7_37b.mat')
x2=linspace(data.scan.loops(1).rng(1),data.scan.loops(1).rng(2),data.scan.loops(1).npoints);
y2=data.data{1}*1e9;
figure();
hold on
set(gca,'FontSize',20);
xlabel('V_g (V)')
ylabel('I (nA)')

plot(x1,y1,x2,y2);
box on
%%
% create smaller axes in top right, and plot on it

axes('Position',[.15 .65 .25 .25])
box on


a = struct( ...
    'figH', 200, ...
    'bottom', true, ...
    'line', false, ...
    'xLim', [-inf inf], ... % minimum and maximum x coordinate for gate labels
    'yLim', [-inf inf], ... % minimum and maximum y coordinate for gate labels
    'clf', true ...
    );

% if isempty(a.figH)
%     a.figH = gcf();
%     axis equal
% end
% figH = figure(a.figH);
% 
% if a.clf
%     clf();
% end
hold on;
axis equal
highlight_names={'10','19'};
highlight=zeros(size(highlight_names));
for ii=1:numel(highlight)
    highlight(ii)=find(strcmp(names,highlight_names{ii}));
end

ohighlight_names={'37','7'};
ohighlight=zeros(size(ohighlight_names));
for ii=1:numel(ohighlight)
    ohighlight(ii)=find(strcmp(onames,ohighlight_names{ii}));
end


for k = setdiff(1:numel(points),highlight)
    
    patchH{k} = patch(points{k}(:, 1).', points{k}(:, 2).', 'red','LineWidth',.1,'EdgeColor','red');
%     text( min(max(mean(points{k}(:, 1)), a.xLim(1)), a.xLim(2)) ,  min(max(mean(points{k}(:, 2)), a.yLim(1)), a.yLim(2)) , names{k});
    
    if a.bottom
        uistack(patchH{k}, 'bottom');
    end
end

for k = setdiff(1:numel(ohmics),ohighlight)
    
    ohmicsH{k} = patch(ohmics{k}(:, 1).', ohmics{k}(:, 2).', 'black','LineWidth',.1,'EdgeColor','black');
% text( min(max(mean(points{k}(:, 1)), a.xLim(1)), a.xLim(2)) ,  min(max(mean(points{k}(:, 2)), a.yLim(1)), a.yLim(2)) , names{k});
    
    if a.bottom
        uistack(ohmicsH{k}, 'bottom');
    end
end

for k = highlight
    
    patchH{k} = patch(points{k}(:, 1).', points{k}(:, 2).', 'green','LineWidth',.1,'EdgeColor','green');
%     text( min(max(mean(points{k}(:, 1)), a.xLim(1)), a.xLim(2)) ,  min(max(mean(points{k}(:, 2)), a.yLim(1)), a.yLim(2)) , names{k});
    
    if a.bottom
        uistack(patchH{k}, 'bottom');
    end
end

for k = ohighlight
    
    ohmicsH{k} = patch(ohmics{k}(:, 1).', ohmics{k}(:, 2).', 'green','LineWidth',.1,'EdgeColor','green');
%     text( min(max(mean(points{k}(:, 1)), a.xLim(1)), a.xLim(2)) ,  min(max(mean(points{k}(:, 2)), a.yLim(1)), a.yLim(2)) , names{k});
    
    if a.bottom
        uistack(ohmicsH{k}, 'bottom');
    end
end
set(gca,'xtick',[])
set(gca,'ytick',[])
grid on
grid minor
hold off;