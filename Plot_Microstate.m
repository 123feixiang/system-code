%检查当前微状态变量是否存在，并且不为空值
if ~exist('micro_EEG', 'var') || isempty(micro_EEG)
    %设置提示框信息
    uialert(mainFig, '不存在微状态原型图', '微状态', 'Icon', 'error', 'CloseFcn', @(src, event) disp('微状态原型'));
else
    %绘制图像
    figure;
    MicroPlotTopo(micro_EEG,'plot_range',[]);
end