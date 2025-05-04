%设置dt训练的界面
%设置滤波图像
dtFig = uifigure('Name', '设置DT训练参数', 'Position', [500, 300, 300, 160]);
dtFig.Color = [0.15,0.15,0.15];

dtNumslabel = uilabel(dtFig, 'Position', [45, 120, 100, 20], 'Text', ' 预测次数： ');
dtNumslabel.FontColor = [1,1,1];
dtNumslabel.FontSize = 14;                     %设置字体大小
dtNumslabel.FontAngle = 'normal';              %设置字体是否倾斜
dtNumslabel.FontWeight = 'bold';  
dtNumslabel.HorizontalAlignment = 'center';      %设置字体水平居中
dtNumslabel.VerticalAlignment = 'center';        %设置字体竖直居中

dtNumsArea = uieditfield(dtFig, 'numeric');
dtNumsArea.Position = [145,120,100,20];
dtNumsArea.HorizontalAlignment = 'center';
dtNumsArea.Value = 10;
dtNumsArea.Limits = [5,15];

dtcheckbox = uicheckbox(dtFig);
dtcheckbox.Position = [65, 80, 100, 20];
dtcheckbox.FontColor = [1,1,1];
dtcheckbox.FontWeight = 'bold';
dtcheckbox.Text = ' 绘制决策树 ';
dtcheckbox.FontSize = 14;

%采样确认案件，确认后，更新EEG的采样率
dtconfirmButton = uibutton(dtFig, 'push', 'Text', '确认', 'Position', [110, 20, 80, 30],'ButtonPushedFcn', @(btn, event) evalin('base', 'dt_analyse'));
%设置按钮的水平和垂直对齐方式
dtconfirmButton.HorizontalAlignment = 'center';
dtconfirmButton.VerticalAlignment = 'center';
dtconfirmButton.Tooltip = '确认';
dtconfirmButton.BackgroundColor = [1,1,1];