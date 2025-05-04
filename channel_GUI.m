%去除背景图像
img.Visible = 'off';


mainFig.Color = [0.50,0.50,0.50];

%生成时间轴（单位：秒）
Fs = EEG.srate;
[num_channels, num_samples] = size(EEG.data);
time = (1:num_samples) / Fs;

% **计算动态offset**
data = EEG.data;
mean_range = mean(data,2);
max_range = max(mean_range);
min_range = min(mean_range);
offset = double((max_range-min_range)*30);

%检查当前是否已经存在变量
if exist('ax','var')
    delete(ax);
end

ax = uiaxes(mainFig, 'Position', [10, 20, 870, 440]);
hold(ax, 'on');


%添加鼠标移动事件
mainFig.WindowButtonMotionFcn = @(src, event) evalin('base','updateMousePosition');

%检查并设置通道名称
if isfield(EEG, 'chanlocs')
    chan_labels = {EEG.chanlocs.labels};  % 提取通道名称
else
    chan_labels = arrayfun(@(x) sprintf('Ch%d', x), 1:num_channels, 'UniformOutput', false);
end

%清空坐标轴，避免重复绘制
cla(ax);

ax.XColor = 'k';
ax.YColor = 'k';


%逆序绘制 EEG 数据
% for i = num_channels:-1:1  % 从底部向上绘制
%     plot(ax, time, EEG.data(i, :) + (num_channels - i) * offset, ...
%         'LineWidth', 0.6, 'Color', g.color{1});  % 使用 g.color 中的默认颜色
% end

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

% **设置初始显示时间范围**
initial_time_range = 5;  
ax.XLim = [0, initial_time_range];


%固定坐标轴界面
ax.Interactions = [];  
ax.XLimMode = 'manual';  
ax.YLimMode = 'manual';  

if exist('eeglabel','var')
    delete(eeglabel);
end
eeglabel = uilabel(mainFig);
eeglabel.Text = ['# Data',num2str(currentindex),':', newline, '   ',EEG.setname];
eeglabel.Position = [40,460,160,40];
eeglabel.FontSize = 14;

if exist('leftControl','var')
    delete(leftControl);
end
leftControl = uicontrol(mainFig);
leftControl.Style = 'push';
leftControl.String = '<<<';
leftControl.Position = [840,0,30,20];
leftControl.BackgroundColor = [0.9,0.9,0.9];
leftControl.TooltipString = '左退';
leftControl.Callback = @(src, event) evalin('base','leftBack');

if exist('rightControl','var')
    delete(rightControl);
end
rightControl = uicontrol(mainFig);
rightControl.Style = 'push';
rightControl.String = '>>>';
rightControl.Position = [870,0,30,20];
rightControl.BackgroundColor = [0.9,0.9,0.9];
rightControl.TooltipString = '右进';
rightControl.Callback = @(src, event) evalin('base','rightJump');

if exist('slider','var')
    delete(slider);
end
%创建一个滑块，并设置颜色
slider = uicontrol(mainFig, 'Style', 'slider', 'Position', [0, 0, 840, 20]);
slider.SliderStep = [0.01,0.1];
slider.Min = 0;
slider.Max = 840;
slider.BackgroundColor = [0.8,0.8,0.8];
slider.Enable = "on";
slider.Callback =  @(src, event) evalin('base','update_EEG_Graph');

if exist('channelNameLabel','var')
    delete(channelNameLabel);
end
channelNameLabel = uilabel(mainFig,'Text',' 通道 ');
channelNameLabel.Position = [200,480,60,20];
channelNameLabel.VerticalAlignment = 'center';
channelNameLabel.HorizontalAlignment = 'center';

if exist('channelLabel','var')
    delete(channelLabel);
end
channelLabel = uilabel(mainFig,'Text',' ');
channelLabel.Position = [200,460,60,20];
channelLabel.VerticalAlignment = 'center';
channelLabel.HorizontalAlignment = 'center';

if exist('timeNameLabel','var')
    delete(timeNameLabel);
