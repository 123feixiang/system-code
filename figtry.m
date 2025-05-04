% % 创建一个新的Figure
% fig = figure('Name', '自定义滑块示例', 'Position', [100, 100, 500, 250]);
% 
% % 创建一个滑块，并设置颜色
% slider = uicontrol('Style', 'slider', 'Position', [100, 100, 200, 20], ...
%                    'Min', 0, 'Max', 100, 'Value', 50, 'BackgroundColor', [0.8, 0.8, 0.8]);
% 
% % 创建一个文本框来显示滑块值
% text = uicontrol('Style', 'text', 'Position', [160, 150, 80, 30], ...
%                  'String', num2str(slider.Value));
% 
% % 设置滑块的回调函数，当滑块值变化时更新文本框
% slider.Callback = @(src, event) set(text, 'String', num2str(src.Value));
% 
% % 添加左右箭头按钮来控制滑块的值
% leftBtn = uicontrol('Style', 'pushbutton', 'Position', [50, 100, 40, 30], ...
%                     'String', '<', 'BackgroundColor', [0.7, 0.7, 0.7]);
% rightBtn = uicontrol('Style', 'pushbutton', 'Position', [350, 100, 40, 30], ...
%                      'String', '>', 'BackgroundColor', [0.7, 0.7, 0.7]);
% 
% % 左右按钮回调函数：调整滑块值
% leftBtn.Callback = @(src, event) set(slider, 'Value', max(slider.Value - 1, slider.Min));
% rightBtn.Callback = @(src, event) set(slider, 'Value', min(slider.Value + 1, slider.Max));
% 
% % 更新文本框的值
% slider.Callback = @(src, event) set(text, 'String', num2str(src.Value));


% % 创建一个 uifigure
% fig = uifigure('Name', 'Mouse Position Display', 'Position', [100, 100, 600, 400]);
% 
% % 创建一个 uiaxes
% ax = uiaxes(fig, 'Position', [50, 100, 500, 250]);
% 
% % 在 uiaxes 上绘制一个简单的图形
% plot(ax, 0:10, rand(1, 11));
% 
% % 创建两个 UILabel 显示坐标
% xLabel = uilabel(fig, 'Position', [50, 50, 200, 22], 'Text', 'X: ');
% yLabel = uilabel(fig, 'Position', [300, 50, 200, 22], 'Text', 'Y: ');
% 
% % 设置 uifigure 的鼠标移动事件
% fig.WindowButtonMotionFcn = @(src, event) updateMouseCoordinates(ax, xLabel, yLabel);
% 
% % 鼠标移动时更新坐标的回调函数
% function updateMouseCoordinates(ax, xLabel, yLabel)
%     % 获取当前鼠标位置（坐标系中的位置）
%     mousePos = ax.CurrentPoint;  % 获取当前鼠标在坐标轴中的位置
% 
%     % 获取横坐标和纵坐标
%     x = mousePos(1, 1);  % 获取 x 坐标
%     y = mousePos(1, 2);  % 获取 y 坐标
% 
%     % 更新 UILabel 显示的内容
%     xLabel.Text = sprintf('X: %.2f', x);  % 更新横坐标标签
%     yLabel.Text = sprintf('Y: %.2f', y);  % 更新纵坐标标签
% end

% % 创建一个 uifigure
% fig = uifigure('Name', 'Numeric Input Centered', 'Position', [100, 100, 300, 150]);
% 
% % 创建一个 uieditfield 输入框
% editField = uieditfield(fig, 'numeric', 'Position', [50, 70, 200, 30]);
% 
% % 设置文本居中对齐
% editField.HorizontalAlignment = 'center';  % 水平居中对齐


