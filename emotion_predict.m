%设置dt训练的界面
%设置滤波图像
preFig = uifigure('Name', '情感预测', 'Position', [500, 300, 450, 300]);
preFig.Color = [0.15,0.15,0.15];

trainlabel = uilabel(preFig, 'Position', [20, 230, 150, 30], 'Text', '训练模型导入:');
trainlabel.FontColor = [1,1,1];
trainlabel.FontSize = 18;                     %设置字体大小
trainlabel.FontAngle = 'normal';              %设置字体是否倾斜
trainlabel.FontWeight = 'bold';  
trainlabel.HorizontalAlignment = 'center';      %设置字体水平居中
trainlabel.VerticalAlignment = 'center';        %设置字体竖直居中

trainArea = uieditfield(preFig);
trainArea.Position = [190,230,200,30];
trainArea.HorizontalAlignment = 'center';

trainButton = uibutton(preFig);
trainButton.Position = [400,230,30,30];
trainButton.HorizontalAlignment = 'center';
trainButton.Text = '···';
trainButton.ButtonPushedFcn = @(btn, event) evalin('base', 'train_excel');

testlabel = uilabel(preFig, 'Position', [20, 160, 150, 30], 'Text', '测试数据导入:');
testlabel.FontColor = [1,1,1];
testlabel.FontSize = 18;                     %设置字体大小
testlabel.FontAngle = 'normal';              %设置字体是否倾斜
testlabel.FontWeight = 'bold';  
testlabel.HorizontalAlignment = 'center';      %设置字体水平居中
testlabel.VerticalAlignment = 'center';        %设置字体竖直居中

testArea = uieditfield(preFig);
testArea.Position = [190,160,200,30];
testArea.HorizontalAlignment = 'center';

testButton = uibutton(preFig);
testButton.Position = [400,160,30,30];
testButton.HorizontalAlignment = 'center';
testButton.Text = '···';
testButton.ButtonPushedFcn = @(btn, event) evalin('base', 'test_excel');

waylabel = uilabel(preFig, 'Position', [20, 90, 150, 30], 'Text', '训练方法选择:');
waylabel.FontColor = [1,1,1];
waylabel.FontSize = 18;                     %设置字体大小
waylabel.FontAngle = 'normal';              %设置字体是否倾斜
waylabel.FontWeight = 'bold';  
waylabel.HorizontalAlignment = 'center';      %设置字体水平居中
waylabel.VerticalAlignment = 'center';        %设置字体竖直居中

predropdown = uidropdown(preFig);
predropdown.Items = {'SVM(支持向量机)','KNN(K-近邻算法)','DT(决策树算法)'};
predropdown.Position = [190,90,200,30];

%采样确认案件，确认后，更新EEG的采样率
preconfirmButton = uibutton(preFig, 'push', 'Text', '确认', 'Position', [110, 20, 80, 30],'ButtonPushedFcn', @(btn, event) evalin('base', 'train_test_predict'));
%设置按钮的水平和垂直对齐方式
preconfirmButton.HorizontalAlignment = 'center';
preconfirmButton.VerticalAlignment = 'center';
preconfirmButton.Tooltip = '确认';
preconfirmButton.BackgroundColor = [1,1,1];

%采样确认案件，确认后，更新EEG的采样率
precancelButton = uibutton(preFig, 'push', 'Text', '取消', 'Position', [260, 20, 80, 30],'ButtonPushedFcn', @(btn, event) evalin('base', 'close(preFig)'));
%设置按钮的水平和垂直对齐方式
precancelButton.HorizontalAlignment = 'center';
precancelButton.VerticalAlignment = 'center';
precancelButton.Tooltip = '取消';
precancelButton.BackgroundColor = [1,1,1];