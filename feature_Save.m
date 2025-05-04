%通过excel表格的形式保存特征值
%如果当前不存在特征值
if ~exist('features','var')
    uialert(mainFig, ' 当前无特征值 ', '特征信息', 'Icon', 'error');
    return;
end

%获取当前选择的特征值数据
save_features = features(selectNumbers);

excel_data = cell(length(save_features),43);

% 让用户选择文件保存位置和文件名，初始文件名为 'feature.xlsx'
[fileName, filePath] = uiputfile('*.xlsx', 'Save As', 'feature.xlsx');

for i =1:length(save_features)
    excel_data(i,1) = {save_features(i).filename};
    excel_data(i,2) = {ALLEEG(selectNumbers(i)).filepath};
    excel_data(i,3:7) = num2cell(save_features(i).coverage);
    excel_data(i,8:12) = num2cell(save_features(i).duration);
    excel_data(i,13:17) = num2cell(save_features(i).occurence);
    excel_data(i,18:42) = num2cell(save_features(i).transition_probability);
    excel_data(i,43) = num2cell(save_features(i).label);
end

%检查用户是否选择了文件
if fileName ~= 0
    % 拼接完整的文件路径
    fullFileName = fullfile(filePath, fileName);
    %使用 xlswrite 直接保存 cell 数组到 Excel
    xlswrite(fullFileName,excel_data);  % 直接保存 cell 数组到 Excel
    disp(['Data has been saved to: ' fullFileName]);
    %设置提示框信息
    uialert(mainFig, '特征保存成功！', '特征', 'Icon', 'info', 'CloseFcn', @(src, event) disp('提示框已关闭'));
else
    %设置提示框信息
    uialert(mainFig, '未选择文件！', '特征', 'Icon', 'warning', 'CloseFcn', @(src, event) disp('提示框已关闭'));
end