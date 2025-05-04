%设置电极参考
if isempty(EEG.chanlocs)
    %显示警告信息
    uialert(mainFig, '无通道信息！', '重参考', 'Icon', 'warning');
    return;
else
    %创建主界面
    channelFig = uifigure('Name', '选择参考电极', 'Position', [100, 100, 300, 400]);
    %获取通道信息
    channelItems = {EEG.chanlocs.labels};
    %创建文本提示
    channellabel = uilabel(channelFig, 'Position', [75, 350, 160, 20], 'Text', '选择参考电极：');
    channellabel.FontSize = 16;                     %设置字体大小
    channellabel.FontAngle = 'normal';              %设置字体是否倾斜
    channellabel.FontWeight = 'bold';  
    channellabel.HorizontalAlignment = 'center';      %设置字体水平居中
    channellabel.VerticalAlignment = 'center';        %设置字体竖直居中
    %建立选择框选择通道
    channelLists = uilistbox(channelFig, 'Position', [50, 100, 200, 230], 'Items', channelItems, 'Multiselect', 'on', 'FontSize', 14, 'ValueChangedFcn', @(src, event) assignin('base', 'selectchannel', src.Value));
    %创建确认按钮
    ConfirmReferenceButton = uibutton(channelFig, 'push', 'Text', '确认', 'Position', [50, 40, 80, 30],'ButtonPushedFcn', @(btn, event) evalin('base', 'channel_Ref'));
    ConfirmReferenceButton.HorizontalAlignment = 'center';
    ConfirmReferenceButton.VerticalAlignment = 'center';
    ConfirmReferenceButton.Tooltip = '确认';
    %创建取消按钮
    CancelReferenceButton = uibutton(channelFig, 'push', 'Text', '取消', 'Position', [170, 40, 80, 30],'ButtonPushedFcn', @(btn, event) close(channelFig));
    CancelReferenceButton.HorizontalAlignment = 'center';
    CancelReferenceButton.VerticalAlignment = 'center';
    CancelReferenceButton.Tooltip = '取消';
end