% % 创建UI窗口
% fig = uifigure('Name', '竖直线绘制', 'Position', [500, 500, 400, 300]);
% 
% % 创建UI轴
% ax = uiaxes(fig, 'Position', [50, 50, 300, 200]);
% 
% % 在axes中绘制一个空白图
% plot(ax, NaN, NaN);
% 
% % 设置fig的UserData，用来存储竖直线句柄
% fig.UserData = struct('vlineHandle', []);  % 初始化为一个空结构体
% 
% % 设置UI轴的回调函数
% ax.ButtonDownFcn = @(src, event) plotVerticalLine(src, event, fig);
% 
% % 回调函数：绘制竖直线
% function plotVerticalLine(ax, event, fig)
%     % 获取鼠标点击的坐标
%     point = ax.CurrentPoint;
%     x = point(1,1);  % 获取鼠标点击的横坐标
%     
%     % 获取当前轴的纵坐标范围
%     yLimits = ax.YLim;  % 获取y轴的上下限
%     
%     % 获取之前绘制的竖直线句柄
%     vlineHandle = fig.UserData.vlineHandle;
% 
%     % 如果有之前绘制的竖直线，删除它
%     if ~isempty(vlineHandle)
%         delete(vlineHandle);
%     end
%     
%     % 绘制新的竖直线
%     vlineHandle = plot(ax, [x, x], yLimits, 'r', 'LineWidth', 1);  % 竖直线为红色，线宽为1
% 
%     % 更新fig的UserData，保存新的竖直线句柄
%     fig.UserData.vlineHandle = vlineHandle;
% end


% % 创建UI窗口
% fig = uifigure('Name', '数字输入框', 'Position', [500, 500, 300, 200]);
% 
% % 创建一个数字输入框
% editField = uieditfield(fig, 'numeric', 'Position', [100, 100, 100, 30]);
% 
% % 设置输入框的回调函数，监听值变化
% editField.ValueChangedFcn = @(src, event) onValueChange(src);
% 
% % 回调函数：处理值变化
% function onValueChange(src)
%     % 获取当前输入框的值
%     value = src.Value;
%     
%     % 在命令行输出当前值
%     fprintf('当前输入的数字是: %.2f\n', value);
% end

% % 创建一个新的界面窗口
% fig = uifigure('Position', [100, 100, 300, 200]);
% 
% % 创建一个复选框 (checkbox)
% cb = uicheckbox(fig, 'Position', [100, 120, 200, 30], ...
%     'Text', '选择数据', 'ValueChangedFcn', @(src, event) updateMessage(src));
% 
% % 创建一个文本标签，用于显示选择框状态
% msgLabel = uilabel(fig, 'Position', [100, 50, 200, 30], 'Text', '数据未选择');
% 
% % 回调函数，用于根据选择框状态更新文本
% function updateMessage(src)
%     if src.Value
%         msgLabel.Text = '数据已经选择';  % 如果选中，显示“数据已经选择”
%     else
%         msgLabel.Text = '数据未选择';  % 如果未选中，显示“数据未选择”
%     end
% end
% 
% % 创建一个图形窗口
% figure;
% 
% % 读取图标图片
% icon = imread('ICAIcon.jpg');  % 图标文件名和路径
% 
% % 调整图标大小
% icon_resized = imresize(icon, [100, 50]);  % 调整图标为和按钮大小相同
% 
% % 创建一个只显示图标的按钮
% uicontrol('Style', 'pushbutton', ...
%           'String', '', ...             % 不显示文本
%           'CData', icon_resized, ...    % 设置调整后的图标
%           'Position', [100, 100, 50, 100], ... % 按钮位置和大小
%           'Callback', @buttonCallback); % 按钮点击时的回调函数
% 
% % 按钮点击回调函数
% function buttonCallback(src, event)
%     disp('按钮被点击!');
% end

% % 创建一个 uifigure 窗口
% fig = figure('Position', [100, 100, 300, 300]);  % 创建一个普通的figure窗口
% fig.Color = [0.15,0.15,0.15];
% 
% % 读取图标图片
% icon = imread('ICAIcon.jpg');  % 图标文件名和路径
% 
% % 调整图标大小
% icon_resized = imresize(icon, [100, 50]);  % 调整图标为和按钮大小相同
% 
% % 创建一个 uicontrol 按钮，使用图标
% btn = uicontrol('Style', 'pushbutton', ...     % 按钮样式
%     'Position', [100, 100, 50, 100], ...       % 按钮位置和大小
%     'CData', icon_resized, ...                % 设置图标
%     'Callback', @(src, event) buttonCallback());  % 按钮点击回调函数
% btn.BackgroundColor = [1,1,1];
% 
% % 按钮点击回调函数
% function buttonCallback()
%     disp('按钮被点击!');
% end


