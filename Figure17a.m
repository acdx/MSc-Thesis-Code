%Removal of STN input, see figure 709

clear; close all;clc;

flag = 6;
repl = 0.2;    % set t = 0 as 0.2 in the simulation
arkysd = 0.15;% standard deviation of arky inputs
peak = 2.4;    % peak sensory cortical input
run SecondOrder_LOOP_2_GP_Populations