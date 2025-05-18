addpath("lib\");
close all; clear all; clc;

% Properties for coordinate expression
axis_size = 1;
i_g = axis_size.*[1; 0; 0];
j_g = axis_size.*[0; 1; 0];
k_g = axis_size.*[0; 0; 1];

pltCmg = figure();
arrow3(zeros(3),[i_g'; j_g'; k_g'] ,'x',[],[],0);