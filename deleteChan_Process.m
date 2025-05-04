%剔除无关的通道
%设置电极参考
if isempty(EEG.chanlocs)
    %显示警告信息
    uialert(mainFig, '无通道信息！', '电极剔除', 'Icon', 'warning');
    return;
else
    %创建主界面
    deleteChannelFig = uifigure('Name', '电极剔除', 'Position', [100, 100, 300, 400]);
    deleteChannelFig.Color = [0.15,0.15,0.15];

    %获取通道信息
    deleteChannelItems = {EEG.chanlocs.labels};
    %创建文本提示
    deleteChannellabel = uilabel(deleteChannelFig, 'Position', [75, 350, 160, 20], 'Text', '选择剔除电极：');
    deleteChannellabel.FontSize = 16;                     %设置字体大小
    deleteChannellabel.FontAngle = 'normal';              %设置字体是否倾斜
    deleteChannellabel.FontWeight = 'bold';  
    deleteChannellabel.HorizontalAlignment = 'center';      %设置字体水平居中
    deleteChannellabel.VerticalAlignment = 'center';        %设置字体竖直居中
    deleteChannellabel.FontColor = [1,1,1];

    %建立选择框选择通道
    deleteChannelLists = uilistbox(deleteChannelFig, 'Position', [50, 100, 200, 230], 'Items', deleteChannelItems, 'Multiselect', 'on', 'FontSize', 14, 'ValueChangedFcn', @(src, event) assignin('base', 'selectdeleteChannel', src.Value));

    %创建确认按钮
    ConfirmDeleteButton = uibutton(deleteChannelFig, 'push', 'Text', '确认', 'Position', [50, 40, 80, 30],'ButtonPushedFcn', @(btn, event) evalin('base', 'deleteChannelConfirm'));
    ConfirmDeleteButton.HorizontalAlignment = 'center';
    ConfirmDeleteButton.VerticalAlignment = 'center';
    ConfirmDeleteButton.Tooltip = '确认';
    
    %创建取消按钮
    CancelDeleteButton = uibutton(deleteChannelFig, 'push', 'Text', '取消', 'Position', [170, 40, 80, 30],'ButtonPushedFcn', @(btn, event) close(deleteChannelFig));
    CancelDeleteButton.HorizontalAlignment = 'center';
    CancelDeleteButton.VerticalAlignment = 'center';
    CancelDeleteButton.Tooltip = '取消';
end
