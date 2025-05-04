%执行更新采样率的操作
%确定新采样率
new_rate = floor(sampleArea.Value);

%使用pop_resample脚本更新采样率
EEG = pop_resample(EEG,new_rate);

%更新结构体中保存的信息
ALLEEG(currentindex) = EEG;

%更新显示内容
run("editDataList.m");

%关闭采样界面
close(sampleFig);

%设置提示框信息
uialert(mainFig, '采样率成功', '采样率', 'Icon', 'success');