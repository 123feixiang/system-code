%获取当前的间隔值
current_offset = offsetArea.Value;
%当前的间隔扩大1.1倍
current_offset = current_offset*1.1;

%如果扩大后的值已经超过了限制，就默认为最大值
if current_offset>offsetArea.Limits(2)
    offsetArea.Value = offsetArea.Limits(2);
else
    offsetArea.Value = current_offset;
end
run("update_EEG_Graph.m");