% % 创建一个 uifigure 窗口
% fig = uifigure('Position', [100, 100, 400, 300]);
% 
% % 创建矩形按钮（使用axes绘制矩形）
% ax = axes(fig, 'Position', [0.25, 0.5, 0.5, 0.1]);  % 创建一个 axes 作为按钮
% rectangle(ax, 'Position', [0, 0, 1, 1], 'FaceColor', [0.5, 0.5, 0.5], 'EdgeColor', 'k');  % 绘制矩形
% 
% % 设置按钮的点击事件
% set(ax, 'ButtonDownFcn', @(src, event) disp('Button clicked!'));
% 
% % 设置文字
% text(ax, 0.5, 0.5, ['Click','\n','Me'], 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 14, 'FontWeight', 'bold', 'Color', 'white');


% % 创建一个图形窗口
% fig = uifigure('Name', 'Checkbox Example');
% 
% % 创建一个复选框
% checkbox = uicheckbox(fig, 'Text', '选择框', ...
%                       'ValueChangedFcn', @checkboxCallback);
% 
% % 复选框的回调函数
% function checkboxCallback(src, ~)
%     if src.Value
%         disp('当前已被选中');
%     else
%         disp('当前未被选中');
%     end
% end







% 
% % 创建一个MATLAB GUI界面
% fig = figure('Position',[500,500,300,150],'MenuBar','none','Name','输入框示例','NumberTitle','off');
% 
% % 创建输入框
% hEdit = uicontrol('Style','edit', 'Position',[50,80,200,30], 'FontSize',12, ...
%                   'Callback', @(src,~) validateInput(src));
% 
% % 创建标签
% uicontrol('Style','text', 'Position',[50,110,200,20], 'FontSize',12, ...
%           'String','请输入100-1000之间的整数');
% 
% % 验证输入
% function validateInput(src)
%     val = str2double(get(src, 'String'));
%     if isnan(val) || val < 100 || val > 1000 || floor(val) ~= val
%         warndlg('请输入100-1000之间的整数！','输入错误');
%         set(src, 'String', '');  % 清空输入框
%     end
% end



% % 创建一个 UI 窗口
% fig = uifigure('Position', [500, 500, 300, 150], 'Name', 'Checkbox 控制 Textbox');
% 
% % 创建选择框 (uicheckbox)
% chk = uicheckbox(fig, 'Text', '启用文本框', 'Position', [30, 100, 100, 30]);
% 
% % 创建文本输入框 (uieditfield)
% edt = uieditfield(fig, 'text', 'Position', [30, 50, 200, 30], 'Enable', 'off');
% 
% % 设置回调函数，控制文本框启用状态
% chk.ValueChangedFcn = @(src, event) set(edt, 'Enable', matlab.lang.OnOffSwitchState(src.Value));
% 
% 
% 

% fig = uifigure('Name', '输入框示例', 'Position', [500, 300, 300, 150]);
% 
% % 创建输入框
% editField = uieditfield(fig, 'Text', ...
%     'Position', [50, 50, 200, 30], ...
%     'ValueChangedFcn', @(src, event) validateInput(src));
%     
% % 回调函数：校验输入
% function validateInput(src)
%     userInput = strtrim(src.Value); % 去除首尾空格
%     pattern = '^\d+\s+\d+\s+\d+$'; % 正则匹配格式：整数 空格 整数 空格 整数
% 
%     if ~isempty(regexp(userInput, pattern, 'once')) 
%         assignin('base', 'validatedNumbers', userInput); % 存入工作区变量
%         uialert(src.Parent, '输入格式正确！', '成功', 'Icon', 'success');
%     else
%         uialert(src.Parent, '请输入正确格式：三个整数，中间用空格隔开，如 "1  2  3"', '格式错误', 'Icon', 'error');
%         src.Value = ''; % 清空输入框
%     end
% end


% n = input('请输入循环次数 n: '); % 让用户输入循环次数
% h = waitbar(0, '计算进度', 'Name', '请稍候'); % 创建进度条
% 
% % 修改进度条颜色为蓝色
% c = findobj(h, 'Type', 'Patch'); 
% set(c, 'FaceColor', 'blue'); % 这里可以使用 'b' 或 RGB 值，例如 [0 0 1]
% 
% for i = 1:n
%     pause(1); % 模拟计算过程
%     % 更新进度条，并显示 i/n 进度
%     waitbar(i/n, h, sprintf('进度: %d/%d (%.2f%%)', i, n, (i/n)*100)); 
% end
% 
% close(h); % 关闭进度条











