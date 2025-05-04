%根据当前选取的频段进行分频操作
%使用switch选择当前需要分频的频段
switch select_frequency
    case "delta"
        %关闭分频段界面
        close(frequencyFig);
        disp('当前处理的是delta频段');
        %滤除1-3Hz的Delta频段
        ref_EEG = pop_eegfiltnew(EEG, 'locutoff',1,'hicutoff',3,'plotfreqz',0);
        ref_EEG.setname = [EEG.setname,'_Delta'];
        ALLEEG_Length = length(ALLEEG) + 1;
        ALLEEG(ALLEEG_Length) = ref_EEG;
        EEG = ref_EEG;
        currentindex = length(ALLEEG) + 1;
        selectdataindex = currentindex;
        run("editDataList.m");
        %设置提示框
        uialert(mainFig, 'Delta频段分频成功', '分频段', 'Icon', 'success', 'CloseFcn', @(src, event) disp('delta频段'));
    case "theta"
        %关闭分频段界面
        close(frequencyFig);
        disp('当前处理的是theta频段');
        %滤除4-7Hz的Theta频段
        ref_EEG = pop_eegfiltnew(EEG, 'locutoff',4,'hicutoff',7,'plotfreqz',0);
        ref_EEG.setname = [EEG.setname,'_Theta'];
        ALLEEG_Length = length(ALLEEG) + 1;
        ALLEEG(ALLEEG_Length) = ref_EEG;
        EEG = ref_EEG;
        currentindex = length(ALLEEG) + 1;
        selectdataindex = currentindex;
        run("editDataList.m");
        %设置提示框
        uialert(mainFig, 'Theta频段分频成功', '分频段', 'Icon', 'success', 'CloseFcn', @(src, event) disp('theta频段'));
    case "alpha"
        %关闭分频段界面
        close(frequencyFig);
        disp('当前处理的是alpha频段');
        %滤除4-7Hz的Alpha频段
        ref_EEG = pop_eegfiltnew(EEG, 'locutoff',8,'hicutoff',12,'plotfreqz',0);
        ref_EEG.setname = [EEG.setname,'_Alpha'];
        ALLEEG_Length = length(ALLEEG) + 1;
        ALLEEG(ALLEEG_Length) = ref_EEG;
        EEG = ref_EEG;
        currentindex = length(ALLEEG) + 1;
        selectdataindex = currentindex;
        run("editDataList.m");
        %设置提示框
        uialert(mainFig, 'Alpha频段分频成功', '分频段', 'Icon', 'success', 'CloseFcn', @(src, event) disp('alpha频段'));
    case "beta"
        %关闭分频段界面
        close(frequencyFig);
        disp('当前处理的是beta频段');
        %滤除4-7Hz的Beta频段
        ref_EEG = pop_eegfiltnew(EEG, 'locutoff',13,'hicutoff',30,'plotfreqz',0);
        ref_EEG.setname = [EEG.setname,'_Beta'];
        ALLEEG_Length = length(ALLEEG) + 1;
        ALLEEG(ALLEEG_Length) = ref_EEG;
        EEG = ref_EEG;
        currentindex = length(ALLEEG) + 1;
        selectdataindex = currentindex;
        run("editDataList.m");
        %设置提示框
        uialert(mainFig, 'Beta频段分频成功', '分频段', 'Icon', 'success', 'CloseFcn', @(src, event) disp('beta频段'));
    case "gamma"
        %关闭分频段界面
        close(frequencyFig);
        disp('当前处理的是gamma频段');
        %滤除31-45Hz的Gamma频段
        ref_EEG = pop_eegfiltnew(EEG, 'locutoff',31,'hicutoff',45,'plotfreqz',0);
        ref_EEG.setname = [EEG.setname,'_Gamma'];
        ALLEEG_Length = length(ALLEEG) + 1;
        ALLEEG(ALLEEG_Length) = ref_EEG;
        EEG = ref_EEG;
        currentindex = length(ALLEEG) + 1;
        selectdataindex = currentindex;
        run("editDataList.m");
        %设置提示框
        uialert(mainFig, 'Gamma频段分频成功', '分频段', 'Icon', 'success', 'CloseFcn', @(src, event) disp('gamma频段'));
    otherwise
        disp('当前选择频段出现错误！');
        %设置提示框
        uialert(mainFig, '频率范围出错', '分频段', 'Icon', 'error', 'CloseFcn', @(src, event) disp('频率范围出错'));
end