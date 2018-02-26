%% Significance of GPe Organisation on Stop Signal Propagation 
keepvars = {'ii','RTs','peak','selection','flag','iii','failedstopplot','edges','arkysd','repl'};
clearvars('-except', keepvars{:});
tic

% 1 = Replication of original stimluation experiments in Blenkinsop et al.,
% (2017)
% 2 = Fast Go
% 3 = Correct Stop/Slow RT
% 4 = Failed Stop/Fast RT
% 5 = Slow Go
% 6 = remove STN input, correct stop
% 7 = remove arky input, correct stop

% initialise global parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tstop = 0.3;
tstopa = 0.315;

% Input all fixed parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run loadFixedParameters
data.sim.strOpt = strOpt;

% SOLVE EQUATIONS - NORMAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
recordFlag = 0;

sol = dde23(@(t,y,Z)DDEfunc(t,y,Z,data.params,w),lags,history,tspan);

sol.y =  translate(sol.y,data.params);

sol.y = sol.y(:,(sol.x>0.05 & sol.x <0.55));
sol.x = sol.x(sol.x>0.05 & sol.x <0.55);
sol.x = sol.x - tstim;

%load realDataInterpolated
FRstnI = data.real.stn;
FRgpeI = data.real.gpe;
FRgpi1I = data.real.gpi1; 
FRgpi2I = data.real.gpi2;  


lw = 3; % line Width
nsp = 4;


FRsctx = FRsctx(:,Tpts>0.05 & Tpts<0.55);
FRsubc = FRsubc(:,Tpts>0.05 & Tpts<0.55);
FRinarky = FRinarky(:,Tpts>0.05 & Tpts<0.55);
Tpts = Tpts(Tpts>0.05 & Tpts<0.55);
Tpts = Tpts - 0.5;

colour = {'b','g','r'};
axis = (1:length(FRsctx(1,:)))./10;
axis = axis-250;

%startcomment2
if flag == 3
    figure(87);clf;hold on
    % Sensory Cortical Input
    plot(axis+200,FRsctx(1,:),colour{1},'LineWidth',lw);
    hold on
    plot(axis+200,FRsctx(2,:),colour{2},'LineWidth',lw);
    hold on 
    stem(0,500,'filled','r^-','LineWidth',lw)
    xlabel('Time from Go Cue (ms)')
    ylabel('Rate (Hz)')
    title('Sensory Cortex Input')
    set(gca,'FontSize',25,'LineWidth',1)
    ylim([0 25])
    xlim([-50 450])
    
    %STN Input
    figure(88);clf;hold on
    plot(axis,FRsubc(1,:),colour{1},'LineWidth',lw);
    hold on
    plot(axis,FRsubc(2,:),colour{2},'LineWidth',lw);
    hold on
    stem(0,500,'filled','r^-','LineWidth',lw)
    xlabel('Time from Stop Cue (ms)')
    ylabel('Rate (Hz)')
    title('Subcortical Input to STN')
    set(gca,'FontSize',25,'LineWidth',1)
    ylim([0 150])
    xlim([-250 250])
    
    figure(129);clf
    %Arky's input 
    hold on
%   subplot(133)
    plot(axis,FRinarky(1,:),colour{1},'LineWidth',lw);
    hold on
    plot(axis,FRinarky(2,:),colour{2},'LineWidth',lw);
    hold on
    stem(0,500,'filled','r^-','LineWidth',lw)
    xlabel('Time from Stop Cue (s)')
    ylabel('Rate (Hz)')
    title('Input to Arkypallidal Cells')
    set(gca,'FontSize',25,'LineWidth',1)
    ylim([0 150])
    xlim([-250 250])
