%获取当前的间隔值
current_timeset = timesetArea.Value;
%当前的间隔扩大1.1倍
current_timeset = current_timeset-1;

%如果扩大后的值已经超过了限制，就默认为最大值
if current_timeset<timesetArea.Limits(1)
    timesetArea.Value = timesetArea.Limits(1);
else
    timesetArea.Value = current_timeset;
end
run("update_EEG_Graph.m");