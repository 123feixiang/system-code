% 获取当前需要绘制的电极图像
channel_name = plotchannel;
channelItems = {EEG.chanlocs.labels};

%找到当前参考电极所在的位置
[~,plotchannelIndex] = ismember(plotchannel,channelItems);

%关闭重参考界面
close(plotchannelFig);

%更新数据图像
run("update_EEG_Graph.m");