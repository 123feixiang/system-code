%将选择的数据更换为当前的数据
%更新当前数据
currentindex = selectdataindex;
EEG = ALLEEG(currentindex);

%所有数据为未选中状态
for i=1:length(dataInfMenu.Children)
    dataInfMenu.Children(i).Checked = 'off';
end
%选取的数据信息为选中状态
dataInfMenu.Children(currentindex).Checked = 'on';
plotchannelIndex = [];

run("channel_GUI.m");

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

%更换当前界面
fig_select = 1;