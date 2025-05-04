%设置SVM训练的界面
%设置滤波图像
svmFig = uifigure('Name', '设置SVM训练参数', 'Position', [500, 300, 300, 200]);
svmFig.Color = [0.15,0.15,0.15];

svmFaultlabel = uilabel(svmFig, 'Position', [45, 160, 100, 20], 'Text', ' 惩罚参数： ');
svmFaultlabel.FontColor = [1,1,1];
svmFaultlabel.FontSize = 14;                     %设置字体大小
svmFaultlabel.FontAngle = 'normal';              %设置字体是否倾斜
svmFaultlabel.FontWeight = 'bold';  
svmFaultlabel.HorizontalAlignment = 'center';      %设置字体水平居中
svmFaultlabel.VerticalAlignment = 'center';        %设置字体竖直居中

svmFaultArea = uieditfield(svmFig, 'numeric');
svmFaultArea.Position = [145,160,100,20];
svmFaultArea.HorizontalAlignment = 'center';
svmFaultArea.Value = 10;
svmFaultArea.Limits = [1,30];

svmGammalabel = uilabel(svmFig, 'Position', [45, 120, 100, 20], 'Text', ' Gamma： ');
svmGammalabel.FontColor = [1,1,1];
svmGammalabel.FontSize = 14;                     %设置字体大小
svmGammalabel.FontAngle = 'normal';              %设置字体是否倾斜
svmGammalabel.FontWeight = 'bold';  
svmGammalabel.HorizontalAlignment = 'center';      %设置字体水平居中
svmGammalabel.VerticalAlignment = 'center';        %设置字体竖直居中

svmGammaArea = uieditfield(svmFig, 'numeric');
svmGammaArea.Position = [145,120,100,20];
svmGammaArea.HorizontalAlignment = 'center';
svmGammaArea.Value = 0.5;
svmGammaArea.Limits = [0.01,5];

svmNumslabel = uilabel(svmFig, 'Position', [45, 80, 100, 20], 'Text', ' 预测次数： ');
svmNumslabel.FontColor = [1,1,1];
svmNumslabel.FontSize = 14;                     %设置字体大小
svmNumslabel.FontAngle = 'normal';              %设置字体是否倾斜
svmNumslabel.FontWeight = 'bold';  
svmNumslabel.HorizontalAlignment = 'center';      %设置字体水平居中
svmNumslabel.VerticalAlignment = 'center';        %设置字体竖直居中

svmNumsArea = uieditfield(svmFig, 'numeric');
svmNumsArea.Position = [145,80,100,20];
svmNumsArea.HorizontalAlignment = 'center';
svmNumsArea.Value = 10;
svmNumsArea.Limits = [5,15];

%采样确认案件，确认后，更新EEG的采样率
svmconfirmButton = uibutton(svmFig, 'push', 'Text', '确认', 'Position', [110, 20, 80, 30],'ButtonPushedFcn', @(btn, event) evalin('base', 'svm_analyse'));
%设置按钮的水平和垂直对齐方式
svmconfirmButton.HorizontalAlignment = 'center';
svmconfirmButton.VerticalAlignment = 'center';
svmconfirmButton.Tooltip = '确认';
svmconfirmButton.BackgroundColor = [1,1,1];