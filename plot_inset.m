load('points.mat');


%% highlight single Gate pair

figure;
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
highlight_names={'34','38','35','36','39','40','30'};
highlight=zeros(size(highlight_names));
for ii=1:numel(highlight)
    highlight(ii)=find(strcmp(names,highlight_names{ii}));
end

ohighlight_names={'31','7'};
ohighlight=zeros(size(ohighlight_names));
for ii=1:numel(ohighlight)
    ohighlight(ii)=find(strcmp(onames,ohighlight_names{ii}));
end


for k = setdiff(1:numel(points),highlight)
    
    patchH{k} = patch(points{k}(:, 1).', points{k}(:, 2).', 'red','LineWidth',.1,'EdgeColor','red');
    text( min(max(mean(points{k}(:, 1)), a.xLim(1)), a.xLim(2)) ,  min(max(mean(points{k}(:, 2)), a.yLim(1)), a.yLim(2)) , names{k});
    
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
    text( min(max(mean(points{k}(:, 1)), a.xLim(1)), a.xLim(2)) ,  min(max(mean(points{k}(:, 2)), a.yLim(1)), a.yLim(2)) , names{k});
    
    if a.bottom
        uistack(patchH{k}, 'bottom');
    end
end

for k = ohighlight
    
    ohmicsH{k} = patch(ohmics{k}(:, 1).', ohmics{k}(:, 2).', 'green','LineWidth',.1,'EdgeColor','green');
    text( min(max(mean(points{k}(:, 1)), a.xLim(1)), a.xLim(2)) ,  min(max(mean(points{k}(:, 2)), a.yLim(1)), a.yLim(2)) , names{k});
    
    if a.bottom
        uistack(ohmicsH{k}, 'bottom');
    end
end

set(gca,'xtick',[])
set(gca,'ytick',[])
grid on
grid minor
hold off;







%% plot and highlight gate pair for inset

x1 = linspace(0,1);
y1 = x1.^2;

figure()
% plot on large axes
plot(x1,y1)
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
    text( min(max(mean(points{k}(:, 1)), a.xLim(1)), a.xLim(2)) ,  min(max(mean(points{k}(:, 2)), a.yLim(1)), a.yLim(2)) , names{k});
    
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
    text( min(max(mean(points{k}(:, 1)), a.xLim(1)), a.xLim(2)) ,  min(max(mean(points{k}(:, 2)), a.yLim(1)), a.yLim(2)) , names{k});
    
    if a.bottom
        uistack(patchH{k}, 'bottom');
    end
end

for k = ohighlight
    
    ohmicsH{k} = patch(ohmics{k}(:, 1).', ohmics{k}(:, 2).', 'green','LineWidth',.1,'EdgeColor','green');
    text( min(max(mean(points{k}(:, 1)), a.xLim(1)), a.xLim(2)) ,  min(max(mean(points{k}(:, 2)), a.yLim(1)), a.yLim(2)) , names{k});
    
    if a.bottom
        uistack(ohmicsH{k}, 'bottom');
    end
end
set(gca,'xtick',[])
set(gca,'ytick',[])
grid on
grid minor
hold off;

%% Colorful Matlab Gate Layout

figure;
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
% rf_names={'E3','E5','E7','E8','E1'};
rf_names={'35','38','34'};
rf=zeros(size(rf_names));
for ii=1:numel(rf)
    rf(ii)=find(strcmp(names,rf_names{ii}));
end

% barrier_names={'35','30','26','34','33','10','19','8','14'};
barrier_names={'10','9','E5'};
barrier=zeros(size(barrier_names));
for ii=1:numel(barrier)
    barrier(ii)=find(strcmp(names,barrier_names{ii}));
end

% sensing_names={'36','39','40','6','4','5'};
sensing_names={'E3'};
sensing=zeros(size(sensing_names));
for ii=1:numel(sensing)
    sensing(ii)=find(strcmp(names,sensing_names{ii}));
end

for k = setdiff(1:numel(points),[rf,barrier,sensing])
    
    patchH{k} = patch(points{k}(:, 1).', points{k}(:, 2).', 'red','LineWidth',.1,'EdgeColor','red');
    text( min(max(mean(points{k}(:, 1)), a.xLim(1)), a.xLim(2)) ,  min(max(mean(points{k}(:, 2)), a.yLim(1)), a.yLim(2)) , names{k});
    
    if a.bottom
        uistack(patchH{k}, 'bottom');
    end
end

for k = rf
    
    patchH{k} = patch(points{k}(:, 1).', points{k}(:, 2).', 'green','LineWidth',.1,'EdgeColor','green');
    text( min(max(mean(points{k}(:, 1)), a.xLim(1)), a.xLim(2)) ,  min(max(mean(points{k}(:, 2)), a.yLim(1)), a.yLim(2)) , names{k});
    
    if a.bottom
        uistack(patchH{k}, 'bottom');
    end
end

for k = barrier
    
    patchH{k} = patch(points{k}(:, 1).', points{k}(:, 2).', 'blue','LineWidth',.1,'EdgeColor','blue');
    text( min(max(mean(points{k}(:, 1)), a.xLim(1)), a.xLim(2)) ,  min(max(mean(points{k}(:, 2)), a.yLim(1)), a.yLim(2)) , names{k});
    
    if a.bottom
        uistack(patchH{k}, 'bottom');
    end
end

for k = sensing
    
    patchH{k} = patch(points{k}(:, 1).', points{k}(:, 2).', 'yellow','LineWidth',.1,'EdgeColor','yellow');
    text( min(max(mean(points{k}(:, 1)), a.xLim(1)), a.xLim(2)) ,  min(max(mean(points{k}(:, 2)), a.yLim(1)), a.yLim(2)) , names{k});
    
    if a.bottom
        uistack(patchH{k}, 'bottom');
    end
end

for k = 1:numel(ohmics)
    
    ohmicsH{k} = patch(ohmics{k}(:, 1).', ohmics{k}(:, 2).', 'black','LineWidth',.1,'EdgeColor','black');
% text( min(max(mean(points{k}(:, 1)), a.xLim(1)), a.xLim(2)) ,  min(max(mean(points{k}(:, 2)), a.yLim(1)), a.yLim(2)) , names{k});
    
    if a.bottom
        uistack(ohmicsH{k}, 'bottom');
    end
end

set(gca,'xtick',[])
set(gca,'ytick',[])
grid on
grid minor
hold off;


%%



