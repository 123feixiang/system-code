%获取当前数据的索引信息
selectNumbers = cellfun(@(x) str2double(regexp(x, '\d+$', 'match', 'once')), selectData);
%对索引信息进行排序
selectNumbers = sort(selectNumbers);
%获取选择的EEG数据，并对数据设置一个参考变量
sel_ALLEEG = ALLEEG(selectNumbers);

%保存当前需要处理的数据信息
current_Data = sel_ALLEEG;

%当前情感标签所存储的地址
label_filepath = 'E:\EEG-DATA\seed\Preprocessed_EEG\label.mat';

%加载情感标签
emotion_labels = load(label_filepath);
emotion_labels = emotion_labels.label;

%选取数据文件进行微状态分析
[EEG, sel_ALLEEG] = pop_micro_selectdata(EEG, sel_ALLEEG, 'datatype', 'spontaneous', 'avgref', 1, 'normalise', 1, 'MinPeakDist', 10, 'Npeaks', 1000, 'GFPthresh', 1, 'dataset_idx', 1:length(current_Data));
%在新的数据结构存储数据
[sel_ALLEEG,EEG] = eeg_store(sel_ALLEEG,EEG,length(current_Data));

%微状态分割
%选择之前的GFP峰值数据集为当前的活动数据集
[sel_ALLEEG, EEG, CURRENTSET] = pop_newset(sel_ALLEEG, EEG, length(current_Data),'retrieve',length(current_Data)+1,'study',0,'setname','data');

%执行微状态分割
EEG = pop_micro_segment(EEG, 'algorithm', 'modkmeans', 'sorting', 'Global explained variance', 'Nmicrostates', 2:8, 'verbose', 1, 'normalise', 0, 'Nrepetitions', 50, 'max_iterations', 1000, 'threshold', 1e-06, 'fitmeas', 'CV', 'optimised', 1);
[sel_ALLEEG, EEG] = eeg_store(sel_ALLEEG, EEG, CURRENTSET);

%选择在一段时间内活跃的微状态的数量
EEG = pop_micro_selectNmicro(EEG,'Nmicro',5);
[sel_ALLEEG,EEG] = eeg_store(sel_ALLEEG,EEG,CURRENTSET);

%将其他数据集的微状态原型导入到需要进行回配的数据集，注：数据集5是包含微状态数据集GFP数据集  
%初始化数据集
occurence = cell(length(current_Data),1);  %发生率
duration = cell(length(current_Data),1);   %持续时间
coverage = cell(length(current_Data),1);   %覆盖率
TP_all = cell(length(current_Data),1);     %转换概率

