%确认需要删除的数据
%获取当前数据的索引信息
removeNumbers = cellfun(@(x) str2double(regexp(x, '\d+$', 'match', 'once')), removeData);
%对索引信息进行排序
removeNumbers = sort(removeNumbers);

%删除当前对应的数据
ALLEEG(removeNumbers) = [];

%已删除数据，关闭界面
close(removeDataFig);
uialert(mainFig, ' 数据已成功清除 ', '数据清除', 'Icon', 'success');

%如果当前数据全部被清除
if isempty(ALLEEG)
    fig_select = 2;
    run("close_process.m");
    %图像恢复
    img.Visible = 'on';
    toolMenu.Enable = 'off';
    featureMenu.Enable = 'off';
    dataMenu.Enable = 'off';
     %隐藏所有UI组件
    %隐藏所有 uicontrol、uilabel而不隐藏mainFig本身
    set(findall(mainFig, 'Type', 'uicontrol'), 'Visible', 'off');
    set(findall(mainFig, 'Type', 'uilabel'), 'Visible', 'off');
    %设置坐标轴不可见
    ax.Visible = 'off';
    ax.Color = 'none';
    %找到uiaxes内的所有绘制对象（如plot、image、scatter等）
    plots = findall(ax, 'Type', 'Line');  %获取所有绘制的曲线
    images = findall(ax, 'Type', 'Image');  %获取所有图像
    patches = findall(ax, 'Type', 'Patch');  %获取填充对象（如面积图）
    %设置绘制的图像不可见
    set([plots; images; patches], 'Visible', 'off');
    %设置uieditfiled变量不可见
    offsetArea.Visible = 'off';
    timesetArea.Visible = 'off';
    %强制刷新 MATLAB 界面
    drawnow;
    %额外隐藏updatacheckbox
    if exist('updatacheckbox', 'var') && isvalid(updatacheckbox)
        updatacheckbox.Visible = 'off';
        drawnow;
    end
    return;
end

if fig_select == 1
    run("editDataList.m");
    return;
end

if fig_select == 2
    clear features;
    run("close_process.m");
    run("editDataList.m");
end