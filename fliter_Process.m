%设置滤波图像
flitFig = uifigure('Name', '设置滤波频率', 'Position', [500, 300, 300, 200]);
flitFig.Color = [0.15,0.15,0.15];

lowflitlabel = uilabel(flitFig, 'Position', [45, 160, 100, 20], 'Text', ' 低通频率： ');
lowflitlabel.FontColor = [1,1,1];
lowflitlabel.FontSize = 14;                     %设置字体大小
lowflitlabel.FontAngle = 'normal';              %设置字体是否倾斜
lowflitlabel.FontWeight = 'bold';  
lowflitlabel.HorizontalAlignment = 'center';      %设置字体水平居中
lowflitlabel.VerticalAlignment = 'center';        %设置字体竖直居中

lowflitArea = uieditfield(flitFig, 'numeric');
lowflitArea.Position = [145,160,100,20];
lowflitArea.HorizontalAlignment = 'center';
lowflitArea.Value = 0.1;
lowflitArea.Limits = [0.01,EEG.srate/2];

highflitlabel = uilabel(flitFig, 'Position', [45, 120, 100, 20], 'Text', ' 高通频率： ');
highflitlabel.FontColor = [1,1,1];
highflitlabel.FontSize = 14;                     %设置字体大小
highflitlabel.FontAngle = 'normal';              %设置字体是否倾斜
highflitlabel.FontWeight = 'bold';  
highflitlabel.HorizontalAlignment = 'center';      %设置字体水平居中
highflitlabel.VerticalAlignment = 'center';        %设置字体竖直居中

highflitArea = uieditfield(flitFig, 'numeric');
highflitArea.Position = [145,120,100,20];
highflitArea.HorizontalAlignment = 'center';
highflitArea.Value = EEG.srate/2;
highflitArea.Limits = [0.01,EEG.srate/2];

flitsetnamelabel = uilabel(flitFig, 'Position', [45, 60, 100, 20], 'Text', ' 数据名称： ');
flitsetnamelabel.FontColor = [1,1,1];
flitsetnamelabel.FontSize = 14;                     %设置字体大小
flitsetnamelabel.FontAngle = 'normal';              %设置字体是否倾斜
flitsetnamelabel.FontWeight = 'bold';  
flitsetnamelabel.HorizontalAlignment = 'center';      %设置字体水平居中
flitsetnamelabel.VerticalAlignment = 'center';        %设置字体竖直居中

flitsetnameArea = uieditfield(flitFig);
flitsetnameArea.Position = [145,60,100,20];
flitsetnameArea.HorizontalAlignment = 'center';
flitsetnameArea.Value = EEG.setname;
flitsetnameArea.Enable = 'off';

flitcheckbox = uicheckbox(flitFig);
flitcheckbox.Position = [60,90,120,20];
flitcheckbox.FontColor = [1,1,1];
flitcheckbox.FontWeight = 'bold';
flitcheckbox.Text = ' 新建数据 ';
flitcheckbox.FontSize = 14;
flitcheckbox.ValueChangedFcn = @(src, event) set(flitsetnameArea, 'Enable', matlab.lang.OnOffSwitchState(src.Value));

%采样确认案件，确认后，更新EEG的采样率
flitconfirmButton = uibutton(flitFig, 'push', 'Text', '确认', 'Position', [110, 20, 80, 30],'ButtonPushedFcn', @(btn, event) evalin('base', 'flitConfirm'));
%设置按钮的水平和垂直对齐方式
flitconfirmButton.HorizontalAlignment = 'center';
flitconfirmButton.VerticalAlignment = 'center';
flitconfirmButton.Tooltip = '确认';
flitconfirmButton.BackgroundColor = [1,1,1];