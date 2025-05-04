%设置采样率
sampleFig = uifigure('Name', '设置采样率', 'Position', [500, 300, 300, 200]);
sampleFig.Color = [0.15,0.15,0.15];

currentsamplelabel = uilabel(sampleFig, 'Position', [65, 150, 100, 20], 'Text', ' 原采样率： ');
currentsamplelabel.FontColor = [1,1,1];
currentsamplelabel.FontSize = 14;                     %设置字体大小
currentsamplelabel.FontAngle = 'normal';              %设置字体是否倾斜
currentsamplelabel.FontWeight = 'bold';  
currentsamplelabel.HorizontalAlignment = 'center';      %设置字体水平居中
currentsamplelabel.VerticalAlignment = 'center';        %设置字体竖直居中

currentsamlbl = uilabel(sampleFig, 'Position', [175, 150, 100, 20]);
currentsamlbl.Text = [num2str(EEG.srate),'Hz'];
currentsamlbl.FontColor = [1,1,1];
currentsamlbl.FontSize = 14;                     %设置字体大小
currentsamlbl.FontAngle = 'normal';              %设置字体是否倾斜
currentsamlbl.FontWeight = 'bold';  
currentsamlbl.VerticalAlignment = 'center';        %设置字体竖直居中


samplelabel = uilabel(sampleFig, 'Position', [65, 100, 100, 20], 'Text', ' 新采样率： ');
samplelabel.FontColor = [1,1,1];
samplelabel.FontSize = 14;                     %设置字体大小
samplelabel.FontAngle = 'normal';              %设置字体是否倾斜
samplelabel.FontWeight = 'bold';  
samplelabel.HorizontalAlignment = 'center';      %设置字体水平居中
samplelabel.VerticalAlignment = 'center';        %设置字体竖直居中

sampleArea = uieditfield(sampleFig, 'numeric');
sampleArea.Position = [165,100,60,20];
sampleArea.HorizontalAlignment = 'center';
sampleArea.Value = 200;
sampleArea.Limits = [100,1000];
sampleArea.ValueChangedFcn = @(src, event) evalin('base','sampleArea.Value = floor(sampleArea.Value);');

%采样确认案件，确认后，更新EEG的采样率
SampleconfirmButton = uibutton(sampleFig, 'push', 'Text', '确认', 'Position', [110, 40, 80, 30],'ButtonPushedFcn', @(btn, event) evalin('base', 'SampleConfirm'));
%设置按钮的水平和垂直对齐方式
SampleconfirmButton.HorizontalAlignment = 'center';
SampleconfirmButton.VerticalAlignment = 'center';
SampleconfirmButton.Tooltip = '确认';
SampleconfirmButton.BackgroundColor = [1,1,1];