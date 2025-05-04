if ~exist('outputFile','var')
    uialert(mainFig, ' 无特征值导入 ', '情感分析', 'Icon', 'error');
    return;
end

%开始对特征值进行分析
data = readmatrix(outputFile);

label = data(:, end);      %最后一列是标签
data = data(:,3:end-1);    %前两列是无关数据
data(isnan(data)) = 0;     %将非法值默认为0
[data_sta, ps] = mapminmax(data',-1,1); %对数据进行归一化
data = data_sta';
data = data(:,any(data));  %去除数据中全为0的列
%保存每一次测试的准确率与方差
dt_analyse_accuracy = zeros(1,floor(dtNumsArea.Value));
dt_analyse_std = zeros(1,floor(dtNumsArea.Value));
for k = 1:floor(dtNumsArea.Value)
    %整体数据分成训练集和测试集
    indices = crossvalind('Kfold', max(size(data,1)), 10); %将数据样本随机分割为10部分，将数据集划分为10个大小相同的互斥子集
    dtpredictlable = cell(10,1);%dt
    accuracy_dt = zeros(10,3);
    for i = 1:10
        test = (indices == i);
        train = ~test;%1：表示该组数据被选中，0：未被选中
        traindata = data(train, :);
        testdata = data(test, :);
        train_label = label(train,:);%label数组存放情感的三种分类情况
        test_label = label(test,:);
        newtrainX = [];
        newtrainY = [];
        newtestX = [];
        newtestY = [];
        perm1 = randperm(length(traindata(:,1)));
        newtrainX(:,:) = traindata(perm1,:);
        newtrainY(:,:) = train_label(perm1,:);
        perm2 = randperm(length(testdata(:,1)));
        newtestX(:,:) = testdata(perm2,:);
        newtestY(:,:) = test_label(perm2,:);
        %% DT决策树分析
        % 使用训练数据训练决策树模型
        model = fitctree(newtrainX, newtrainY,'Prune','on');
        %model = fitcecoc(newtrainX, newtrainY, 'Learners', templatedt('NumNeighbors', 5));
        [dtpredict_label, ~] = predict(model, newtestX);
        accuracys = sum(dtpredict_label == newtestY) / length(newtestY) * 100;
        accuracy_dt(i,:) = accuracys;
        dtpredictlable{i,1} = dtpredict_label;
    end
    %计算每次测试的平均准确率与方差
    mean_accuracys = mean(accuracy_dt(:,1));
    dt_sd = std(accuracy_dt(:,1));
    dt_analyse_accuracy(k) = mean_accuracys;
    dt_analyse_std(k) = dt_sd;
end


%读取cell数组
dt_cell = readcell(outputFile);
dt_import_nums = length(data);
%对特征数据进行绘图
dtCell = cell(dt_import_nums,3);
for i = 1:dt_import_nums
    file_name = dt_cell{i,2};
    feature = mat2str(cellfun(@(x) x(1), dt_cell(i,3:end-1)));
    label = mat2str(cellfun(@(x) x(1), dt_cell(i,end)));
    dtCell{i,1} = file_name;
    dtCell{i,2} = feature;
    dtCell{i,3} = label;
end


if exist('kfig','var')
    delete(kfig);
end
kfig = uifigure('Name', 'DT情感预测', 'Position', [100, 100, 900, 500]);
kfig.Color = [0.15, 0.15, 0.15];

if exist('featureLabel','var')
    delete(featureLabel);
end
dtLabel = uilabel(kfig);
dtLabel.Position = [10,460,200,24];
dtLabel.Text = '情感特征表格：';
dtLabel.FontSize = 20;
dtLabel.FontWeight = 'bold';
dtLabel.VerticalAlignment = 'center';
dtLabel.HorizontalAlignment = 'center';
dtLabel.FontColor = [1,1,1];

if exist('dtTable','var')
    delete(dtTable);
end
%创建表格信息显示当前所有数据的特征信息
dtTable = uitable(kfig);
dtTable.Data = dtCell;
dtTable.ColumnName = {'数据名称', '特征值','情感标签'};
dtTable.Position = [20,60,400,380];
dtTable.ColumnWidth = {150,100,200,100};
dtTable.FontSize = 12;
dtTable.FontWeight = 'bold';
dtTable.FontAngle = 'normal';

m = floor(dtNumsArea.Value);
mean_accuracy = mean(dt_analyse_accuracy);
mean_variance = mean(dt_analyse_std);

% 准确率折线图
if exist('accAxel','var')
    delete(accAxel);
end
accAxel = uiaxes(kfig);
accAxel.Position = [430, 260, 440, 230]; % 调整位置
accAxel.XColor = 'w'; % X 轴字体颜色改为白色
accAxel.YColor = 'w'; % Y 轴字体颜色改为白色
accAxel.Box = 'on';
title(accAxel, 'DT情感预测准确率', 'FontSize', 12, 'Color', 'w'); % 标题颜色改为白色
xlabel(accAxel, '测试轮次', 'Color', 'w'); % X 轴标签改为白色
ylabel(accAxel, '准确率 (%)', 'Color', 'w'); % Y 轴标签改为白色
hold(accAxel, 'on');
plot(accAxel, 1:m, dt_analyse_accuracy, '-k', 'LineWidth', 1.5); % 画折线图（不变）
yline(accAxel, mean_accuracy, '--r', ['平均准确率:',num2str(mean_accuracy)]); % 画均值线（不变）
text(m-2, mean_accuracy+0.5, sprintf('%.2f%%', mean_accuracy), 'Color', 'w', 'FontSize', 10, 'Parent', accAxel); % 均值文本颜色改为白色

% 固定坐标轴范围
xlim(accAxel, [1, m]);
ylim(accAxel, [min(dt_analyse_accuracy)-5, max(dt_analyse_accuracy)+5]);

% 禁用交互
disableDefaultInteractivity(accAxel);

% 方差折线图
if exist('varAxel','var')
    delete(varAxel);
end
varAxel = uiaxes(kfig);
varAxel.Position = [430, 10, 440, 230]; % 调整位置
varAxel.XColor = 'w'; % X 轴字体颜色改为白色
varAxel.YColor = 'w'; % Y 轴字体颜色改为白色
varAxel.Box = 'on';
title(varAxel, 'dt情感分析方差', 'FontSize', 10, 'Color', 'w'); % 标题颜色改为白色
xlabel(varAxel, '测试轮次', 'Color', 'w'); % X 轴标签改为白色
ylabel(varAxel, '方差', 'Color', 'w'); % Y 轴标签改为白色
hold(varAxel, 'on');
plot(varAxel, 1:m, dt_analyse_std, '-s', 'LineWidth', 1.5, 'Color', 'k'); % 画折线图（不变）
yline(varAxel, mean_variance, '--r', ['平均方差',num2str(mean_variance)]); % 画均值线（不变）
text(m-2, mean_variance+0.05, sprintf('%.4f', mean_variance), 'Color', 'w', 'FontSize', 10, 'Parent', varAxel); % 均值文本颜色改为白色

% 固定坐标轴范围
xlim(varAxel, [1, m]);
ylim(varAxel, [min(dt_analyse_std)-1, max(dt_analyse_std)+1]);

% 禁用交互
disableDefaultInteractivity(varAxel);

if dtcheckbox.Value
    %可视化决策树
    view(model, 'Mode', 'graph');
end

%关闭界面
close(dtFig);

