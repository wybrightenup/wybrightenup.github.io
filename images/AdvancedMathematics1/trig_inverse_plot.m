% trig_inverse_plot.m
% 精确绘制 y=x, y=sin(x), y=asin(x), y=tan(x), y=atan(x)
% 并保证互为反函数的曲线关于 y=x 对称。
%
% 说明：
% 1. y=sin(x) 仅绘制在 [-pi/2, pi/2]
% 2. y=asin(x) 仅绘制在 [-1, 1]
% 3. y=tan(x) 仅绘制主值区间 (-pi/2, pi/2)
% 4. y=atan(x) 绘制较宽区间以展示其渐近线 y=±pi/2
% 5. axis equal 保证几何上关于 y=x 的对称关系不会被坐标比例扭曲
% 6. 函数名使用正体：\mathrm{sin}, \mathrm{arcsin}, \mathrm{tan}, \mathrm{arctan}

clear; clc; close all;

%% 参数
xmin = -2.4;
xmax =  2.4;
ymin = -2.4;
ymax =  2.4;

lw = 2.4;                 % 曲线线宽
axisLW = 1.2;             % 坐标轴线宽
guideLW = 0.9;            % 辅助线线宽
fs = 18;                  % 标签字号

% 颜色
c_identity = [0.45 0.00 0.75];   % 紫
c_sin      = [0.90 0.10 0.10];   % 红
c_asin     = [0.95 0.45 0.00];   % 橙
c_tan      = [0.00 0.55 0.18];   % 绿
c_atan     = [0.05 0.35 0.90];   % 蓝
c_guide    = [0.68 0.68 0.68];   % 灰

%% 数据
x_id = linspace(xmin, xmax, 1200);

% sin x: 只画 [-pi/2, pi/2]
x_sin = linspace(-pi/2, pi/2, 800);
y_sin = sin(x_sin);

% arcsin x: 定义域 [-1,1]
x_asin = linspace(-1, 1, 800);
y_asin = asin(x_asin);

% tan x: 主值区间，避开垂直渐近线
eps_tan = 0.025;
x_tan = linspace(-pi/2 + eps_tan, pi/2 - eps_tan, 1200);
y_tan = tan(x_tan);

% atan x
x_atan = linspace(xmin, xmax, 1200);
y_atan = atan(x_atan);

%% 建图
fig = figure('Color','w','Position',[120 80 1100 780]);
ax = axes(fig);
hold(ax,'on');

% 坐标范围与等比例
xlim(ax,[xmin xmax]);
ylim(ax,[ymin ymax]);
axis(ax,'equal');
box(ax,'off');

% 去掉默认刻度，后面手动画需要的标记
set(ax,'XTick',[],'YTick',[], ...
    'FontName','Times New Roman', ...
    'LineWidth',axisLW);

%% 辅助线
plot(ax, [ pi/2  pi/2], [ymin ymax], '--', 'Color', c_guide, 'LineWidth', guideLW);
plot(ax, [-pi/2 -pi/2], [ymin ymax], '--', 'Color', c_guide, 'LineWidth', guideLW);

plot(ax, [xmin xmax], [ pi/2  pi/2], '--', 'Color', c_guide, 'LineWidth', guideLW);
plot(ax, [xmin xmax], [-pi/2 -pi/2], '--', 'Color', c_guide, 'LineWidth', guideLW);

%% 坐标轴
plot(ax,[xmin xmax],[0 0],'k','LineWidth',axisLW);
plot(ax,[0 0],[ymin ymax],'k','LineWidth',axisLW);

% 箭头
ah = 0.08;
plot(ax,[xmax xmax-ah],[0 ah/2],'k','LineWidth',axisLW);
plot(ax,[xmax xmax-ah],[0 -ah/2],'k','LineWidth',axisLW);
plot(ax,[0 ah/2],[ymax ymax-ah],'k','LineWidth',axisLW);
plot(ax,[0 -ah/2],[ymax ymax-ah],'k','LineWidth',axisLW);

%% 曲线
plot(ax,x_id,x_id,'Color',c_identity,'LineWidth',lw);
plot(ax,x_sin,y_sin,'Color',c_sin,'LineWidth',lw);
plot(ax,x_asin,y_asin,'Color',c_asin,'LineWidth',lw);
plot(ax,x_tan,y_tan,'Color',c_tan,'LineWidth',lw);
plot(ax,x_atan,y_atan,'Color',c_atan,'LineWidth',lw);

