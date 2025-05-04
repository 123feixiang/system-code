%重置图像
channelLabel.Text = ' ';
timeLabel.Text = ' ';
dataLabel.Text = ' ';

data = EEG.data;
mean_range = mean(data,2);
max_range = max(mean_range);
min_range = min(mean_range);
offset = double((max_range-min_range)*30);

offsetArea.Value = offset;
timesetArea.Value = 5;

slider.Value = 0;
run("update_EEG_Graph.m");