%更换界面
run("close_process.m");

%显示当前的特征值信息
%获取特征值的长度
features_nums = length(features);
%对特征数据进行绘图
dataCell = cell(features_nums,6);
for i = 1:features_nums
    file_name = features(i).filename;
    coverage = mat2str(features(i).coverage);
    duration = mat2str(features(i).duration);
    occurence = mat2str(features(i).occurence);
    transition_probs = mat2str(features(i).transition_probability);
    label = mat2str(features(i).label);
    dataCell{i,1} = file_name;
    dataCell{i,2} = coverage;
    dataCell{i,3} = duration;
    dataCell{i,4} = occurence;
    dataCell{i,5} = transition_probs;
    dataCell{i,6} = label;
end

if exist('featureLabel','var')
    delete(featureLabel);
end

if exist('featureLabel','var')
    delete(featureLabel);
end
featureLabel = uilabel(mainFig);
featureLabel.Position = [10,420,200,24];
featureLabel.Text = '特征信息表格：';
featureLabel.FontSize = 20;
featureLabel.FontWeight = 'bold';
featureLabel.VerticalAlignment = 'center';
featureLabel.HorizontalAlignment = 'center';

if exist('featureTable','var')
    delete(featureTable);
end
%创建表格信息显示当前所有数据的特征信息
featureTable = uitable(mainFig);
featureTable.Data = dataCell;
featureTable.ColumnName = {'数据名称', '覆盖率', '持续时间', '发生频率', '转换概率','情感标签'};
featureTable.Position = [20,60,400,350];
featureTable.ColumnWidth = {150,100,150,100};
featureTable.FontSize = 12;
featureTable.FontWeight = 'bold';
featureTable.FontAngle = 'normal';

%计算选择数据的各个信息长度
select_length = cellfun(@length, selectData);
% 使用自定义排序规则
[~, idx] = sortrows(table(select_length', selectData'), [1, 2]);
%进行排序
selectData_sorted = selectData(idx);

if exist('updropdown','var')
    delete(updropdown);
end
updropdown = uidropdown(mainFig);
updropdown.Items = selectData_sorted;
updropdown.Position = [690,460,100,30];
updropdown.ValueChangedFcn = @(src,event) evalin('base','update_feature');

if exist('updropdownLabel','var')
    delete(updropdownLabel);
end
updropdownLabel = uilabel(mainFig);
updropdownLabel.Position = [530,460,160,24];
updropdownLabel.Text = '选择特征数据：';
updropdownLabel.FontSize = 16;
updropdownLabel.FontWeight = 'bold';
updropdownLabel.VerticalAlignment = 'center';
updropdownLabel.HorizontalAlignment = 'center';

%更新图像
run("update_feature.m");