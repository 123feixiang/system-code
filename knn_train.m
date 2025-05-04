%设置knn训练的界面
%设置滤波图像
knnFig = uifigure('Name', '设置KNN训练参数', 'Position', [500, 300, 300, 160]);
knnFig.Color = [0.15,0.15,0.15];

knnNeighlabel = uilabel(knnFig, 'Position', [45, 120, 100, 20], 'Text', ' 邻居数量： ');
knnNeighlabel.FontColor = [1,1,1];
knnNeighlabel.FontSize = 14;                     %设置字体大小
knnNeighlabel.FontAngle = 'normal';              %设置字体是否倾斜
knnNeighlabel.FontWeight = 'bold';  
knnNeighlabel.HorizontalAlignment = 'center';      %设置字体水平居中
knnNeighlabel.VerticalAlignment = 'center';        %设置字体竖直居中

knnNeighArea = uieditfield(knnFig, 'numeric');
knnNeighArea.Position = [145,120,100,20];
knnNeighArea.HorizontalAlignment = 'center';
knnNeighArea.Value = 4;
knnNeighArea.Limits = [1,12];

knnNumslabel = uilabel(knnFig, 'Position', [45, 80, 100, 20], 'Text', ' 预测次数： ');
knnNumslabel.FontColor = [1,1,1];
knnNumslabel.FontSize = 14;                     %设置字体大小
knnNumslabel.FontAngle = 'normal';              %设置字体是否倾斜
knnNumslabel.FontWeight = 'bold';  
knnNumslabel.HorizontalAlignment = 'center';      %设置字体水平居中
knnNumslabel.VerticalAlignment = 'center';        %设置字体竖直居中

knnNumsArea = uieditfield(knnFig, 'numeric');
knnNumsArea.Position = [145,80,100,20];
knnNumsArea.HorizontalAlignment = 'center';
knnNumsArea.Value = 10;
knnNumsArea.Limits = [5,15];

%采样确认案件，确认后，更新EEG的采样率
knnconfirmButton = uibutton(knnFig, 'push', 'Text', '确认', 'Position', [110, 20, 80, 30],'ButtonPushedFcn', @(btn, event) evalin('base', 'knn_analyse'));
%设置按钮的水平和垂直对齐方式
knnconfirmButton.HorizontalAlignment = 'center';
knnconfirmButton.VerticalAlignment = 'center';
knnconfirmButton.Tooltip = '确认';
knnconfirmButton.BackgroundColor = [1,1,1];