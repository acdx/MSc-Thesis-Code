% Code for reaction time plots of main model See Figure 16 in thesis.

clear;close all;clc;
selection = zeros(1,100);    % Set up vector for action selection
RTs = zeros(1,100);          % Set up vector of RT's
for ii = 1:100
    repl = 0.2;    % set t = 0 as 0.2 in the simulation
    arkysd = 0.056;% standard deviation of arky inputs
    peak = normrnd(2.4,0.2); % sample from distribution of RT's with mean at 240ms and with standard deviation of 20ms
    RTs(ii) = peak;                             % Store distribution of RTs
    flag = 3;
    run SecondOrder_LOOP_2_GP_Populations       % run model with randomised RT
    decision_thresh = 10;                       % decision threshold for GPi 
    A = sol.y(9,:) < decision_thresh;           % If first channel of GPi is below threshold, an action is considered to be selected.
    A = sum(A);
    if A >= 1 
        outputt = 1;                            % Output 1 = action selected
    elseif A < 1
        outputt = 0;                            % Output 0 = no action selected
    end
    selection(ii) = outputt;
end
   
edges = 0:0.05:5;                    % create bins

failed_stops = selection .* RTs;     % RTs that failed to stop will remain, RTs that successfully stopped will be 0
failed_stops(failed_stops==0) = [];  % remove values of 0 from vector
Y2 = discretize(failed_stops,edges); % place failed stop trials into bins
vector2 = zeros(1,101);              % Vector for number of failed stop trials in each bin
for i = 1:101
    vector2(i) = sum(Y2(:) == i);    % count the number of trials in each bin
end

failedstopplot = zeros(1,101);
for i=1:5
    for j=0:5:500
        failedstopplot(i+j) = vector2((j/5)+1);
    end
end

selection = zeros(1,100);    % Set up vector for action selection
RTs = zeros(1,100);          % Set up vector of RT's
for iii = 1:100
    repl = 0.2;    % set t = 0 as 0.2 in the simulation
    arkysd = 0.056;% standard deviation of arky inputs
    peak = normrnd(2.4,0.2); % sample from distribution of RT's with mean at 240ms and with standard deviation of 20ms
    RTs(iii) = peak;      % Store distribution of RTs
    flag = 2;                    % Set flag to Fast Go condition. 
    run SecondOrder_LOOP_2_GP_Populations       % run model with randomised RT
    decision_thresh = 10;    %decision threshold for GPi. 
    A = sol.y(9,:) < decision_thresh;           % If first channel of GPi is below threshold, an action is considered to be selected.
    A = sum(A);
    if A >= 1 
        outputt = 1;                            % Output 1 = action selected
    elseif A < 1
        outputt = 0;                            % Output 0 = no action selected
    end
    selection(iii) = outputt;
end

Y = discretize(RTs,edges);           % place RTs into bins  
vector = zeros(1,101);               % Vector for number of trials in each bin 
for i = 1:101
    vector(i) = sum(Y(:) == i);      % count the number of trials in each bin 
end
fastgoplot = zeros(1,101);           % plot
for i=1:5
    for j=0:5:500
        fastgoplot(i+j) = vector((j/5)+1);
    end
end


figure(902);clf;
plot(fastgoplot,'Color','b','LineWidth',2)
hold on
plot(failedstopplot,'Color',[0.96 0.54 0.82],'LineWidth',2)
hold on
xlabel('Reaction Time (ms)','fontsize',30)
ylabel('Trial Counts per 5ms Bin','fontsize',22)
set(gca, 'FontSize', 20)
xlim([0 500])
title('{\color{black}RT} {\color{black}Distribution} {\color[rgb]{0.96 0.54 0.82}Failed \color[rgb]{0.96 0.54 0.82}Stop} {\color{black}vs} {\color{blue}Fast \color{blue}Go}');