end
% Plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mu1 = mean(sol.y(1,1:50)); %mean(sol.y(fd,sol.x<tstim)
mu3 = mean(sol.y(3,1:50));
mu5 = mean(sol.y(5,1:50));
mu7 = mean(sol.y(7,1:50));
mu9 = mean(sol.y(9,1:50));
mu25 = mean(sol.y(25,1:50));

sol.x = sol.x-repl;
%START COMMENT
figure(112); clf; hold on

for i = 1:2
    if i==1
        fd=21;
        fg=25;
    else
        fd=23;
        fg=27;
    end
    
    % STN
    subplot(2,2,1); hold on
    plot(sol.x,sol.y(5+10*(i-1),:),colour{i},'LineWidth',lw)
        plot((TI./1000),FRstnI,'r','LineWidth',lw)
    %stem(0,1000,'filled','r^-')
    xlabel('Time from Stimulation(s)','fontsize',30)
    ylabel('STN output','fontsize',22)
    title('STN','fontsize',25)
    ylim([0 300])
    
    % GPeTI
    subplot(2,2,2); hold on
    plot(sol.x,sol.y(7+10*(i-1),:),colour{i},'LineWidth',lw)
        plot((TI./1000),FRgpeI,'r','LineWidth',lw)
    %stem(0,1000,'filled','r^-')
    xlabel('Time from Stimulation(s)','fontsize',30)
    ylabel('GPeTI output','fontsize',22)
    title('GPe-Proto','fontsize',25)
    ylim([0 300])
    
    % GPi1
    subplot(2,2,3); hold on
    plot(sol.x,sol.y(9,:),'color','b','LineWidth',lw)
    %stem(0,1000,'filled','r^-')
    plot((TI./1000),FRgpi2I,'r','LineWidth',lw)
    xlabel('Time from Stimulation(s)','fontsize',30)
    ylabel('GPi output','fontsize',22)
    title('GPi Channel 1','fontsize',25)
    ylim([0 200])
    
        % GPi1
    subplot(2,2,4); hold on
    plot(sol.x,sol.y(19,:),colour{i},'LineWidth',lw)
    %stem(0,1000,'filled','r^-')
    plot((TI./1000),FRgpi1I,'r','LineWidth',lw)
    xlabel('Time from Stimulation(s)','fontsize',30)
    ylabel('GPi output','fontsize',22)
    title('GPi Channel 2','fontsize',25)
    ylim([0 200])
    
    set(gcf,'units','normalized','outerposition',[0 0 1 1]) ;    
end
if flag ==1
    return
elseif flag == 2
    imtitle = 'GPi Fast Go';
    imtitle2 = 'STN Fast Go';
    imtitle3 = 'Striatum Fast Go';
    imfigure = 224;
    linec = 'c';
    imfigure2 = 222;
    imfigure3 = 224;
    imfigure4 = 122;
elseif flag == 3
    imtitle = 'GPi Correct Stop';
    imtitle2 = 'STN Correct Stop';
    imtitle3 = 'Striatum Correct Stop';
    imfigure = 221;
    linec = 'r';
    imfigure2 = 221;
    imfigure3 = 223;
    imfigure4 = 121;
elseif flag == 4
    imtitle = 'GPi Failed Stop';
    imtitle2 = 'STN Failed Stop';
    imtitle3 = 'Striatum Failed Stop';
    imfigure = 222;
    imfigure2 = 222;
    imfigure3 = 224;
    imfigure4 = 122;
    linec = [0.96 0.54 0.82];
elseif flag == 5
    imtitle = 'GPi Slow Go';
    imtitle2 = 'STN Slow Go';
    imtitle3 = 'Striatum Slow Go';
    imfigure = 223;
    imfigure2 = 221;
    imfigure3 = 223;
    imfigure4 = 121;
    linec = 'b';
elseif flag == 6
    imtitle = 'GPi Correct Stop';
    imtitle2 = 'STN Correct Stop';
    imtitle3 = 'Striatum Correct Stop';
    imfigure = 221;
    linec = 'r';
    imfigure2 = 221;
    imfigure3 = 223;
    imfigure4 = 121;
elseif flag == 7
    imtitle = 'GPi Correct Stop';
    imtitle2 = 'STN Correct Stop';
    imtitle3 = 'Striatum Correct Stop';
    imfigure = 221;
    linec = 'r';
    imfigure2 = 221;
    imfigure3 = 223;
    imfigure4 = 121;
end



for i = 1:2
    if i==1
        fd=21;
    else
        fd=23;
    end
    
    % GPi Output

    figure(333); hold on
    subplot(imfigure); hold on
    plot(sol.x,sol.y(9+10*(i-1),:),colour{i},'LineWidth',3)
    stem(0,1000,'filled','r^-','LineWidth',lw)
    xlabel('Time from Stop Cue(s)','fontsize',30)
    ylabel('GPi output','fontsize',22)
    set(gca, 'FontSize', 20)
    %title('Correct Stop','color','r')
    %title('Failed Stop','color',[0.96 0.54 0.82])
    title(imtitle,'color',linec)
    ylim([0 200])
    xlim([-0.25 0.25])
    x0=10;
    y0=10;
    width = 800;
    height = 450;
    set(gcf,'units','points','position',[x0,y0,width,height])
    figure(334); hold on

    % STN output
    
    subplot(imfigure); hold on
    plot(sol.x,sol.y(5+10*(i-1),:),colour{i},'LineWidth',3)
    stem(0,1000,'filled','r^-','LineWidth',lw)
    xlabel('Time from Stop Cue(s)','fontsize',30)
    ylabel('STN output','fontsize',22)
    set(gca, 'FontSize', 20)
    %title('Correct Stop','color','r')
    %title('Failed Stop','color',[0.96 0.54 0.82])
    title(imtitle2,'color',linec)    
    ylim([0 300])
    xlim([-0.25 0.25])
    x0=10;
    y0=10;
    width = 800;
    height = 450;
    set(gcf,'units','points','position',[x0,y0,width,height])

end

% STN output
figure(533); hold on
subplot(imfigure2); hold on
plot(sol.x,sol.y(5,:),'color',linec,'LineWidth',1)
stem(0,1000,'filled','k','LineWidth',1)
xlabel('Time from Stop Cue(s)','fontsize',6)
ylabel('STN output','fontsize',6)
set(gca, 'FontSize', 6)
%title('Correct Stop','color','r')
%title('Failed Stop','color',[0.96 0.54 0.82])
title(imtitle2,'color',linec, 'FontSize', 8)
ylim([0 300])
xlim([-0.25 0.25])
x0=10;
y0=10;
width = 250;
height = 339;
set(gcf,'units','points','position',[x0,y0,width,height])

% GPi Output
subplot(imfigure3); hold on
plot(sol.x,sol.y(9,:),'color',linec,'LineWidth',1)
stem(0,1000,'filled','k','LineWidth',1)
xlabel('Time from Stop Cue(s)','fontsize',6)
ylabel('GPi output','fontsize',6)
set(gca, 'FontSize', 6)
%title('Correct Stop','color','r')
%title('Failed Stop','color',[0.96 0.54 0.82])
title(imtitle,'color',linec, 'FontSize', 8)
ylim([0 200])
xlim([-0.25 0.25])
x0=10;
y0=10;
width = 250;
height = 339;
set(gcf,'units','points','position',[x0,y0,width,height])

subplot(222)
title('{\color{black}STN} {\color[rgb]{0.96 0.54 0.82}Failed \color[rgb]{0.96 0.54 0.82}Stop} {\color{black}+} {\color{cyan}Fast \color{cyan}Go}');
subplot(224)
title('{\color{black}GPi} {\color[rgb]{0.96 0.54 0.82}Failed \color[rgb]{0.96 0.54 0.82}Stop} {\color{black}+} {\color{cyan}Fast \color{cyan}Go}');
subplot(221)
title('{\color{black}STN} {\color{red}Correct \color{red}Stop} {\color{black}+} {\color{blue}Slow \color{blue}Go}');
subplot(223)
title('{\color{black}GPi} {\color{red}Correct \color{red}Stop} {\color{black}+} {\color{blue}Slow \color{blue}Go}');

figure(633); hold on
% str Output
subplot(imfigure4); hold on
plot(sol.x,sol.y(1,:)+sol.y(3,:),'color',linec,'LineWidth',1)
stem(0,1000,'filled','k','LineWidth',1)
xlabel('Time from Stop Cue(s)','fontsize',6)
ylabel('STR D1 + D2 output','fontsize',6)
set(gca, 'FontSize', 6)
%title('Correct Stop','color','r')
%title('Failed Stop','color',[0.96 0.54 0.82])
title(imtitle3,'color',linec,'fontsize',8)
ylim([0 50])
xlim([-0.25 0.25])
x0=10;
y0=10;
width = 261;%522 %800
height = 169;%338 %400
set(gcf,'units','points','position',[x0,y0,width,height])
subplot(122)
title('{\color{black}Str} {\color[rgb]{0.96 0.54 0.82}Failed \color[rgb]{0.96 0.54 0.82}Stop} {\color{black}+} {\color{cyan}Fast \color{cyan}Go}');
subplot(121)
title('{\color{black}Str} {\color{red}Correct \color{red}Stop} {\color{black}+} {\color{blue}Slow \color{blue}Go}');
    figure(709); clf; hold on
for i = 1:2
    if i==1
        fg=25;
    else
        fg=27;
    end
    % STN output
    figure(709); hold on
    subplot(221); hold on
    plot(sol.x,sol.y(5+10*(i-1),:),colour{i},'LineWidth',3)
    stem(0,1000,'filled','r','LineWidth',lw)
    xlabel('Time from Stop Cue(s)','fontsize',30)
    ylabel('STN output','fontsize',22)
    set(gca, 'FontSize', 20)
    %title('Correct Stop','color','r')
    %title('Failed Stop','color',[0.96 0.54 0.82])
    title('STN')
    ylim([0 300])
    xlim([-0.25 0.25])
    x0=10;
    y0=10;
    width = 800;
    height = 450;
    set(gcf,'units','points','position',[x0,y0,width,height])
    
    % GPi Output
    subplot(224); hold on
    plot(sol.x,sol.y(9+10*(i-1),:),colour{i},'LineWidth',3)
    stem(0,1000,'filled','r','LineWidth',lw)
    xlabel('Time from Stop Cue(s)','fontsize',30)
    ylabel('GPi output','fontsize',22)
    set(gca, 'FontSize', 20)
    %title('Correct Stop','color','r')
    %title('Failed Stop','color',[0.96 0.54 0.82])
    title('GPi')
    ylim([0 200])
    xlim([-0.25 0.25])
    x0=10;
    y0=10;
    width = 800;
    height = 450;
    set(gcf,'units','points','position',[x0,y0,width,height])
    
    % Arky Output
    subplot(223); hold on
    plot(sol.x,sol.y(fg,:),colour{i},'LineWidth',3)
    stem(0,1000,'filled','r','LineWidth',lw)
    xlabel('Time from Stop Cue(s)','fontsize',30)
    ylabel('Arky output','fontsize',22)
    set(gca, 'FontSize', 20)
    title('Arky')
    ylim([0 300])
    xlim([-0.25 0.25])
    x0=10;
    y0=10;
    width = 800;
    height = 450;
    set(gcf,'units','points','position',[x0,y0,width,height])
    
    %STR
    subplot(222); hold on
    plot(sol.x,sol.y(1+10*(i-1),:)+sol.y(3+10*(i-1),:),colour{i},'LineWidth',3)
    stem(0,1000,'filled','r','LineWidth',lw)
    xlabel('Time from Stop Cue(s)','fontsize',30)
    ylabel('STR D1 + D2 output','fontsize',22)
    set(gca, 'FontSize', 20)
    title('STR D1 + D2')
    ylim([0 50])
    xlim([-0.25 0.25])
    x0=10;
    y0=10;
    width = 800;
    height = 450;
    set(gcf,'units','points','position',[x0,y0,width,height])
end





sol.y = sol.y(:,(sol.x> -0.05 & sol.x <0.15));
sol.x = sol.x(sol.x>-0.05 & sol.x <0.15);
if flag == 3
    figure(150); clf; hold on
    plot(sol.x,((sol.y(5,:))-mu5),'Color',[1 0.78 0.35],'LineWidth',2) % STN ORANGE
    hold on
    plot(sol.x,((sol.y(7,:))-mu7),'b','LineWidth',2)                   % PROTO BLUE
    hold on
    plot(sol.x,((sol.y(9,:))-mu9),'Color',[1 0.40 0],'LineWidth',2)    % CORTEX RED
    hold on
    plot(sol.x,((sol.y(25,:))-mu25),'c','LineWidth',2)                  % ARKY CYAN
    hold on
    stem(0,1000,'filled','r^-','LineWidth',0.5)
    stem(0,-100,'filled','r^-','LineWidth',0.5)
    hold on
    set(gca, 'FontSize', 8)
    xlabel('Time from Stop Cue (s)','fontsize',8)
    ylabel('Change in Firing Rate','fontsize',8)
    title('Firing Rate Change in Correct Stop','fontsize',9)
    ylim([-50 300])
    width = 168;%400;
    height = 189;%500;
    set(gcf,'units','points','position',[x0,y0,width,height])
    xlim([-0.05 0.15])
end

% END COMMENT

toc