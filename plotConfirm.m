%绘制EEG的频域图像

low_Scalp = LowScalpArea.Value;
high_Scalp = HighScalpArea.Value;
%获取当前需要确认的频率
saclp_Numbers = str2double(regexp(validatedNumbers, '\d+', 'match'));
figure;
pop_spectopo(EEG, 1, [0  EEG.xmax*1000], 'EEG' , 'freq', saclp_Numbers, 'freqrange',[low_Scalp high_Scalp],'electrodes','off');
