%通过文本选择框，选择数据
selectedFiles = figtest();
if isempty(selectedFiles)
    %设置提示框信息
    uialert(mainFig, '未选择文件！', '文件导入', 'Icon', 'warning', 'CloseFcn', @(src, event) disp('未选择文件！'));
    return;
end
% 遍历文件列表
for i = 1:length(selectedFiles)
    fileName = selectedFiles{i};
    [folder, name, ext] = fileparts(fileName); %获取文件扩展名
    
    %根据文件类型加载 EEG 数据
    switch lower(ext)
        case '.set'
            EEG = pop_loadset('filename', fileName);
            [ALLEEG, EEG, currentindex] = eeg_store(ALLEEG, EEG, 0);
            ALLEEG(currentindex).setname = ext;
            EEG.setname = fullfile(name,ext);
            fprintf('已加载 SET 文件: %s\n', fileName);

        case '.bdf'
            EEG = pop_biosig(fileName); % 需要EEGLAB和BioSig
            [ALLEEG, EEG, currentindex] = eeg_store(ALLEEG, EEG, 0);
            ALLEEG(currentindex).setname = ext;
            ALLEEG(currentindex).filepath = folder;
            ALLEEG(currentindex).filename = fullfile(name,ext);
            EEG.setname = fullfile(name,ext);
            fprintf('已加载 BDF 文件: %s\n', fileName);

        otherwise
            fprintf('未知文件类型: %s\n', fileName);
            uialert(mainFig, '文件格式出错！', '文件导入', 'Icon', 'warning', 'CloseFcn', @(src, event) disp('文件格式问题！'));
    end
end

for i=1:length(ALLEEG)
    filename = ALLEEG(i).filename;
    filename = erase(filename,'.set');
    ALLEEG(i).setname = filename;
end

EEG = ALLEEG(currentindex);

toolMenu.Enable = 'on';
featureMenu.Enable = 'on';
dataMenu.Enable = 'on';

run("editDataList.m");
run("channel_GUI.m");

%提示框
uialert(mainFig, '文件导入完成', '文件导入', 'Icon', 'success', 'CloseFcn', @(src, event) disp('文件导入成功！'));
%%
function selectedFiles = figtest()
    % 设置文件过滤器，允许选择 .bdf 或 .set 文件
    filter = {'*.set', 'SET Files (*.set)'; ...
              '*.bdf', 'BDF Files (*.bdf)'};

    % 打开文件选择对话框
    [fileNames, pathName, filterIndex] = uigetfile(filter, ...
        '选择文件', ...
        'MultiSelect', 'on'); % 启用多选

    % 检查用户是否取消了选择
    if isequal(fileNames, 0)
        disp('用户取消了选择');
        selectedFiles = {};
        return;
    end

    % 将文件名转换为单元格数组（如果是单个文件）
    if ischar(fileNames)
        fileNames = {fileNames};
    end

    % 获取完整的文件路径
    selectedFiles = fullfile(pathName, fileNames);

    % 输出选择的文件路径
    disp('选择的文件路径：');
    for i = 1:numel(selectedFiles)
        disp(selectedFiles{i});
    end

    % 输出选择的文件类型
    if filterIndex == 1
        disp('选择的文件类型: SET');
    elseif filterIndex == 2
        disp('选择的文件类型: BDF');
    end
end