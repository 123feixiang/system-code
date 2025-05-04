%选取对应的文件夹，获取文件夹目录中所有.set文件

disp('批量数据导入');
folderPath = uigetdir();
% 检查是否选择了有效的文件夹路径
if folderPath ~= 0
    %如果用户选择了文件夹，则显示文件夹路径
    disp(['选择的文件夹路径是: ', folderPath]);
else
    %设置提示框信息
    uialert(mainFig, '未选择文件夹！', '批量数据导入', 'Icon', 'warning', 'CloseFcn', @(src, event) disp('未选择文件夹！'));
    disp('未选择文件夹。');
    return;
end

%获取文件夹中的所有.set文件与.bdf文件
% 查找.set和.bdf文件
setFiles = dir(fullfile(folderPath, '*.set'));
bdfFiles = dir(fullfile(folderPath, '*.bdf'));

%合并两个文件列表
allFiles = [setFiles; bdfFiles];
%获取完整的文件路径
filePaths = fullfile({allFiles.folder}, {allFiles.name})';

if isempty(filePaths)
    %设置提示框信息
    uialert(mainFig, '未选择文件！', '文件导入', 'Icon', 'warning', 'CloseFcn', @(src, event) disp('未选择文件！'));
    return;
end
% 遍历文件列表
for i = 1:length(filePaths)
    fileName = filePaths{i};
    [folder, name, ext] = fileparts(fileName); %获取文件扩展名
    
    %根据文件类型加载 EEG 数据
    switch lower(ext)
        case '.set'
            EEG = pop_loadset('filename', fileName);
            [ALLEEG, EEG, currentindex] = eeg_store(ALLEEG, EEG, 0);
            ALLEEG(currentindex).setname = ext;
            EEG.setname = name;
            fprintf('已加载 SET 文件: %s\n', fileName);

        case '.bdf'
            EEG = pop_biosig(fileName); % 需要EEGLAB和BioSig
            [ALLEEG, EEG, currentindex] = eeg_store(ALLEEG, EEG, 0);
            ALLEEG(currentindex).setname = ext;
            ALLEEG(currentindex).filepath = folder;
            ALLEEG(currentindex).filename = fullfile(name,ext);
            EEG.setname = name;
            fprintf('已加载 BDF 文件: %s\n', fileName);

        otherwise
            fprintf('未知文件类型: %s\n', fileName);
            uialert(mainFig, '文件格式出错！', '文件导入', 'Icon', 'warning', 'CloseFcn', @(src, event) disp('文件格式问题！'));
    end
end

for i=1:length(ALLEEG)
    filename = ALLEEG(i).filename;
    filename = erase(filename,'.set');
    filename = erase(filename,'.bdf');
    ALLEEG(i).setname = filename;
end

EEG = ALLEEG(currentindex);

toolMenu.Enable = 'on';
featureMenu.Enable = 'on';
dataMenu.Enable = 'on';

run("editDataList.m");
run("channel_GUI.m");

%提示框
uialert(mainFig, '文件导入完成', '批量文件导入', 'Icon', 'success', 'CloseFcn', @(src, event) disp('文件导入成功！'));