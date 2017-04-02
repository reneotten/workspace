points;
names={'33','12'};


%% plot and highlight gate pair

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
highlight=[8,17];

for k = setdiff(1:numel(points),highlight);
    
    patchH{k} = patch(points{k}(:, 1).', points{k}(:, 2).', 'red','LineWidth',.1,'EdgeColor','red');
%     text( min(max(mean(points{k}(:, 1)), a.xLim(1)), a.xLim(2)) ,  min(max(mean(points{k}(:, 2)), a.yLim(1)), a.yLim(2)) , num2str(k));
    
    if a.bottom
        uistack(patchH{k}, 'bottom');
    end
end

for k = highlight
    
    patchH{k} = patch(points{k}(:, 1).', points{k}(:, 2).', 'green','LineWidth',.1,'EdgeColor','green');
%     text( min(max(mean(points{k}(:, 1)), a.xLim(1)), a.xLim(2)) ,  min(max(mean(points{k}(:, 2)), a.yLim(1)), a.yLim(2)) , num2str(k));
    
    if a.bottom
        uistack(patchH{k}, 'bottom');
    end
end
set(gca,'xtick',[])
set(gca,'ytick',[])
grid on
grid minor
hold off;