end
timeNameLabel = uilabel(mainFig,'Text',' 时间 ');
timeNameLabel.Position = [260,480,60,20];
timeNameLabel.VerticalAlignment = 'center';
timeNameLabel.HorizontalAlignment = 'center';

if exist('timeLabel','var')
    delete(timeLabel);
end
timeLabel = uilabel(mainFig,'Text',' ');
timeLabel.Position = [260,460,60,20];
timeLabel.VerticalAlignment = 'center';
timeLabel.HorizontalAlignment = 'center';

if exist('dataNameLabel','var')
    delete(dataNameLabel);
end
dataNameLabel = uilabel(mainFig,'Text',' 数值 ');
dataNameLabel.Position = [320,480,60,20];
dataNameLabel.VerticalAlignment = 'center';
dataNameLabel.HorizontalAlignment = 'center';

if exist('dataLabel','var')
    delete(dataLabel);
end
dataLabel = uilabel(mainFig,'Text',' ');
dataLabel.Position = [320,460,60,20];
dataLabel.VerticalAlignment = 'center';
dataLabel.HorizontalAlignment = 'center';

if exist('offsetLabel','var')
    delete(offsetLabel);
end
offsetLabel = uilabel(mainFig,'Text',' 间距 ');
offsetLabel.Position = [420,480,60,20];
offsetLabel.VerticalAlignment = 'center';
offsetLabel.HorizontalAlignment = 'center';

if exist('offsetArea','var')
    delete(offsetArea);
end
offsetArea = uieditfield(mainFig, 'numeric');
offsetArea.Position = [420,460,60,20];
offsetArea.HorizontalAlignment = 'center';
offsetArea.Value = offset;
offsetArea.Limits = [0.0001,1000];
offsetArea.ValueChangedFcn = @(src, event) evalin('base','offsetChange');

if exist('addControl','var')
    delete(addControl);
end
addControl = uicontrol(mainFig);
addControl.Style = 'pushbutton';
addControl.String = ' + ';
addControl.FontSize = 12;
addControl.HorizontalAlignment = 'center';
addControl.Position = [490,480,30,20];
addControl.BackgroundColor = [0.65,0.65,0.65];
addControl.Callback = @(src, event) evalin('base','addGraphOffset');

if exist('subControl','var')
    delete(subControl);
end
subControl = uicontrol(mainFig);
subControl.Style = 'pushbutton';
subControl.String = ' - ';
subControl.FontSize = 12;
subControl.HorizontalAlignment = 'center';
subControl.Position = [490,460,30,20];
subControl.BackgroundColor = [0.65,0.65,0.65];
subControl.Callback = @(src, event) evalin('base','subGraphOffset');

if exist('timesetLabel','var')
    delete(timesetLabel);
end
timesetLabel = uilabel(mainFig,'Text',' 时间轴 ');
timesetLabel.Position = [550,480,60,20];
timesetLabel.VerticalAlignment = 'center';
timesetLabel.HorizontalAlignment = 'center';

if exist('timesetArea','var')
    delete(timesetArea);
end
timesetArea = uieditfield(mainFig, 'numeric');
timesetArea.Position = [550,460,60,20];
timesetArea.HorizontalAlignment = 'center';
timesetArea.Value = 5;
timesetArea.Limits = [2,10];
timesetArea.ValueChangedFcn = @(src, event) evalin('base','offsetChange');

if exist('addtimeControl','var')
    delete(addtimeControl);
end
addtimeControl = uicontrol(mainFig);
addtimeControl.Style = 'pushbutton';
addtimeControl.String = ' + ';
addtimeControl.FontSize = 12;
addtimeControl.HorizontalAlignment = 'center';
addtimeControl.Position = [620,480,30,20];
addtimeControl.BackgroundColor = [0.65,0.65,0.65];
addtimeControl.Callback = @(src, event) evalin('base','addGraphTimeset');

if exist('subtimeControl','var')
    delete(subtimeControl);
end
subtimeControl = uicontrol(mainFig);
subtimeControl.Style = 'pushbutton';
subtimeControl.String = ' - ';
subtimeControl.FontSize = 12;
subtimeControl.HorizontalAlignment = 'center';
subtimeControl.Position = [620,460,30,20];
subtimeControl.BackgroundColor = [0.65,0.65,0.65];
subtimeControl.Callback = @(src, event) evalin('base','subGraphTimeset');

