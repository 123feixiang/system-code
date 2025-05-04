%设置电极参考
if isempty(EEG.chanlocs)
    %显示警告信息
    uialert(mainFig, '无通道信息！', '通道选取', 'Icon', 'warning');
    return;
else
    %创建主界面
    plotchannelFig = uifigure('Name', '选择图像电极', 'Position', [100, 100, 300, 400]);
    plotchannelFig.Color = [0.15,0.15,0.15];
    %获取通道信息
    plotchannelItems = {EEG.chanlocs.labels};
    %创建文本提示
    plotchannellabel = uilabel(plotchannelFig, 'Position', [75, 350, 160, 20], 'Text', '选择图像电极：');
    plotchannellabel.FontSize = 16;                     %设置字体大小
    plotchannellabel.FontAngle = 'normal';              %设置字体是否倾斜
    plotchannellabel.FontColor = [1,1,1];
    plotchannellabel.FontWeight = 'bold';  
    plotchannellabel.HorizontalAlignment = 'center';      %设置字体水平居中
    plotchannellabel.VerticalAlignment = 'center';        %设置字体竖直居中
    %建立选择框选择通道
    plotchannelLists = uilistbox(plotchannelFig, 'Position', [50, 100, 200, 230], 'Items', plotchannelItems, 'Multiselect', 'on', 'FontSize', 14, 'ValueChangedFcn', @(src, event) assignin('base', 'plotchannel', src.Value));
    %创建确认按钮
    ConfirmPlotButton = uibutton(plotchannelFig, 'push', 'Text', '确认', 'Position', [50, 40, 80, 30],'ButtonPushedFcn', @(btn, event) evalin('base', 'plot_Channel'));
    ConfirmPlotButton.HorizontalAlignment = 'center';
    ConfirmPlotButton.VerticalAlignment = 'center';
    ConfirmPlotButton.Tooltip = '确认';
    %创建取消按钮
    CancelPlotButton = uibutton(plotchannelFig, 'push', 'Text', '取消', 'Position', [170, 40, 80, 30],'ButtonPushedFcn', @(btn, event) close(plotchannelFig));
    CancelPlotButton.HorizontalAlignment = 'center';
    CancelPlotButton.VerticalAlignment = 'center';
    CancelPlotButton.Tooltip = '取消';
end