% % 生成 5×5 矩阵（示例数据）
% matrix = randi([1, 100], 5, 5); % 生成 1~100 的随机整数
% 
% % 创建图像
% figure;
% imagesc(matrix); % 颜色表示矩阵数值
% colorbar; % 添加颜色刻度条
% 
% % 自定义颜色映射（白色 → 深蓝色）
% custom_map = [linspace(1, 0, 256)', linspace(1, 0, 256)', linspace(1, 1, 256)']; 
% colormap(custom_map); % 应用颜色映射
% 
% % 添加网格线和数值标注
% hold on;
% for i = 1:5
%     for j = 1:5
%         text(j, i, num2str(matrix(i, j)), 'Color', 'k', 'FontSize', 14, ...
%             'HorizontalAlignment', 'center', 'FontWeight', 'bold');
%     end
% end
% hold off;
% 
% % 调整坐标轴
% ax = gca;
% ax.XTick = 1:5;
% ax.YTick = 1:5;
% ax.XTickLabel = {'1', '2', '3', '4', '5'};
% ax.YTickLabel = {'1', '2', '3', '4', '5'};
% ax.GridColor = 'k';
% ax.LineWidth = 1.5;


% % 创建 UI 窗口
% fig = uifigure('Name', '带滚动条的表格', 'Position', [500, 300, 600, 400]);
% %获取特征值的长度
% features_nums = length(features);
% %对特征数据进行绘图
% dataCell = cell(features_nums,6);
% for i = 1:features_nums
%     file_name = features(i).filename;
%     coverage = mat2str(features(i).coverage);
%     duration = mat2str(features(i).duration);
%     occurence = mat2str(features(i).occurence);
%     transition_probs = mat2str(features(i).transition_probability);
%     label = mat2str(features(i).label);
%     dataCell{i,1} = file_name;
%     dataCell{i,2} = coverage;
%     dataCell{i,3} = duration;
%     dataCell{i,4} = occurence;
%     dataCell{i,5} = transition_probs;
%     dataCell{i,6} = label;
% end
% 
% % 创建 `uitable`
% uit = uitable(fig, ...
%     'Data', dataCell, ...
%     'ColumnName', {'数据名称', '覆盖率', '持续时间', '发生频率', '转换概率','情感标签'}, ...
%     'Position', [50, 50, 400, 300], ... % **超出窗口，MATLAB 自动显示滚动条**
%     'ColumnWidth', {150, 100, 150, 100}); % **调整列宽**
% uit.ForegroundColor = [0,0,0.8];
% uit.FontSize = 18;
% uit.FontWeight = 'bold';
% uit.FontAngle = 'normal';

% % 生成 50 行数据（确保所有变量都是 50×1）
% numRows = 50; % 总行数
% 
% fruitNames = repmat(["苹果", "香蕉", "橙子", "葡萄", "西瓜"]', ceil(numRows/5), 1); % **确保是列向量**
% fruitNames = fruitNames(1:numRows); % 截取前 50 行
% 
% quantities = randi([1, 20], numRows, 1); % **50×1 随机库存**
% prices = round(rand(numRows, 1) * 10, 2); % **50×1 随机价格，保留 2 位小数**
% origins = repmat(["中国", "菲律宾", "巴西", "法国", "泰国"]', ceil(numRows/5), 1); % **确保是列向量**
% origins = origins(1:numRows); % 截取前 50 行
% 
% % **确保所有列都是 50×1**
% dataCell = [cellstr(fruitNames), num2cell(quantities), num2cell(prices), cellstr(origins)];
% 
% % 创建 `uitable`
% uit = uitable(fig, ...
%     'Data', dataCell, ...
%     'ColumnName', {'水果名称', '库存数量', '价格（元）', '产地'}, ...
%     'Position', [50, 50, 400, 300], ... % **超出窗口，MATLAB 自动显示滚动条**
%     'ColumnWidth', {150, 100, 100, 100}); % **调整列宽**


% % 获取结构体数组的行数
% numRows = numel(features);
% 
% % 确保 features 不是空的
% if numRows == 0
%     error('features 结构体数组为空，请检查数据加载过程！');
% end
% 
% % 提取字段信息并处理空值
% filenames = arrayfun(@(x) string(x.filename), features, 'UniformOutput', false);
% durations = arrayfun(@(x) formatNumericArray(x.duration), features, 'UniformOutput', false);
% transition_probs = arrayfun(@(x) formatMatrixSize(x.transition_probability), features, 'UniformOutput', false);
% coverages = arrayfun(@(x) formatNumericArray(x.coverage), features, 'UniformOutput', false);
% occurrences = arrayfun(@(x) formatNumericArray(x.occurrence), features, 'UniformOutput', false);
% 
% % 组合数据到 cell 数组
% dataCell = [filenames, durations, transition_probs, coverages, occurrences];
% 
% % 创建 UI 窗口
% fig = uifigure('Name', 'EEG Feature Table', 'Position', [500, 300, 900, 500]); 
% 
% % 创建 uitable 并固定大小
% uit = uitable(fig, ...
%     'Data', dataCell, ...
%     'ColumnName', {'Filename', 'Duration', 'Transition Probability', 'Coverage', 'Occurrence'}, ...
%     'Position', [50, 50, 800, 400], ...
%     'ColumnWidth', {150, 200, 150, 150, 150}); % 设置固定列宽
% 
% 创建一个 UI 窗口
% mainFig = uifigure('Position', [100, 100, 800, 600], 'Name', '下拉选择框示例');

% % 定义下拉菜单选项
% options = {'苹果', '香蕉', '橙子', '葡萄'};
% 
% % 创建下拉菜单
% dropdown = uidropdown(fig, ...
%                       'Items', options, ...
%                       'Position', [100, 120, 100, 30], ...
%                       'ValueChangedFcn', @(src, event) updateLabel(src));
% 
% % 创建标签
% lbl = uilabel(fig, ...
%               'Position', [100, 80, 120, 30], ...
%               'Text', '请选择一个水果');
% 
% % 定义回调函数
% function updateLabel(src)
%     lbl.Text = ['选择: ', src.Value]; % 更新标签显示的内容
% end
% 
% % 生成示例数据
% feature1 = rand(3,5);  % 3 个 1×5 数组（折线图数据）
% feature2 = rand(1,25); % 1×25 数组（柱状图数据）
% 
% % 计算图表位置
% fig_width = 870; % 主界面宽度
% fig_height = 20; % 主界面高度
% chart_width = 400; % 单个图表宽度
% chart_height = 200; % 单个图表高度
% 
% % 创建第一个特征值折线图
% featureAxes1 = uiaxes(fig, ...
%     'Position', [10, 20, chart_width, chart_height], ...
%     'XColor', 'k', 'YColor', 'k', 'Box', 'on');
% title(featureAxes1, '特征值折线图');
% xlabel(featureAxes1, '索引');
% ylabel(featureAxes1, '数值');
% hold(featureAxes1, 'on');
% plot(featureAxes1, feature1', 'LineWidth', 1.5); % 画折线图
% legend(featureAxes1, {'数据1', '数据2', '数据3'});
% 
% % 创建第二个特征值柱状图
% featureAxes2 = uiaxes(fig, ...
%     'Position', [420,200, 300, 200], ...
%     'XColor', 'k', 'YColor', 'k', 'Box', 'on');
% title(featureAxes2, '特征值柱状图');
% xlabel(featureAxes2, '索引');
% ylabel(featureAxes2, '数值');
% bar(featureAxes2, feature2, 'FaceColor', 'b'); % 画柱状图


% % 生成示例数据（假设数据大小为 1*m）
% m = 10; % 假设有 10 轮测试
% accuracy = rand(1, m) * 20 + 80; % 80-100 之间的随机准确率
% variance = rand(1, m) * 5; % 0-5 之间的随机方差
% 
% % 计算均值
% mean_accuracy = mean(accuracy);
% mean_variance = mean(variance);
% 
% % 在命令窗口显示均值
% fprintf('平均准确率: %.2f%%\n', mean_accuracy);
% fprintf('平均方差: %.4f\n', mean_variance);
% 
% % 创建主界面
% mainFig = uifigure('Name', '数据可视化', 'Position', [100 100 900 500]);
% mainFig.WindowState = 'normal'; % 固定窗口大小
% 
% %% **准确率折线图**
% if exist('accAxel','var')
%     delete(accAxel);
% end
% accAxel = uiaxes(mainFig);
% accAxel.Position = [30, 250, 400, 200]; % 调整位置
% accAxel.XColor = 'k';
% accAxel.YColor = 'k';
% accAxel.Box = 'on';
% title(accAxel, '测试轮次 vs. 准确率', 'FontSize', 10);
% xlabel(accAxel, '测试轮次');
% ylabel(accAxel, '准确率 (%)');
% hold(accAxel, 'on');
% plot(accAxel, 1:m, accuracy, '-o', 'LineWidth', 1.5); % 画折线图
% yline(accAxel, mean_accuracy, '--r', '平均准确率'); % 画均值线
% text(m-2, mean_accuracy+0.5, sprintf('%.2f%%', mean_accuracy), 'Color', 'r', 'FontSize', 10, 'Parent', accAxel);
% 
% % 固定坐标轴范围
% xlim(accAxel, [1, m]);
% ylim(accAxel, [min(accuracy)-5, max(accuracy)+5]);
% 
% % 禁用交互
% disableDefaultInteractivity(accAxel);
% 
% %% **方差折线图**
% if exist('varAxel','var')
%     delete(varAxel);
% end
% varAxel = uiaxes(mainFig);
% varAxel.Position = [30, 30, 400, 200]; % 调整位置
% varAxel.XColor = 'k';
% varAxel.YColor = 'k';
% varAxel.Box = 'on';
% title(varAxel, '测试轮次 vs. 方差', 'FontSize', 10);
% xlabel(varAxel, '测试轮次');
% ylabel(varAxel, '方差');
% hold(varAxel, 'on');
% plot(varAxel, 1:m, variance, '-s', 'LineWidth', 1.5, 'Color', 'g'); % 画折线图
% yline(varAxel, mean_variance, '--r', '平均方差'); % 画均值线
% text(m-2, mean_variance+0.05, sprintf('%.4f', mean_variance), 'Color', 'r', 'FontSize', 10, 'Parent', varAxel);
% 
% % 固定坐标轴范围
% xlim(varAxel, [1, m]);
% ylim(varAxel, [min(variance)-1, max(variance)+1]);
% 
% % 禁用交互
% disableDefaultInteractivity(varAxel);
% 
% %% **覆盖率、持续时间、发生频率 折线图**
% feature = zeros(3, 5);
% feature(1, :) = rand(1, 5) * 50 + 50; % 50-100 之间的随机覆盖率
% feature(2, :) = rand(1, 5) * 3000 + 2000; % 2000-5000 之间的持续时间(ms)
% feature(3, :) = rand(1, 5) * 10; % 0-10 之间的发生频率
% 
% if exist('featureAxel', 'var')
%     delete(featureAxel);
% end
% featureAxel = uiaxes(mainFig);
% featureAxel.Position = [480, 250, 400, 200];
% featureAxel.XColor = 'k';
% featureAxel.YColor = 'k';
% featureAxel.Box = 'on';
% title(featureAxel, '覆盖率, 持续时间，发生频率', 'FontSize', 10);
% xlabel(featureAxel, '微状态原型');
% ylabel(featureAxel, '数值');
% hold(featureAxel, 'on');
% plot(featureAxel, feature', 'LineWidth', 1.0);
% legend(featureAxel, {'覆盖率', '持续时间(ms)', '发生频率(/10)'}, 'FontSize', 10);
% 
% % 禁用交互
% disableDefaultInteractivity(featureAxel);
% 
% %% **转换概率 柱状图**
% tp = rand(1, 5); % 5 个转换概率值
% if exist('tp_featureAxel', 'var')
%     delete(tp_featureAxel);
% end
% tp_featureAxel = uiaxes(mainFig);
% tp_featureAxel.Position = [480, 30, 400, 200];
% tp_featureAxel.XColor = 'k';
% tp_featureAxel.YColor = 'k';
% tp_featureAxel.Box = 'on';
% title(tp_featureAxel, '转换概率', 'FontSize', 10);
% xlabel(tp_featureAxel, '微状态原型');
% ylabel(tp_featureAxel, '数值');
% hold(tp_featureAxel, 'on');
% bar(tp_featureAxel, tp, 'FaceColor', [0.06, 1.00, 1.00]); % 画柱状图
% 
% % 禁用交互
% disableDefaultInteractivity(tp_featureAxel);
clear;
filepath = 'E:\BaiduNetdiskDownload\ICA_SEED_DIVIDE\gamma_features.xlsx';
datacell = readcell(filepath);

for i=1:length(datacell)
    setname = datacell(i,1);
    setname = setname{1};
    num = str2double(regexp(setname, '(?<=_)-?\d+', 'match', 'once'));
    datacell(i,end) = {num};
end

writecell(datacell, 'E:\BaiduNetdiskDownload\ICA_SEED_DIVIDE\gamma_features1.xlsx');