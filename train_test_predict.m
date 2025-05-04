%导入训练模型与测试模型进程情感预测
train_file = trainArea.Value;
test_file = testArea.Value;

if isempty(train_file) || isempty(test_file)
    %设置提示框信息
    uialert(mainFig, '请输入文件地址', '情感预测', 'Icon', 'warning', 'CloseFcn', @(src, event) disp('提示框已关闭'))
    return;
end

%获取当前处理文件名称
datafileNames = train_data(:, 1);

%导入训练数据与测试数据
train_data = readcell(train_file);
test_data = readcell(test_file);

train_label = cell2mat(train_data(:, end));      %最后一列是标签
train_data = cell2mat(train_data(:,3:end-1));    %前两列是无关数据
[data_sta, ~] = mapminmax(train_data',-1,1); %对数据进行归一化
train_data = data_sta';
train_data = train_data(:,any(train_data));  %去除数据中全为0的列

test_label = cell2mat(test_data(:, end));      %最后一列是标签
test_data = cell2mat(test_data(:,3:end-1));    %前两列是无关数据
test_data(isnan(test_data)) = 0;     %将非法值默认为0
[data_sta, ~] = mapminmax(test_data',-1,1); %对数据进行归一化
test_data = data_sta';
test_data = test_data(:,any(test_data));  %去除数据中全为0的列

switch predropdown.Value
    case 'SVM(支持向量机)'
        c = 10;
        g = 0.5;
        model = fitcecoc(train_data, train_label, 'Learners', templateSVM('KernelFunction', 'rbf', 'BoxConstraint', c, 'KernelScale', 1/g));
        [predict_label, ~] = predict(model, test_data);
        accuracys = sum(predict_label == test_label) / length(test_label) * 100;
        disp("svm情感预测成功！");
    case 'KNN(K-近邻算法)'
        k_value = 3;  %设置KNN分类中的邻居数量
        model = fitcknn(train_data, train_label, 'NumNeighbors', k_value, 'Distance', 'euclidean');
        [predict_label, ~] = predict(model, test_data);
        accuracys = sum(predict_label == test_label) / length(test_label) * 100;
        disp("knn情感预测成功！");
    case 'DT(决策树算法)'
        model = fitctree(train_data, train_label,'Prune','on');
        [predict_label, ~] = predict(model, test_data);
        accuracys = sum(predict_label == test_label) / length(test_label) * 100;
        disp("dt情感预测成功！");
    otherwise
        disp('出现错误！');
        %设置提示框
        uialert(mainFig, '分类方法出错', '情感预测', 'Icon', 'error', 'CloseFcn', @(src, event) disp('频率范围出错'));
        return;
end

predict_outcomes = cell(size(test_data,1),4);
count = 0;

for i = 1:length(predict_outcomes)
    predict_outcomes{i,1} = num2str(datafileNames(i));
    predict_outcomes{i,2} = num2str(test_label(i));
    predict_outcomes{i,3} = num2str(predict_label(i));
    if predict_label(i) == test_label(i)
        predict_outcomes{i,4} = '预测正确';
        count = count+1;
    else
        predict_outcomes{i,4} = '预测错误';
    end
end

predictFig = uifigure('Name', '情感预测结果', 'Position', [140, 140, 500, 500]);
predictFig.Color = [0.15, 0.15, 0.15];

%创建表格信息显示当前所有数据的特征信息
predictTable = uitable(predictFig);
predictTable.Data = predict_outcomes;
predictTable.ColumnName = {'数据名称','情感标签','预测情感标签','是否预测成功'};
predictTable.Position = [40,60,420,380];
predictTable.ColumnWidth = {150,100,150,100};
predictTable.FontSize = 12;
predictTable.FontWeight = 'bold';
predictTable.FontAngle = 'normal';

predictLabel = uilabel(predictFig);
predictLabel.Position = [10,460,450,24];
predictLabel.Text = ['情感特征预测结果：',num2str(count),'/',num2str(size(test_data,1))];
predictLabel.FontSize = 20;
predictLabel.FontWeight = 'bold';
predictLabel.VerticalAlignment = 'center';
predictLabel.HorizontalAlignment = 'center';
predictLabel.FontColor = [1,1,1];
