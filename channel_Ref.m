%根据所选参考电极进行重参考操作
%获取当前参考点击，如果选取多个参考电极，以第一个为标准
if isempty(selectchannel)
    %如果当前未选择参考电极，通知提示信息
    uialert(channelFig, '未选择参考电极！', '提示', 'error', 'info', 'CloseFcn', @(src, event) disp('未选择参考电极'));
elseif updatacheckbox.Value
    %获取当前参考电极名称
    channel_name = selectchannel{1};
    
    %找到当前参考电极所在的位置
    channel_index = find(strcmp(channelItems, channel_name));
    
    %根据所选电极进行重参考
    ref_EEG = pop_reref(EEG,channel_index);

    %新建数据
    ALLEEG_Length = length(ALLEEG) + 1;
    ALLEEG(ALLEEG_Length) = ref_EEG;
    EEG = ref_EEG;
    currentindex = length(ALLEEG) + 1;
    selectdataindex = currentindex;

    %关闭重参考界面
    close(channelFig);

    %设置提示框进行提示
    channel_tooltext = ['参考电极',channel_name,',重参考成功'];
    uialert(mainFig, channel_tooltext, '重参考', 'Icon', 'success', 'CloseFcn', @(src, event) disp('电极参考完成'));

    %%更新显示内容
    run("editDataList.m");
else
    %获取当前参考电极名称
    channel_name = selectchannel{1};
    
    %找到当前参考电极所在的位置
    channel_index = find(strcmp(channelItems, channel_name));
    
    %根据所选电极进行重参考
    EEG = pop_reref(EEG,channel_index);

    %更新结构体内部的EEG信息
    ALLEEG(currentindex) = EEG;

    %关闭重参考界面
    close(channelFig);

    %设置提示框进行提示
    channel_tooltext = ['参考电极',channel_name,', 重参考成功'];
    uialert(mainFig, channel_tooltext, '重参考', 'Icon', 'success', 'CloseFcn', @(src, event) disp('电极参考完成'));

    %%更新显示内容
    run("editDataList.m");
end