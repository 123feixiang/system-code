%设置EEG频域图像绘制
PlotFig = uifigure('Name', '频域图像绘制', 'Position', [500, 300, 300, 230]);
PlotFig.Color = [0.15,0.15,0.15];

scalpLabel = uilabel(PlotFig, 'Position', [45, 180, 100, 30], 'Text', ' 样本频率： ');
scalpLabel.FontColor = [1,1,1];
scalpLabel.FontSize = 16;                     %设置字体大小
scalpLabel.FontAngle = 'normal';              %设置字体是否倾斜
scalpLabel.FontWeight = 'bold';  
scalpLabel.HorizontalAlignment = 'center';      %设置字体水平居中
scalpLabel.VerticalAlignment = 'center';        %设置字体竖直居中

scalpArea = uieditfield(PlotFig);
scalpArea.Position = [145,180,100,30];
scalpArea.HorizontalAlignment = 'center';
scalpArea.Value = ['2','  6','  8'];
scalpArea.FontWeight = 'bold';
scalpArea.FontSize = 16;
scalpArea.ValueChangedFcn = @(src,event) validateInput(src);

LowScalpLabel = uilabel(PlotFig, 'Position', [45, 130, 100, 30], 'Text', ' 最低频率： ');
LowScalpLabel.FontColor = [1,1,1];
LowScalpLabel.FontSize = 16;                     %设置字体大小
LowScalpLabel.FontAngle = 'normal';              %设置字体是否倾斜
LowScalpLabel.FontWeight = 'bold';  
LowScalpLabel.HorizontalAlignment = 'center';      %设置字体水平居中
LowScalpLabel.VerticalAlignment = 'center';        %设置字体竖直居中

LowScalpArea = uieditfield(PlotFig,'numeric');
LowScalpArea.Position = [145,130,100,30];
LowScalpArea.HorizontalAlignment = 'center';
LowScalpArea.Value = 2;
LowScalpArea.Limits = [0.01,EEG.srate/2];
LowScalpArea.FontWeight = 'bold';
LowScalpArea.FontSize = 16;

HighScalpLabel = uilabel(PlotFig, 'Position', [45, 80, 100, 30], 'Text', ' 最高频率： ');
HighScalpLabel.FontColor = [1,1,1];
HighScalpLabel.FontSize = 16;                     %设置字体大小
HighScalpLabel.FontAngle = 'normal';              %设置字体是否倾斜
HighScalpLabel.FontWeight = 'bold';  
HighScalpLabel.HorizontalAlignment = 'center';      %设置字体水平居中
HighScalpLabel.VerticalAlignment = 'center';        %设置字体竖直居中

HighScalpArea = uieditfield(PlotFig,'numeric');
HighScalpArea.Position = [145,80,100,30];
HighScalpArea.HorizontalAlignment = 'center';
HighScalpArea.Value = 50;
HighScalpArea.Limits = [1,EEG.srate/2];
HighScalpArea.FontWeight = 'bold';
HighScalpArea.FontSize = 16;

%绘制所选范围内的图像信息
plotconfirmButton = uibutton(PlotFig, 'push', 'Text', '确认', 'Position', [110, 20, 80, 30],'ButtonPushedFcn', @(btn, event) evalin('base', 'plotConfirm'));
%设置按钮的水平和垂直对齐方式
plotconfirmButton.HorizontalAlignment = 'center';
plotconfirmButton.VerticalAlignment = 'center';
plotconfirmButton.Tooltip = '确认';
plotconfirmButton.BackgroundColor = [1,1,1];

validatedNumbers = scalpArea.Value;
%%
%创建回调函数，检测输入框的格式是否正确校验输入
function validateInput(src)
    userInput = strtrim(src.Value); %去除首尾空格
    pattern = '^\d+\s+\d+\s+\d+$'; %正则匹配格式：整数 空格 整数 空格 整数
    if ~isempty(regexp(userInput, pattern, 'once')) 
        assignin('base', 'validatedNumbers', userInput); %存入工作区变量
    else
        uialert(src.Parent, '请输入正确格式：三个整数，中间用空格隔开，如 "1  2  3"', '格式错误', 'Icon', 'error');
        src.Value = ''; %清空输入框
    end
end