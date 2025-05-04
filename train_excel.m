%选取excel文件，导入特征值信息
% 打开文件选择框，让用户选择一个 Excel 文件
[fileName, filePath] = uigetfile({'*.xlsx';'*.xls'}, '选取文件');

% 检查用户是否选择了文件
if fileName ~= 0
    % 拼接完整文件路径
    train_file = fullfile(filePath, fileName);
    disp(['文件：',train_file,'已被导入']);
    %更改显示区域的文件地址
    trainArea.Value = train_file;
else
    disp('未选取文件');
    %设置提示框信息
    uialert(mainFig, '未选择文件！', '情感预测', 'Icon', 'warning', 'CloseFcn', @(src, event) disp('提示框已关闭'));
end