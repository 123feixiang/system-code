timeset = floor(timesetArea.Value);

%获取当前EEG数据的时间
max_time = max(time)-timeset;
current_position = slider.Value;
current_time = (current_position/slider.Max)*max_time;

%先破后立
delete(ax);

%创建坐标轴
ax = uiaxes(mainFig, 'Position', [10, 20, 870, 440]);
hold(ax, 'on');

mainFig.WindowButtonMotionFcn = @(src, event) evalin('base','updateMousePosition');

%清空坐标轴，避免重复绘制
cla(ax);

set(ax, 'XLim', [max(0, current_time),max(0, current_time)+timeset]);

%获取当前的间隔
offset = offsetArea.Value;

ax.XColor = 'k';
ax.YColor = 'k';

%逆序绘制EEG数据
for i = num_channels:-1:1  %从底部向上绘制
    if ismember(i,plotchannelIndex)
        plot(ax, time, EEG.data(i, :) + (num_channels - i) * offset, 'r', 'LineWidth', 0.6, 'Color', 'b');
    else
        plot(ax, time, EEG.data(i, :) + (num_channels - i) * offset, 'b', 'LineWidth', 0.6,'Color',[0, 0, 0, 0.55]);
    end
    
end

% %逆序绘制EEG数据
% for i = num_channels:-1:1  %从底部向上绘制
%     plot(ax, time, EEG.data(i, :) + (num_channels - i) * offset, 'b', 'LineWidth', 0.6,'Color',[0, 0, 0, 0.55]);
% end

%设置纵坐标信息（翻转通道名称）
ax.YTick = (0:num_channels-1) * offset;
ax.YTickLabel = flip(chan_labels);  % 反转通道名称，使 Ch1 在最底部，ChN 在最上方
ax.YLim = [-offset, (num_channels-1) * offset + offset];

%固定坐标轴界面
ax.Interactions = [];  
ax.XLimMode = 'manual';  
ax.YLimMode = 'manual'; 
