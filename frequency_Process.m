%设置频率界面
frequencyFig = uifigure('Name', '选择分频波段', 'Position', [500, 300, 300, 420]);
frequencyFig.Color = [0.15,0.15,0.15];
%确定选择的频率
select_frequency = '';

%设置delta频段按钮格式
delta_button = uibutton(frequencyFig,'Text','Delta频段(1-3Hz)','Position',[50,340,200,60]);
delta_button.HorizontalAlignment = 'center';
delta_button.VerticalAlignment = 'center';
delta_button.Tooltip = 'delta频段';
delta_button.FontSize = 14;
delta_button.BackgroundColor = [0.94,0.94,0.94];
delta_button.ButtonPushedFcn = @(btn, event) evalin('base', ['select_frequency = "', 'delta', '"; frequencyConfirm']);

%设置theta频段按钮格式
theta_button = uibutton(frequencyFig,'Text','Theta频段(4-7Hz)','Position',[50,260,200,60]);
theta_button.HorizontalAlignment = 'center';
theta_button.VerticalAlignment = 'center';
theta_button.Tooltip = 'theta频段';
theta_button.FontSize = 14;
theta_button.BackgroundColor = [0.94,0.94,0.94];
theta_button.ButtonPushedFcn = @(btn, event) evalin('base', ['select_frequency = "', 'theta', '"; frequencyConfirm']);

%设置alpha频段按钮格式
alpha_button = uibutton(frequencyFig,'Text','Alpha频段(8-12Hz)','Position',[50,180,200,60]);
alpha_button.HorizontalAlignment = 'center';
alpha_button.VerticalAlignment = 'center';
alpha_button.Tooltip = 'Alpha频段';
alpha_button.FontSize = 14;
alpha_button.BackgroundColor = [0.94,0.94,0.94];
alpha_button.ButtonPushedFcn = @(btn, event) evalin('base', ['select_frequency = "', 'alpha', '"; frequencyConfirm']);

%设置beta频段按钮格式
beta_button = uibutton(frequencyFig,'Text','Beta频段(13-30Hz)','Position',[50,100,200,60]);
beta_button.HorizontalAlignment = 'center';
beta_button.VerticalAlignment = 'center';
beta_button.Tooltip = 'Beta频段';
beta_button.FontSize = 14;
beta_button.BackgroundColor = [0.94,0.94,0.94];
beta_button.ButtonPushedFcn = @(btn, event) evalin('base', ['select_frequency = "', 'beta', '"; frequencyConfirm']);

%设置gamma频段按钮格式
gamma_button = uibutton(frequencyFig,'Text','Gamma频段(31-45Hz)','Position',[50,20,200,60]);
gamma_button.HorizontalAlignment = 'center';
gamma_button.VerticalAlignment = 'center';
gamma_button.Tooltip = 'Gamma频段';
gamma_button.FontSize = 14;
gamma_button.BackgroundColor = [0.94,0.94,0.94];
gamma_button.ButtonPushedFcn = @(btn, event) evalin('base', ['select_frequency = "', 'gamma', '"; frequencyConfirm']);