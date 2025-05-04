%选择数据进行特征提取
if isempty({dataInfMenu.Children.Text})
    %显示警告信息
    uialert(mainFig, ' 当前不存在数据 ', '数据选取', 'Icon', 'warning');
    return;
else
    %创建主界面
    selectDataFig = uifigure('Name', '特征提取数据选取', 'Position', [100, 100, 300, 400]);
    selectDataFig.Color = [0.15,0.15,0.15];
    %获取选取数据信息
    selectDataItems = {dataInfMenu.Children.Text};
    %创建文本提示
    selectDatalabel = uilabel(selectDataFig, 'Position', [75, 350, 160, 20], 'Text', '选择分析数据：');
    selectDatalabel.FontSize = 16;                     %设置字体大小
    selectDatalabel.FontAngle = 'normal';              %设置字体是否倾斜
    selectDatalabel.FontColor = [1,1,1];
    selectDatalabel.FontWeight = 'bold';  
    selectDatalabel.HorizontalAlignment = 'center';      %设置字体水平居中
    selectDatalabel.VerticalAlignment = 'center';        %设置字体竖直居中
    
    %建立选择框选择通道
    selectDataLists = uilistbox(selectDataFig, 'Position', [50, 100, 200, 230], 'Items', selectDataItems, 'Multiselect', 'on', 'FontSize', 14, 'ValueChangedFcn', @(src, event) assignin('base', 'selectData', src.Value));
    %创建确认按钮
    ConfirmSelectButton = uibutton(selectDataFig, 'push', 'Text', '确认', 'Position', [50, 40, 80, 30],'ButtonPushedFcn', @(btn, event) evalin('base', 'calculate_features'));
    ConfirmSelectButton.HorizontalAlignment = 'center';
    ConfirmSelectButton.VerticalAlignment = 'center';
    ConfirmSelectButton.Tooltip = '确认';
    %创建取消按钮
    CancelSelectButton = uibutton(selectDataFig, 'push', 'Text', '取消', 'Position', [170, 40, 80, 30],'ButtonPushedFcn', @(btn, event) close(selectDataFig));
    CancelSelectButton.HorizontalAlignment = 'center';
    CancelSelectButton.VerticalAlignment = 'center';
    CancelSelectButton.Tooltip = '取消';
end