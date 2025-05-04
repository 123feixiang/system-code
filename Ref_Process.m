if updatacheckbox.Value
    %进行均值参考
    ref_EEG = pop_reref(EEG,[]);
    ref_EEG.setname = [EEG.setname,'_ref'];
    ALLEEG_Length = length(ALLEEG) + 1;
    ALLEEG(ALLEEG_Length) = ref_EEG;
    EEG = ref_EEG;
    currentindex = length(ALLEEG) + 1;
    selectdataindex = currentindex;
    run("editDataList.m");
    %提示框
    uialert(mainFig, '均值参考完成，已新建数据', 'Ref', 'Icon', 'success', 'CloseFcn', @(src, event) disp('均值参考处理成功！'));
else
    EEG = pop_reref(EEG,[]);
    ALLEEG(currentindex) = EEG;
    run("changeselect.m");
    uialert(mainFig, '均值参考完成，未新建数据', 'Ref', 'Icon', 'success', 'CloseFcn', @(src, event) disp('均值参考处理成功！'));
end