%更新去除无用点击后的图像
%去除无用电极
EEG = pop_select(EEG, 'nochannel', selectdeleteChannel);
%更新结构体内部的EEG数据
ALLEEG(currentindex) = EEG;

%更新显示内容
run("editDataList.m");

%关闭界面
close(deleteChannelFig);

%设置提示文本
channelStr = strjoin(selectdeleteChannel, ',');
channelAlert = [channelStr,'已被去除'];

%添加提示框
uialert(mainFig, channelAlert, '提示', 'Icon', 'info', 'CloseFcn', @(src, event) disp('电极剔除完毕'));