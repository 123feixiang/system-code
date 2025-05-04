%保存多个set文件
%选择保存目录
folderName = uigetdir('', '选择保存目录');  %打开文件夹选择框
if folderName == 0
    uialert(mainFig, '用户取消保存！', '批量文件保存', 'Icon', 'warning');
    disp('没有选择文件夹，保存操作取消');
    return;  %如果用户取消选择，退出
end

%遍历ALLEEG中的每个EEG数据并保存
for i = 1:length(ALLEEG)
    EEG = ALLEEG(i);  %获取当前的 EEG 数据
    filename = [EEG.setname, '.set'];  %使用EEG中的setname作为文件名
    
    %构建完整的保存路径
    savePath = fullfile(folderName, filename);  %获取完整的文件路径
    
    %保存EEG数据
    pop_saveset(EEG, 'filename', savePath);  % 使用 pop_saveset 保存
end
%提示文件保存成功
uialert(mainFig, '文件成功保存！', '文件保存', 'Icon', 'info');