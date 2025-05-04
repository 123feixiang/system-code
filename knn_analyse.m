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
knn_analyse_accuracy = zeros(1,floor(knnNumsArea.Value));
knn_analyse_std = zeros(1,floor(knnNumsArea.Value));
for k = 1:floor(knnNumsArea.Value)
    %整体数据分成训练集和测试集
    indices = crossvalind('Kfold', max(size(data,1)), 10); %将数据样本随机分割为10部分，将数据集划分为10个大小相同的互斥子集
    knnpredictlable = cell(10,1);%knn
    accuracy_knn = zeros(10,3);
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
        %% knn分析
        k_value = floor(knnNeighArea.Value);  %设置KNN分类中的邻居数量
        model = fitcknn(newtrainX, newtrainY, 'NumNeighbors', k_value, 'Distance', 'euclidean');
        % 使用训练数据训练决策树模型
        %model = fitctree(newtrainX, newtrainY);
        %model = fitcecoc(newtrainX, newtrainY, 'Learners', templateKNN('NumNeighbors', 5));
        [knnpredict_label, ~] = predict(model, newtestX);
        accuracys = sum(knnpredict_label == newtestY) / length(newtestY) * 100;
        accuracy_knn(i,:) = accuracys;
        knnpredictlable{i,1} = knnpredict_label;
    end
    %计算每次测试的平均准确率与方差
    mean_accuracys = mean(accuracy_knn(:,1));
    knn_sd = std(accuracy_knn(:,1));
    knn_analyse_accuracy(k) = mean_accuracys;
    knn_analyse_std(k) = knn_sd;
end

%读取cell数组
knn_cell = readcell(outputFile);
knn_import_nums = length(data);
%对特征数据进行绘图
knnCell = cell(knn_import_nums,3);
for i = 1:knn_import_nums
    file_name = knn_cell{i,2};
    feature = mat2str(cellfun(@(x) x(1), knn_cell(i,3:end-1)));
    label = mat2str(cellfun(@(x) x(1), knn_cell(i,end)));
    knnCell{i,1} = file_name;
    knnCell{i,2} = feature;
    knnCell{i,3} = label;
end


if exist('kfig','var')
    delete(kfig);
end
kfig = uifigure('Name', 'KNN情感预测', 'Position', [100, 100, 900, 500]);
kfig.Color = [0.15, 0.15, 0.15];

if exist('featureLabel','var')
    delete(featureLabel);
end
knnLabel = uilabel(kfig);
knnLabel.Position = [10,460,200,24];
knnLabel.Text = '情感特征表格：';
knnLabel.FontSize = 20;
knnLabel.FontWeight = 'bold';
knnLabel.VerticalAlignment = 'center';
knnLabel.HorizontalAlignment = 'center';
knnLabel.FontColor = [1,1,1];

if exist('knnTable','var')
    delete(knnTable);
end
%创建表格信息显示当前所有数据的特征信息
knnTable = uitable(kfig);
knnTable.Data = knnCell;
knnTable.ColumnName = {'数据名称', '特征值','情感标签'};
knnTable.Position = [20,60,400,380];
knnTable.ColumnWidth = {150,100,200,100};
knnTable.FontSize = 12;
knnTable.FontWeight = 'bold';
knnTable.FontAngle = 'normal';

m = floor(knnNumsArea.Value);
mean_accuracy = mean(knn_analyse_accuracy);
mean_variance = mean(knn_analyse_std);

% 准确率折线图
if exist('accAxel','var')
    delete(accAxel);
end
accAxel = uiaxes(kfig);
accAxel.Position = [430, 260, 440, 230]; % 调整位置
accAxel.XColor = 'w'; % X 轴字体颜色改为白色
accAxel.YColor = 'w'; % Y 轴字体颜色改为白色
accAxel.Box = 'on';
title(accAxel, 'KNN情感预测准确率', 'FontSize', 12, 'Color', 'w'); % 标题颜色改为白色
xlabel(accAxel, '测试轮次', 'Color', 'w'); % X 轴标签改为白色
ylabel(accAxel, '准确率 (%)', 'Color', 'w'); % Y 轴标签改为白色
hold(accAxel, 'on');
plot(accAxel, 1:m, knn_analyse_accuracy, '-r', 'LineWidth', 1.5); % 画折线图（不变）
yline(accAxel, mean_accuracy, '--r', ['平均准确率:',num2str(mean_accuracy)]); % 画均值线（不变）
text(m-2, mean_accuracy+0.5, sprintf('%.2f%%', mean_accuracy), 'Color', 'w', 'FontSize', 10, 'Parent', accAxel); % 均值文本颜色改为白色

% 固定坐标轴范围
xlim(accAxel, [1, m]);
ylim(accAxel, [min(knn_analyse_accuracy)-5, max(knn_analyse_accuracy)+5]);

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
title(varAxel, 'KNN情感分析方差', 'FontSize', 10, 'Color', 'w'); % 标题颜色改为白色
xlabel(varAxel, '测试轮次', 'Color', 'w'); % X 轴标签改为白色
ylabel(varAxel, '方差', 'Color', 'w'); % Y 轴标签改为白色
hold(varAxel, 'on');
plot(varAxel, 1:m, knn_analyse_std, '-s', 'LineWidth', 1.5, 'Color', 'r'); % 画折线图（不变）
yline(varAxel, mean_variance, '--r', ['平均方差',num2str(mean_variance)]); % 画均值线（不变）
text(m-2, mean_variance+0.05, sprintf('%.4f', mean_variance), 'Color', 'w', 'FontSize', 10, 'Parent', varAxel); % 均值文本颜色改为白色

% 固定坐标轴范围
xlim(varAxel, [1, m]);
ylim(varAxel, [min(knn_analyse_std)-1, max(knn_analyse_std)+1]);

% 禁用交互
disableDefaultInteractivity(varAxel);

%关闭界面
close(knnFig);
