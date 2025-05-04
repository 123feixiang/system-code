%%
%创建主界面，说明主界面的名称，位置，与大小%%
fig = uifigure('Name', '数据信息', 'Position', [383,171,346,444]);
fig.Color = [0.15,0.15,0.15];  %设置主界面的背景颜色
fig.Pointer = "ibeam";         %设计主界面的鼠标点击样式

%%
leftlength = 20;  %设置左端距离
datalabel = uilabel(fig);  %设置文本
if isempty(ALLEEG)
    datalabel.Text = '#Data 0 未导入数据';
else
    datalabel.Text = ['#Data ',num2str(currentindex),' :',EEG.setname];
end
datalabel.Position = [leftlength,fig.Position(4)-40,fig.Position(3)-2*leftlength,30];  %设置文本位置
datalabel.FontName = 'Arial';  %设置字体样式
datalabel.FontSize = 20;  %设置字体大小
datalabel.FontColor = [1.00,1.00,1.00];  %设置字体颜色
datalabel.FontWeight = 'bold';   %设置字体为粗体
datalabel.BackgroundColor = [0.15,0.15,0.15];  %设置背景颜色

%%
setnamelabel = uilabel(fig);  %设置文本
setnamelabel.Text = ['数据名称： ',EEG.setname];
setnamelabel.Position = [1.5*leftlength,fig.Position(4)-(fig.Position(4)/5),300,fig.Position(4)/20];  %设置文本位置
setnamelabel.FontName = 'Arial';  %设置字体样式
setnamelabel.FontSize = fig.Position(4)/20*0.8;  %设置字体大小
setnamelabel.FontColor = [1.00,1.00,1.00];  %设置字体颜色
setnamelabel.BackgroundColor = [0.15,0.15,0.15];  %设置背景颜色

%%
filenamelabel = uilabel(fig);  %设置文本
filenamelabel.Text = ['文件名称： ',EEG.filename];
filenamelabel.Position = [1.5*leftlength,fig.Position(4)-(fig.Position(4)*3/10),300,fig.Position(4)/20];  %设置文本位置
filenamelabel.FontName = 'Arial';  %设置字体样式
filenamelabel.FontSize = fig.Position(4)/20*0.8;  %设置字体大小
filenamelabel.FontColor = [1.00,1.00,1.00];  %设置字体颜色
filenamelabel.BackgroundColor = [0.15,0.15,0.15];  %设置背景颜色

%%
samplelabel = uilabel(fig);  %设置文本
samplelabel.Text = ['采样率： ',num2str(EEG.srate),'Hz'];
samplelabel.Position = [1.5*leftlength,fig.Position(4)-(fig.Position(4)*4/10),300,fig.Position(4)/20];  %设置文本位置
samplelabel.FontName = 'Arial';  %设置字体样式
samplelabel.FontSize = fig.Position(4)/20*0.8;  %设置字体大小
samplelabel.FontColor = [1.00,1.00,1.00];  %设置字体颜色
samplelabel.BackgroundColor = [0.15,0.15,0.15];  %设置背景颜色

%%
chanlabel = uilabel(fig);  %设置文本
chanlabel.Text = ['通道数量： ',num2str(size(EEG.data,1))];
chanlabel.Position = [1.5*leftlength,fig.Position(4)-(fig.Position(4)*5/10),300,fig.Position(4)/20];  %设置文本位置
chanlabel.FontName = 'Arial';  %设置字体样式
chanlabel.FontSize = fig.Position(4)/20*0.8;  %设置字体大小
chanlabel.FontColor = [1.00,1.00,1.00];  %设置字体颜色
chanlabel.BackgroundColor = [0.15,0.15,0.15];  %设置背景颜色

%%
datatimelabel = uilabel(fig);  %设置文本
datatimelabel.Text = ['数据时长： ',num2str(size(EEG.data,2)/EEG.srate),'s'];
datatimelabel.Position = [1.5*leftlength,fig.Position(4)-(fig.Position(4)*6/10),300,fig.Position(4)/20];  %设置文本位置
datatimelabel.FontName = 'Arial';  %设置字体样式
datatimelabel.FontSize = fig.Position(4)/20*0.8;  %设置字体大小
datatimelabel.FontColor = [1.00,1.00,1.00];  %设置字体颜色
datatimelabel.BackgroundColor = [0.15,0.15,0.15];  %设置背景颜色

%%
reflabel = uilabel(fig);  %设置文本
if isempty(EEG.ref)
    reflabel.Text = '重参考方式： 未进行重参考';
else
    if strcmp(EEG.ref,'average')
        reflabel.Text = '重参考方式： 均值参考';
    else
        reflabel.Text = ['重参考方式： ',EEG.ref,'电极参考'];
    end
end
reflabel.Position = [1.5*leftlength,fig.Position(4)-(fig.Position(4)*7/10),300,fig.Position(4)/20];  %设置文本位置
reflabel.FontName = 'Arial';  %设置字体样式
reflabel.FontSize = fig.Position(4)/20*0.8;  %设置字体大小
reflabel.FontColor = [1.00,1.00,1.00];  %设置字体颜色
reflabel.BackgroundColor = [0.15,0.15,0.15];  %设置背景颜色

%%
icalabel = uilabel(fig);  %设置文本
if isempty(EEG.icawinv)
    icalabel.Text = 'ICA处理： 未进行ICA处理';
else
    icalabel.Text = 'ICA处理： 已经进行ICA处理';
end
icalabel.Position = [1.5*leftlength,fig.Position(4)-(fig.Position(4)*8/10),300,fig.Position(4)/20];  %设置文本位置
icalabel.FontName = 'Arial';  %设置字体样式
icalabel.FontSize = fig.Position(4)/20*0.8;  %设置字体大小
icalabel.FontColor = [1.00,1.00,1.00];  %设置字体颜色
icalabel.BackgroundColor = [0.15,0.15,0.15];  %设置背景颜色

%%
datasizelabel = uilabel(fig);  %设置文本
EEGdata = EEG.data;
info = whos('EEGdata');          %使用whos获取数据信息 
dataSizeInBytes = info.bytes;     %获取数据占用的字节大小
dataset_size = dataSizeInBytes/(1024*1024);  %将字节转换成MB
datasizelabel.Text = ['数据大小： ',num2str(dataset_size),' (Mb)'];
datasizelabel.Position = [1.5*leftlength,fig.Position(4)-(fig.Position(4)*9/10),300,fig.Position(4)/20];  %设置文本位置
datasizelabel.FontName = 'Arial';  %设置字体样式
datasizelabel.FontSize = fig.Position(4)/20*0.8;  %设置字体大小
datasizelabel.FontColor = [1.00,1.00,1.00];  %设置字体颜色
datasizelabel.BackgroundColor = [0.15,0.15,0.15];  %设置背景颜色