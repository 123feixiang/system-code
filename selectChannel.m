%设计鼠标点击事件
%得到当前鼠标点击的通道信息
selectChanIndex = ceil(mouseY/offset);
selectChanIndex = size(EEG.data,1) - selectChanIndex + 1;
disp(['selectIndex:',num2str(selectChanIndex)]);
if selectChanIndex>=1 && selectChanIndex<=size(EEG.data,2)
    if ismember(selectChanIndex , plotchannelIndex)
        plotchannelIndex(plotchannelIndex == selectChanIndex) = [];
        run("update_EEG_Graph.m");
    else
        channel_len = length(plotchannelIndex);
        disp(['channel_len:',num2str(channel_len)]);
        plotchannelIndex(channel_len+1) = selectChanIndex;
        run("update_EEG_Graph.m");
    end
end
