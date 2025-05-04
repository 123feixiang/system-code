% 获取当前鼠标位置（坐标系中的位置）
mousePos = ax.CurrentPoint;  % 获取当前鼠标在坐标轴中的位置

%获取横坐标和纵坐标
mouseX = mousePos(1, 1);  % 获取 x 坐标
mouseY = mousePos(1, 2);  % 获取 y 坐标

if (mouseX>ax.XLim(1)) && (mouseY>0) && (mouseX<ax.XLim(2)) && (mouseY<= size(EEG.data,1)*offset)
    channelIndex = ceil(mouseY/offset);
    channelIndex = size(EEG.data,1) - channelIndex + 1;
    lineIndex = floor(mouseX*EEG.srate);
    if channelIndex>=1 && channelIndex <= size(EEG.data,1) && lineIndex>=1 && lineIndex <= size(EEG.data,2)
        channelLabel.Text = EEG.chanlocs(channelIndex).labels;
        timeLabel.Text = num2str(mouseX);
        dataLabel.Text = num2str(EEG.data(channelIndex,lineIndex));
    end
end