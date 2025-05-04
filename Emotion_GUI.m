%%
%EEG数据信息
EEG = [];             %存储当前正在处理的EEG信息
ALLEEG = [];          %存储当前已经导入的EEG数据
currentindex = 0;     %表示当前处理EEG数据在ALLEEG结构体内的位置
selectdataindex = 0;  %表示当前处理数据信息的
selectchannel = {};   %表示当前选择的通道名称
selectdeleteChannel = {};  %表示当前选择的需要删除的电极通道
isDraw = false;         %当前的坐标系是否有线条
isDrawPosition = 0;         %绘制线条的坐标值
referline = [];         %保存当前的直线信息
plotchannelIndex = [];       %获取当前选择的通道信息
selectData = {};        %当前需要分析的数据
removeData = {};        %当前需要删除的数据
fig_select = 1;         %当前显示的界面

%% 
%创建GUI界面
mainFig = uifigure('Name', '基于频域微状态的情感识别', 'Position', [100, 100, 900, 506]);
mainFig.Color = [0.79, 0.79, 0.79];
img = uiimage(mainFig); %在uifigure中添加一个uiimage
img.ImageSource = fullfile(pwd,"background.jpg"); % 设置图片路径
img.Position = [0 0 mainFig.Position(3) mainFig.Position(4)]; % 让图片填充整个窗口

%%
fileMenu = uimenu(mainFig,'Text','  文件  ');
importMenu = uimenu(fileMenu,'Text',' 数据导入 ');
simpleImportMenu = uimenu(importMenu,'Text',' 独立数据处理 ','MenuSelectedFcn', @(src, event) evalin('base', 'fileImport'));
multyImportMenu = uimenu(importMenu,'Text',' 批量数据处理 ','MenuSelectedFcn', @(src, event) evalin('base', 'manyfileimport'));
exportMenu = uimenu(fileMenu,'Text',' 数据保存 ');
simpleExportMenu = uimenu(exportMenu,'Text',' 独立数据保存 ','MenuSelectedFcn', @(src, event) evalin('base', 'simpledataSave'));
multyExportMenu = uimenu(exportMenu,'Text',' 批量数据保存 ','MenuSelectedFcn', @(src, event) evalin('base', 'manydataSave'));

%%
toolMenu = uimenu(mainFig,'Text','  工具  ');
sampleMenu = uimenu(toolMenu,'Text',' 采样率 ','MenuSelectedFcn', @(src, event) evalin('base', 'sample_Process'));
filterMenu = uimenu(toolMenu,'Text',' 滤波 ');
basicfilterMenu = uimenu(filterMenu,'Text',' 带通滤波 ','MenuSelectedFcn', @(src, event) evalin('base', 'fliter_Process'));
frefilterMenu = uimenu(filterMenu,'Text',' 分频滤波 ','MenuSelectedFcn', @(src, event) evalin('base', 'frequency_Process'));
channelMenu = uimenu(toolMenu,'Text',' 电极 ');
channelNameMenu = uimenu(channelMenu,'Text',' 电极信息 ','MenuSelectedFcn', @(src, event) evalin('base', 'chanPlot_Process'));
channelRemoveMenu = uimenu(channelMenu,'Text',' 电极剔除 ','MenuSelectedFcn', @(src, event) evalin('base', 'deleteChan_Process'));
toolMenu.Enable = 'off';

%%
featureMenu = uimenu(mainFig,'Text','  特征  ');
calFeatureMenu = uimenu(featureMenu,'Text',' 特征值计算 ','MenuSelectedFcn', @(src, event) evalin('base', 'SelectFeatures_Process'));
microPlotMenu = uimenu(featureMenu,'Text',' 微状态原型 ','MenuSelectedFcn', @(src, event) evalin('base', 'Plot_Microstate'));
featureInfMenu = uimenu(featureMenu,'Text',' 特征值信息 ','MenuSelectedFcn', @(src, event) evalin('base', 'feature_Inf'));
featureSaveMenu = uimenu(featureMenu,'Text',' 特征值保存 ','MenuSelectedFcn', @(src, event) evalin('base', 'feature_Save'));
featureMenu.Enable = 'off';

%%
analyseMenu = uimenu(mainFig,"Text",'  分析  ');
trainMenu = uimenu(analyseMenu,'Text',' 特征值导入 ','MenuSelectedFcn', @(src, event) evalin('base', 'train_import'));
emotionMenu = uimenu(analyseMenu,'Text',' 情感分析 ');
svmEmtionMenu = uimenu(emotionMenu,'Text',' SVM ','MenuSelectedFcn', @(src, event) evalin('base', 'svm_train'));
knnEmotionMenu = uimenu(emotionMenu,'Text',' KNN ','MenuSelectedFcn', @(src, event) evalin('base', 'knn_train'));
dtEmotionMenu = uimenu(emotionMenu,'Text',' DT ','MenuSelectedFcn', @(src, event) evalin('base', 'dt_train'));
testMenu = uimenu(analyseMenu,'Text',' 情感预测 ','MenuSelectedFcn', @(src, event) evalin('base', 'emotion_predict'));

%%
dataMenu = uimenu(mainFig,"Text",'  数据集  ');
dataInfMenu = uimenu(dataMenu,'Text',' 数据信息 ');
dataCleanMenu = uimenu(dataMenu,'Text','数据清除', 'MenuSelectedFcn' ,@(src, event) evalin('base', 'removeData_Process'));
dataMenu.Enable = 'off';