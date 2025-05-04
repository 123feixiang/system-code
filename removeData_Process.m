%选取需要清除的数据
if isempty({dataInfMenu.Children.Text})
    %显示警告信息
    uialert(mainFig, ' 当前不存在数据 ', '数据清除', 'Icon', 'warning');
    return;
else
    %创建主界面
    removeDataFig = uifigure('Name', '选取清除数据', 'Position', [100, 100, 300, 400]);
    removeDataFig.Color = [0.15,0.15,0.15];
    %获取选取数据信息
    removeDataItems = {dataInfMenu.Children.Text};
    %创建文本提示
    removeDatalabel = uilabel(removeDataFig, 'Position', [75, 350, 160, 20], 'Text', '选择需要清除的数据：');
    removeDatalabel.FontSize = 16;                     %设置字体大小
    removeDatalabel.FontAngle = 'normal';              %设置字体是否倾斜
    removeDatalabel.FontColor = [1,1,1];
    removeDatalabel.FontWeight = 'bold';  
    removeDatalabel.HorizontalAlignment = 'center';      %设置字体水平居中
    removeDatalabel.VerticalAlignment = 'center';        %设置字体竖直居中
    
    %建立选择框选择数据
    removeDataLists = uilistbox(removeDataFig, 'Position', [50, 100, 200, 230], 'Items', removeDataItems, 'Multiselect', 'on', 'FontSize', 14, 'ValueChangedFcn', @(src, event) assignin('base', 'removeData', src.Value));
    %创建确认按钮
    ConfirmRemoveButton = uibutton(removeDataFig, 'push', 'Text', '清除', 'Position', [50, 40, 80, 30],'ButtonPushedFcn', @(btn, event) evalin('base', 'removeConfirm'));
    ConfirmRemoveButton.HorizontalAlignment = 'center';
    ConfirmRemoveButton.VerticalAlignment = 'center';
    ConfirmRemoveButton.Tooltip = '确认';
    %创建取消按钮
    CancelSelectButton = uibutton(removeDataFig, 'push', 'Text', '取消', 'Position', [170, 40, 80, 30],'ButtonPushedFcn', @(btn, event) close(removeDataFig));
    CancelSelectButton.HorizontalAlignment = 'center';
    CancelSelectButton.VerticalAlignment = 'center';
    CancelSelectButton.Tooltip = '取消';
end