%% 关键点
% sin 的端点 (±pi/2, ±1)
plot(ax,[-pi/2, pi/2],[-1,1],'o', ...
    'MarkerSize',6.5,'MarkerFaceColor',c_sin,'MarkerEdgeColor',c_sin);

% arcsin 的端点 (±1, ±pi/2)
plot(ax,[-1,1],[-pi/2, pi/2],'o', ...
    'MarkerSize',6.5,'MarkerFaceColor',c_asin,'MarkerEdgeColor',c_asin);

%% 自定义刻度短线
tickLen = 0.035;

% x 轴：±pi/2、±1
xticks_custom = [-pi/2, -1, 1, pi/2];
for xx = xticks_custom
    plot(ax,[xx xx],[-tickLen tickLen],'k','LineWidth',1.0);
end

% y 轴：±pi/2、±1
yticks_custom = [-pi/2, -1, 1, pi/2];
for yy = yticks_custom
    plot(ax,[-tickLen tickLen],[yy yy],'k','LineWidth',1.0);
end

%% 刻度文字
text(ax, -pi/2, -0.13, '$-\frac{\pi}{2}$', ...
    'Interpreter','latex','FontSize',16,'HorizontalAlignment','center','VerticalAlignment','top');
text(ax,  pi/2, -0.13, '$\frac{\pi}{2}$', ...
    'Interpreter','latex','FontSize',16,'HorizontalAlignment','center','VerticalAlignment','top');

text(ax, -1, -0.13, '$-1$', ...
    'Interpreter','latex','FontSize',15,'HorizontalAlignment','center','VerticalAlignment','top');
text(ax,  1, -0.13, '$1$', ...
    'Interpreter','latex','FontSize',15,'HorizontalAlignment','center','VerticalAlignment','top');

text(ax, -0.10,  pi/2, '$\frac{\pi}{2}$', ...
    'Interpreter','latex','FontSize',16,'HorizontalAlignment','right','VerticalAlignment','middle');
text(ax, -0.10, -pi/2, '$-\frac{\pi}{2}$', ...
    'Interpreter','latex','FontSize',16,'HorizontalAlignment','right','VerticalAlignment','middle');

text(ax, -0.10,  1, '$1$', ...
    'Interpreter','latex','FontSize',15,'HorizontalAlignment','right','VerticalAlignment','middle');
text(ax, -0.10, -1, '$-1$', ...
    'Interpreter','latex','FontSize',15,'HorizontalAlignment','right','VerticalAlignment','middle');

text(ax,0.07,-0.12,'$0$', ...
    'Interpreter','latex','FontSize',15,'HorizontalAlignment','left','VerticalAlignment','top');

%% 函数标签 —— 函数名正体
text(ax,1.72,1.92,'$y=x$', ...
    'Interpreter','latex','FontSize',fs+2,'Color',c_identity);

text(ax,1.53,0.78,'$y=\mathrm{sin}\,x$', ...
    'Interpreter','latex','FontSize',fs,'Color',c_sin);

text(ax,0.12,-0.62,'$y=\mathrm{arcsin}\,x$', ...
    'Interpreter','latex','FontSize',fs,'Color',c_asin);

text(ax,0.38,1.92,'$y=\mathrm{tan}\,x$', ...
    'Interpreter','latex','FontSize',fs,'Color',c_tan);

text(ax,1.42,0.48,'$y=\mathrm{arctan}\,x$', ...
    'Interpreter','latex','FontSize',fs,'Color',c_atan);

%% 坐标轴标签
text(ax,xmax+0.08,0,'$x$', ...
    'Interpreter','latex','FontSize',24,'HorizontalAlignment','left','VerticalAlignment','middle');

text(ax,0,ymax+0.08,'$y$', ...
    'Interpreter','latex','FontSize',24,'HorizontalAlignment','center','VerticalAlignment','bottom');

%% 最终外观
set(ax,'Position',[0.07 0.07 0.88 0.88]);
set(fig,'Renderer','painters');

% 可选：高分辨率导出
% exportgraphics(fig,'trig_inverse_plot.png','Resolution',300);
% exportgraphics(fig,'trig_inverse_plot.pdf','ContentType','vector');
