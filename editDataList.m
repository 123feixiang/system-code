%编辑数据集信息
%先删除所有数据集中的菜单栏，之后再新建菜单栏
delete(get(dataInfMenu, 'Children'));
%加载对应的数据信息
for i=1:length(ALLEEG)
    menu_text =  ['data',num2str(i)];
    %创建菜单项，设置回调
    ref_menu = uimenu(dataInfMenu, 'Text', menu_text, 'MenuSelectedFcn', @(src, event) evalin('base', ['selectdataindex = ', num2str(i),';changeselect']));
end

% 获取所有子菜单
children = get(dataInfMenu, 'Children');

% 获取子菜单的数量
numChildren = numel(children);

% 对调变换（交换第一个与最后一个，倒数第二个与第二个，依此类推）
for i = 1:floor(numChildren / 2)
    % 交换位置
    temp = children(i);
    children(i) = children(numChildren - i + 1);
    children(numChildren - i + 1) = temp;
end

% 更新toolsMenu的Children顺序
set(dataInfMenu, 'Children', children);

selectdataindex = length(ALLEEG);
run("changeselect.m");