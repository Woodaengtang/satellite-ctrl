addpath("lib\");
close all; clear all; clc;

% Properties for coordinate expression
wheel_frame1 = 6;
wheel_frame2 = 2;
fixed_frame1 = 8;
fixed_frame2 = 1;
width_frame = 3.5;
width_axis = 3;
coordSize = 9;

xSec = [-10, 10];
ySec = [-10, 6];
zSec = [-coordSize/10*6, coordSize/10*6];

az = 28;
el = 20;

Gimbal_vertices = [wheel_frame1, 0, wheel_frame2;...
                   wheel_frame1, 0, 0;...
                   fixed_frame1, 0, 0;...
                   fixed_frame1, 0, fixed_frame2;...
                   fixed_frame1, 0, -fixed_frame2;...
                   fixed_frame1, 0, 0;...
                   wheel_frame1, 0, 0;...
                   wheel_frame1, 0, -wheel_frame2;...
                   -wheel_frame1, 0, -wheel_frame2;...
                   -wheel_frame1, 0, 0;...
                   -fixed_frame1, 0, 0;...
                   -fixed_frame1, 0, fixed_frame2;...
                   -fixed_frame1, 0, -fixed_frame2;...
                   -fixed_frame1, 0, 0;...
                   -wheel_frame1, 0, 0;...
                   -wheel_frame1, 0, wheel_frame2;...
                   wheel_frame1, 0, wheel_frame2]';

pltCmg = figure();
% pltCmg.Theme = "light";
pltCmg.Position = [122, 438, 1112, 800];
ax = axes(pltCmg);
ax.Color = "none";
ax.XColor = "none";
ax.YColor = "none";
ax.ZColor = "none";
hold on; 
% grid on;
draw_cylinder(wheel_frame1*0.95);
quiver3(0, 0, 0, coordSize, 0, 0, "off", "filled", "LineWidth", width_axis);
quiver3(0, 0, 0, 0, 0, coordSize/2, "off", "filled", "LineWidth", width_axis);
quiver3(0, 0, 0, 0, -coordSize, 0, "off", "filled", "LineWidth", width_axis);
plot3(Gimbal_vertices(1,:), Gimbal_vertices(2,:), Gimbal_vertices(3,:), "LineWidth", width_frame);
axis equal; view([az, el]);
xlim(xSec); ylim(ySec); zlim(zSec);
% set(pltCmg, "Renderer", "painters");