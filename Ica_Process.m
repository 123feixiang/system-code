if updatacheckbox.Value
    ref_EEG = EEG;
    %运行ICA
    [weights, sphere] = runica(double(ref_EEG.data), 'extended', 1);
    ref_EEG.icaweights = weights;
    ref_EEG.icasphere = sphere;
    ref_EEG.icawinv = inv(weights * sphere);  % 计算反向投影矩阵
    ica_signals = weights * sphere * ref_EEG.data; % ICA 独立成分
    ref_EEG.data = ref_EEG.icawinv * ica_signals; % 使用反向投影矩阵恢复数据
    ref_EEG.setname = [EEG.setname,'_ica'];
    ALLEEG_Length = length(ALLEEG) + 1;
    ALLEEG(ALLEEG_Length) = ref_EEG;
    EEG = ref_EEG;
    currentindex = ALLEEG_Length;
    selectdataindex = currentindex;
    run("editDataList.m");
    %提示框
    uialert(mainFig, 'ICA处理完成，已新建数据', 'ICA', 'Icon', 'success', 'CloseFcn', @(src, event) disp('ICA处理成功！'));
else
    %运行ICA
    [weights, sphere] = runica(double(EEG.data), 'extended', 1);
    EEG.icaweights = weights;
    EEG.icasphere = sphere;
    EEG.icawinv = inv(weights * sphere);  % 计算反向投影矩阵
    ica_signals = weights * sphere * EEG.data; % ICA 独立成分
    EEG.data = EEG.icawinv * ica_signals; % 使用反向投影矩阵恢复数据
    run("changeselect.m");
    uialert(mainFig, 'ICA处理完成，未新建数据', 'ICA', 'Icon', 'success', 'CloseFcn', @(src, event) disp('ICA处理成功！'));
end