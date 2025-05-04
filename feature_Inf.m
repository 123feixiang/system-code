%如果当前存在特征值
if ~exist('features','var')
    uialert(mainFig, ' 当前无特征值 ', '特征信息', 'Icon', 'error');
    return;
end

%当前已经是特征值界面
if fig_select == 2
    return;
end

run("feature_GUI.m");