%设置进度条
wait_site = waitbar(0, '特征计算进度', 'Name', '特征计算'); %创建进度条
%循环处理每一个set数据，计算特征值
for i = 1:length(current_Data)
    disp(['正在导入原型并进行回填操作，处理数据集:', current_Data(i).setname]);  %显示当前处理文件的信息
    [sel_ALLEEG,EEG,CURRENTSET] = pop_newset(sel_ALLEEG,EEG,CURRENTSET,'retrieve',i,'study',0);  %将对应索引的数据加载到EEG中
    EEG = pop_micro_import_proto(EEG,sel_ALLEEG,length(current_Data)+1); %将sel_ALLEEG中的第16个数据设定为微状态原型数据

    %在脑电图数据上进行微状态回填
    %EEGLAB中的一个函数，用于将微状态原型拟合到EEG数据上。这个函数主要用于通过已知的微状态原型来回填（拟合）EEG数据，通常用于分析EEG数据中的微状态模型。微状态分析是用来描述EEG信号在时间上的瞬态状态特征。
    %polarity为0表示当前的微状态回填不考虑正负极性
    EEG = pop_micro_fit(EEG,'polarity',0);
    
    %时域上平滑的微状态标签
    %pop_micro_smooth是EEGLAB中的一个用于微状态标签平滑的函数。它通过对微状态标签进行平滑处理，减少标签之间的波动，使得微状态的时间序列更为平滑和连贯，便于后续分析。这个操作在微状态分析中通常用于减少标签的噪声，并提高分析结果的可解释性
    %label_type:指定标签类型，'backfit'表示使用回填标签的方法进行平滑处理
    %smooth_type:指定平滑类型为'reject segments'，即当标签在某段时间内波动过大时，会拒绝（排除）这些不稳定的片段
    %minTime:此参数指定平滑时每个标签至少应持续30毫秒。如果某个微状态标签在30毫秒以下，就会被认为是一个噪声或短暂的标签，从而被丢弃或平滑
    %polarity:是否进行极性分析，即在平滑过程中，微状态标签的正负极性不会被考虑
    EEG = pop_micro_smooth(EEG, 'label_type', 'backfit', 'smooth_type', 'reject segments', 'minTime', 30, 'polarity', 0);

    %计算并返回微状态分析的统计信息
    EEG = pop_micro_stats(EEG, 'label_type', 'backfit', 'polarity', 0);
    [sel_ALLEEG,EEG] = eeg_store(sel_ALLEEG,EEG,CURRENTSET);
    occurence{i,1} = EEG.microstate.stats.Occurence;
    duration{i,1} = EEG.microstate.stats.Duration;
    coverage{i,1} = EEG.microstate.stats.Coverage;
    TP = EEG.microstate.stats.TP;
    TP_all{i,1} = TP; %按列进行排序
    %最后一个为微状态原型数据
    t = length(sel_ALLEEG)-1;
    %更新进度条，并显示当前进度
    waitbar(i/t, wait_site, sprintf('回填进度: %d/%d (%.2f%%)', i, t, (i/t)*100)); 
end

%关闭界面
close(selectDataFig);
close(wait_site);

%定义结构体保存特征值
features(length(ALLEEG)) = struct('filename', '', ...
                                  'coverage', [], ...
                                  'duration', [], ...
                                  'occurence', [], ...
                                  'transition_probability', [], ...
                                  'label', '');

for i = 1:length(ALLEEG)
    features(i).filename = ALLEEG(i).setname;
    features(i).coverage = [];
    features(i).duration = [];
    features(i).occurence = [];
    features(i).transition_probability = [];
    %获取情感标签的索引
    label_index = get_labels_index(ALLEEG(i).setname);
    features(i).label = emotion_labels(label_index);
end

for i = 1:length(selectNumbers)
    data_index = selectNumbers(i);
    features(data_index).filename = current_Data(i).setname;    %处理文件名称
    features(data_index).coverage = round(coverage{i,1},3);    %微状态覆盖率
    features(data_index).duration = round(duration{i,1},3);    %微状态持续时间
    features(data_index).occurence = round(occurence{i,1},3);  %微状态发生率
    features(data_index).transition_probability = round(reshape(TP_all{i,1},1,[]),3);  %微状态转换频率，将其转换成1维数据
    %获取情感标签的索引
    label_index = get_labels_index(features(data_index).filename);
    features(data_index).label = emotion_labels(label_index);
end

%更新数据信息
EEG = ALLEEG(currentindex);

%设置微状态原型数据
micro_EEG = sel_ALLEEG(length(sel_ALLEEG));
sel_ALLEEG(length(sel_ALLEEG)) = [];

%设置提示框信息
uialert(mainFig, '特征计算完成！', '特征', 'Icon', 'info', 'CloseFcn', @(src, event) disp('特征计算完成！'));

%运行特征值界面
run("feature_GUI.m");

%%
function index = get_labels_index(inputString)
    % 使用正则表达式提取 "Data" 后的数字
    % 'Data(\d+)' 匹配 "Data" 后面紧跟的一个或多个数字
    numbers = regexp(inputString, 'Data(\d+)', 'tokens');

    % 如果找到了匹配的数字，返回转换后的数值
    if ~isempty(numbers)
        index = str2double(numbers{1}{1}); % 取出匹配的数字并转换为数值
    else
        index = 1;  % 如果没有找到 "Data" 后的数字，返回 1
    end
end