%选取excel文件，导入特征值信息
% 打开文件选择框，让用户选择一个 Excel 文件
[fileName, filePath] = uigetfile({'*.xlsx';'*.xls'}, '选取文件');
data = [];

% 检查用户是否选择了文件
if fileName ~= 0
    % 拼接完整文件路径
    outputFile = fullfile(filePath, fileName);
    %data = readmatrix(outputFile);
    % 导入数据（假设文件名为 'data.xlsx'）
    disp(['文件：',outputFile,'已被导入']);
    %设置提示框信息
    uialert(mainFig, '特征导入成功！', '分析', 'Icon', 'info', 'CloseFcn', @(src, event) disp('提示框已关闭'));
else
    disp('未选取文件');
    %设置提示框信息
    uialert(mainFig, '未选择文件！', '特征', 'Icon', 'warning', 'CloseFcn', @(src, event) disp('提示框已关闭'));
end
