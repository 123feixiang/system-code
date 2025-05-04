%进行带通滤波操作
low_frequency = lowflitArea.Value;
high_frequency = highflitArea.Value;
if low_frequency>high_frequency
    %如果当前的低通频率大于高通频率，则发生错误
    uialert(flitFig, '低通频率高于高通频率', '带通滤波', 'Icon', 'error', 'CloseFcn', @(src, event) disp('带通滤波'));
end
if flitcheckbox.Value
    %使用带通滤波新建数据
    ref_EEG = pop_eegfiltnew(EEG, 'locutoff',low_frequency,'hicutoff',high_frequency,'plotfreqz',0);
    ref_EEG.setname = flitsetnameArea.Value;
    ALLEEG_Length = length(ALLEEG) + 1;
    ALLEEG(ALLEEG_Length) = ref_EEG;
    EEG = ref_EEG;
    currentindex = length(ALLEEG) + 1;
    selectdataindex = currentindex;
    run("editDataList.m");
    %设置提示框
    uialert(mainFig, [num2str(low_frequency),'Hz','-',num2str(high_frequency),'Hz','滤波成功',',已新建数据'], '带通滤波', 'Icon', 'success', 'CloseFcn', @(src, event) disp('滤波处理成功！'));
else
    EEG = pop_eegfiltnew(EEG, 'locutoff',high_frequency,'hicutoff',high_frequency,'plotfreqz',0);
    ALLEEG(currentindex) = EEG;
    run("changeselect.m");
    %设置提示框
    uialert(mainFig, [num2str(low_frequency),'Hz','-',num2str(high_frequency),'Hz','滤波成功',',未新建数据'], '带通滤波', 'Icon', 'success', 'CloseFcn', @(src, event) disp('滤波处理成功！'));
end
close(flitFig);