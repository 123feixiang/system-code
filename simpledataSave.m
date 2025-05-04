%保存单个文件
% 确保 EEG.setname 不是空的，并添加 `.set` 作为默认扩展名
defaultFileName = strcat(EEG.setname, '.set');  
%选择保存文件的路径和文件名（包括文件扩展名）
[filename, folderName] = uiputfile('*.set', '选择保存位置和文件名', defaultFileName);

%如果用户取消选择，uiputfile返回0
if filename == 0
    uialert(mainFig, '用户取消保存！', '文件保存', 'Icon', 'warning');
    disp('没有选择文件，保存操作取消');
    return;
end

%构建完整的保存路径
savePath = fullfile(folderName, filename);  % 获取用户选择的完整文件路径

%保存EEG数据
pop_saveset(EEG, 'filename', savePath);
% 显示文件保存成功的提示框
uialert(mainFig, '文件成功保存为 .set 格式！', '文件保存', 'Icon', 'info');