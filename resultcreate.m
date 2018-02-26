% Create Results for Main model
% See figure 87 for Figure 6 in thesis
% See figure 88 for Figure 7 in thesis
% See figure 129 for Figure 8 in thesis 
% See figure 333 and figure 334 for Figure 11 in thesis 
% See figure 533 for Figure 13 in thesis
% See figure 633 for Figure 14 in thesis
% See figure 150 for Figure 15 in thesis

clear; close all;clc;

for flag = 2:5
    repl = 0.2;    % set t = 0 as 0.2 in the simulation
    arkysd = 0.056;% standard deviation of arky inputs
    peak = 2.4;    % peak sensory cortical input
    run SecondOrder_LOOP_2_GP_Populations
end