if exist('resetControl','var')
    delete(resetControl);
end
resetControl = uicontrol(mainFig);
resetControl.Style = 'pushbutton';
resetControl.String = ' 重置图像 ';
resetControl.FontSize = 6;
resetControl.HorizontalAlignment = 'center';
resetControl.Position = [695,480,60,20];
resetControl.BackgroundColor = [0.8,0.8,0.8];
resetControl.Callback = @(src, event) evalin('base','reset_func');

if exist('InfControl','var')
    delete(InfControl);
end
InfControl = uicontrol(mainFig);
InfControl.Style = 'pushbutton';
InfControl.String = '数据信息';
InfControl.FontSize = 6;
InfControl.HorizontalAlignment = 'center';
InfControl.Position = [695,460,60,20];
InfControl.BackgroundColor = [0.8,0.8,0.8];
InfControl.Callback = @(src, event) evalin('base','Inf_GUI');

if exist('IcaControl','var')
    delete(IcaControl);
end
IcaControl = uicontrol(mainFig);
IcaControl.Style = 'pushbutton';
IcaControl.String  = ['I', newline, 'C', newline, 'A'];
IcaControl.FontSize = 8;
IcaControl.HorizontalAlignment = 'center';
IcaControl.Position = [874,396,26,60];
IcaControl.BackgroundColor = [0.8,0.8,0.8];
IcaControl.Callback = @(src, event) evalin('base','Ica_Process');

if exist('AveRefControl','var')
    delete(AveRefControl);
end
AveRefControl = uicontrol(mainFig);
AveRefControl.Style = 'pushbutton';
AveRefControl.String  = ['均', newline, '值', newline, '参', newline, '考'];
AveRefControl.FontSize = 8;
AveRefControl.HorizontalAlignment = 'center';
AveRefControl.Position = [874,316,26,80];
AveRefControl.BackgroundColor = [0.8,0.8,0.8];
AveRefControl.Callback = @(src, event) evalin('base','Ref_Process');

if exist('chanControl','var')
    delete(chanControl);
end
chanControl = uicontrol(mainFig);
chanControl.Style = 'pushbutton';
chanControl.String  = ['电', newline, '极', newline, '参', newline, '考'];
chanControl.FontSize = 8;
chanControl.HorizontalAlignment = 'center';
chanControl.Position = [874,236,26,80];
chanControl.BackgroundColor = [0.8,0.8,0.8];
chanControl.Callback = @(src, event) evalin('base','chan_Ref_Process');

if exist('FreControl','var')
    delete(FreControl);
end
FreControl = uicontrol(mainFig);
FreControl.Style = 'pushbutton';
FreControl.String  = ['频', newline, '域', newline, '图', newline, '像'];
FreControl.FontSize = 8;
FreControl.HorizontalAlignment = 'center';
FreControl.Position = [874,156,26,80];
FreControl.BackgroundColor = [0.8,0.8,0.8];
FreControl.Callback = @(src, event) evalin('base','EEGPlot_Process');

if exist('PlotControl','var')
    delete(PlotControl);
end
PlotControl = uicontrol(mainFig);
PlotControl.Style = 'pushbutton';
PlotControl.String  = ['电', newline, '极', newline, '标', newline, '记'];
PlotControl.FontSize = 8;
PlotControl.HorizontalAlignment = 'center';
PlotControl.Position = [874,76,26,80];
PlotControl.BackgroundColor = [0.8,0.8,0.8];
PlotControl.Callback = @(src, event) evalin('base','Plot_Process');

updatacheckbox = uicontrol(mainFig, 'Style', 'checkbox');
updatacheckbox.Position = [780,460,120,40];
updatacheckbox.String = ' 新建数据 ';
updatacheckbox.FontSize = 12;
updatacheckbox.FontWeight = 'bold';
updatacheckbox.BackgroundColor = [0.50,0.50,0.50];