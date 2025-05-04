current_time = ax.XLim(1);
timeset = floor(timesetArea.Value);
max_time = max(time);
if current_time > (max_time-2*timeset)
    current_time  = max_time;
    slider.Value = (current_time/max_time)*slider.Max;
    update_EEG_Graph;
else
    current_time = current_time+2*timeset;
    slider.Value = (current_time/max_time)*slider.Max;
    update_EEG_Graph;
end