%切换界面，显示正确的界面信息
if fig_select == 1
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
%     %如果存在变量，将变量变为可见
%     if exist('featureLabel','var')
%         featureLabel.Visible = 'on';
%     end
%     if exist('featureTable','var')
%         featureTable.Visible = 'on';
%     end

    %切换当前选取的界面
    fig_select = 2;
else
    %显示所有UI组件
    %显示所有 uicontrol、uilabel而不隐藏mainFig本身
    set(findall(mainFig, 'Type', 'uicontrol'), 'Visible', 'on');
    set(findall(mainFig, 'Type', 'uilabel'), 'Visible', 'on');
    %设置坐标轴可见
    ax.Visible = 'on';
    ax.Color = [1,1,1];
    %找到uiaxes内的所有绘制对象（如plot、image、scatter等）
    plots = findall(ax, 'Type', 'Line');  %获取所有绘制的曲线
    images = findall(ax, 'Type', 'Image');  %获取所有图像
    patches = findall(ax, 'Type', 'Patch');  %获取填充对象（如面积图）
    %设置绘制的图像可见
    set([plots; images; patches], 'Visible', 'on');
    %设置uieditfiled变量可见
    offsetArea.Visible = 'on';
    timesetArea.Visible = 'on';
    %强制刷新MATLAB界面
    drawnow;
    %显示updatacheckbox变量
    updatacheckbox.Visible = 'on';

    %如果存在变量，将变量变为可见
    if exist('featureLabel','var')
        delete(featureLabel);
    end
    if exist('featureTable','var')
        delete(featureTable);
    end
    if exist('updropdown','var')
        delete(updropdown);
    end
    if exist('updropdownLabel','var')
        delete(updropdownLabel);
    end
    if exist('featureAxel','var')
        delete(featureAxel);
    end
    if exist('tit','var')
        delete(tit);
    end
    if exist('lgd','var')
        delete(lgd);
    end
    if exist('tp_featureAxel','var')
        delete(tp_featureAxel);
    end
    if exist('tp_tit','var')
        delete(tp_tit);
    end
    %切换当前选取的界面
    fig_select = 1;
end