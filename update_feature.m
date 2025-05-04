tokens = regexp(updropdown.Value, 'data(\d+)', 'tokens'); %提取匹配项
if ~isempty(tokens)  %确保匹配到了
    sel_feature_index = str2double(tokens{1}{1});
else
    sel_feature_index = 1; %处理未匹配情况
end
feature = zeros(3,5);
feature(1,:) = features(sel_feature_index).coverage;
feature(2,:) = features(sel_feature_index).duration./1000;
feature(3,:) = features(sel_feature_index).occurence./10;
tp = features(sel_feature_index).transition_probability;

%设置坐标轴显示特征值信息(覆盖率(%),持续时间(ms)，发生频率(/10))
if exist('featureAxel','var')
    delete(featureAxel);
end
featureAxel = uiaxes(mainFig);
featureAxel.Position = [450,225,430,220];
featureAxel.XColor = 'k';
featureAxel.YColor = 'k';
featureAxel.Box = 'on';
if exist('tit','var')
    delete(tit);
end
tit = title(featureAxel, '覆盖率,持续时间，发生频率');
tit.FontSize = 10;
xlabel(featureAxel, '微状态原型');
ylabel(featureAxel, '数值');
hold(featureAxel, 'on');
plot(featureAxel, feature', 'LineWidth', 1.0); % 画折线图
if exist('lgd','var')
    delete(lgd);
end
lgd = legend(featureAxel, {'覆盖率', '持续时间(ms)', '发生频率(/10)'});
lgd.FontSize = 10;

%设置坐标轴显示特征值信息,转换概率
if exist('tp_featureAxel','var')
    delete(tp_featureAxel);
end
tp_featureAxel = uiaxes(mainFig);
tp_featureAxel.Position = [450,0,430,220];
tp_featureAxel.XColor = 'k';
tp_featureAxel.YColor = 'k';
tp_featureAxel.Box = 'on';
if exist('tp_tit','var')
    delete(tp_tit);
end
tp_tit = title(tp_featureAxel, '转换概率');
tp_tit.FontSize = 10;
xlabel(tp_featureAxel, '微状态原型');
ylabel(tp_featureAxel, '数值');
hold(tp_featureAxel, 'on');
bar(tp_featureAxel, tp, 'FaceColor', [0.06,1.00,1.00]); %画柱状图