% Input all fixed Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% D1 Striatum
data.params.fixed.str1(1) = 2e-3;    % Time constant Short
data.params.fixed.str1(2) = 90;      % Max FR
data.params.fixed.str1(3) = 0.01;    % Baseline FR

% D2 Striatum
data.params.fixed.str2(1) = 2e-3;    % Time constant Short
data.params.fixed.str2(2) = 90;      % Max FR
data.params.fixed.str2(3) = 0.01;    % Baseline FR

% STN
data.params.fixed.stn(1)  = 2e-3;    % Time constant short 
data.params.fixed.stn(2)  = 300;     % Max FR
data.params.fixed.stn(3)  = 50;      % Baseline

% GPe1
data.params.fixed.gpe(1) = 2e-3;     % Short Time constant    
data.params.fixed.gpe(2) = 300;      % Max FR
data.params.fixed.gpe(3) = 150;      % Baseline GPe firing rate  

% GPe2
data.params.fixed.gpe_a(1) = 2e-3;   % Short Time constant    
data.params.fixed.gpe_a(2) = 300;    % Max FR
data.params.fixed.gpe_a(3) = 150;    % Baseline GPe firing rate  

% GPi
data.params.fixed.gpi(1)  = 2e-3;    % Short Time constant   
data.params.fixed.gpi(2)  = 300;     % Max FR
data.params.fixed.gpi(3)  = 120;     % Baseline GPi firing rate

% Ctx
data.params.fixed.ctx(1)  = 2e-3;    % Short Time constant   
data.params.fixed.ctx(2)  = 22;      % Max FR
data.params.fixed.ctx(3)  = 4;       % Baseline ctx firing rate

data.params.fixed.da      = 0.3;     % Dopamine modulation
data.params.fixed.Wsm     = 0.2;     % Wsctx_mctx % original was 1


w(1)  = 20  ;    %   Wmctx_stn  
w(2)  = 3   ;    %   Wgpe_stn 
w(3)  = 40  ;    %   Wstr2_gpe 
w(4)  = 0.72;    %   Wstn_gpe 
w(5)  = 1.37;    %   Wgpe_gpe
w(6)  = 0.8 ;    %   Wgpe_gpi
w(7)  = 4   ;    %   Wstr1_gpi
w(8)  = 0.2 ;    %   Wstn_gpi 
w(9)  = 0.3 ;    %   Wstr_str
w(10) = 0.25;    %   Wgpi_mctx
w(11) = 4   ;    %   Wsctx_str 
w(12) = 5   ;    %   Wsctx_stn %original was 20
w(13) = 0.65;    %   Wmctx_str 
w(14) = 0.1 ;    %   Wgpe_str
w(15) = 0.3 ;    %   WgpeR
w(16) = 3   ;    %   Wgpe_gpea 
w(17) = 0.72;    %   Wstn_gpea 
w(18) = 2   ;    %   Wcont_gpea
w(19) = 0.4 ;    %   Wgpea_cont 
w(20) = 0.2 ;    %   Wgpea_sel 
w(21) = 0   ;    %   Wgpea_gpe
w(22) = 5   ;    %   Wsubcortical_STN
w(23) = 5   ;    %   Winputs_arky

data.params.variable = w;

% Define simulation parameters
data.sim.oscillation_threshold = 5;
data.sim.delays = [1e-3 2.5e-3 7e-3 12e-3 3e-3]; lags = data.sim.delays;
data.sim.history = 20.*rand(28,1);      history = data.sim.history;   % History vector for DDEs
data.sim.timestep = 0.1e-3;         dt = data.sim.timestep;       % Size of time step in cortical input vector
data.sim.T = 0.7;                   T = data.sim.T;               % Length of simulation
data.sim.N = T/dt;                  N = data.sim.N;               % Number of datapoints in cortical input timeseries
data.params.Tpts = linspace(0,T,N); Tpts = data.params.Tpts;      % Vector of time points in cortical input time series
data.sim.tspan = [0 T];             tspan = data.sim.tspan;
data.sim.tstim = 0.10;               tstim = data.sim.tstim;       % time of stimulation. %T/2
% data.sim.starttime = tstim-50e-3;                                 % Start plotting 50ms before stimulation.  Gives ABC algorithm chance to fit to equilibrium data as well as dynamics
data.sim.endtime   = T;                                           % Finish plotting at end of simulation.
data.sim.strOpt = 'cortical';     strOpt  = data.sim.strOpt;
   
% Define cortical input
data.sim.fixed.tauCtx = 10e-3;      tauCTX = data.sim.fixed.tauCtx;   
data.sim.fixed.FRmaxCtx = 22;       FRmaxCtx = data.sim.fixed.FRmaxCtx;
data.sim.fixed.FRbaseCtx = 4;       FRbaseCtx = data.sim.fixed.FRbaseCtx;  % 4 Cortical background input firing rate

%tstop = 0.31; %0.3
%tstopa = tstop + 0.013; %0.315
tgo = 0.1;
% FRinb = FRbaseCtx.*ones(1,length(Tpts));
% L = length(FRinb(Tpts>=tstim));
% FRin1 = FRinb+0.05;
% FRin1(Tpts>=tstim) = FRbaseCtx + 30.*exp(-Tpts(1:L)./tauCTX);  % 
% FRin2 = FRinb;
% FRin2(Tpts>=tstim) = FRbaseCtx + 18.*exp(-Tpts(1:L)./tauCTX);  % 
FRinb = FRbaseCtx.*ones(1,length(Tpts));
L = length(FRinb(Tpts>=tstim));
L2 = length(FRinb(Tpts>=tstop));
L3 = length(FRinb(Tpts>=tstopa));
L4 = length(FRinb(Tpts>=tgo));
FRsctx(1,:) = FRinb;
FRsctx(2,:) = FRinb;
stimFrq = 50;
stimLen = 0.2;
stimDur = 1e-3;
FRsubc = zeros(2,length(Tpts));
FRinarky = zeros(2,length(Tpts));
a = 100; 
b = 1000;   

if flag == 1
    %Original replication paradigm STN
    FRsctx(1,Tpts>=tstim) = FRbaseCtx + 0.25.*(a*b/(a-b)).*(exp(-Tpts(1:L).*b) - exp(-Tpts(1:L).*a));    % STN Channel 1 input
    FRsctx(2,Tpts>=tstim) = FRbaseCtx + 0.17.*(a*b/(a-b)).*(exp(-Tpts(1:L).*b) - exp(-Tpts(1:L).*a));  % STN Channel 2 input
    
elseif flag == 5
    % STN/D1/D2 Sensory Cortical input
    FRsctx(1,Tpts>=tstim) = FRbaseCtx + 13*exp(-((Tpts(1:L).*10-peak).^2./(2.*0.146^2)));
    FRsctx(2,Tpts>=tstim) = FRbaseCtx;
    
    % STN Subcortical input
    FRsubc(1,Tpts>=tgo) = 50*exp(-((Tpts(1:L4).*10-0.15).^2./(2.*0.056^2)));
    
elseif flag == 3
    % STN/D1/D2 Sensory Cortical input
    FRsctx(1,Tpts>=tstim) = FRbaseCtx + 13*exp(-((Tpts(1:L).*10-peak).^2./(2.*0.146^2)));
    FRsctx(2,Tpts>=tstim) = FRbaseCtx;
    
    % STN Subcortical input
    FRsubc(1,Tpts>=tgo) = 50*exp(-((Tpts(1:L4).*10-0.15).^2./(2.*0.056^2)));
    FRsubc(1,Tpts>=tstop) = 140*exp(-((Tpts(1:L2).*10-0.15).^2./(2.*0.056^2)));
    FRsubc(2,:) = 0;
    
    % Input to GPe-arky
    FRinarky(1,Tpts>=tstopa) = 140*exp(-((Tpts(1:L3).*10-0.15).^2./(2.*arkysd^2)));%0.15%0.056
    FRinarky(2,:) = 0;
    
elseif flag == 4
    
    peak = peak - 0.2;
    % STN/D1/D2 Sensory Cortical input
    FRsctx(1,Tpts>=tstim) = FRbaseCtx + 13*exp(-((Tpts(1:L).*10-peak).^2./(2.*0.146^2)));
    FRsctx(2,Tpts>=tstim) = FRbaseCtx;
    
    % STN Subcortical input
    FRsubc(1,Tpts>=tgo) = 50*exp(-((Tpts(1:L4).*10-0.15).^2./(2.*0.056^2)));
    FRsubc(1,Tpts>=tstop) = 140*exp(-((Tpts(1:L2).*10-0.15).^2./(2.*0.056^2)));
    FRsubc(2,:) = 0;
    
    % Input to GPe-arky
    FRinarky(1,Tpts>=tstopa) = 140*exp(-((Tpts(1:L3).*10-0.15).^2./(2.*arkysd^2)));%0.056
    FRinarky(2,:) = 0;
elseif flag == 2
    peak = peak - 0.2;
    % STN/D1/D2 Sensory Cortical input
    FRsctx(1,Tpts>=tstim) = FRbaseCtx + 13*exp(-((Tpts(1:L).*10-peak).^2./(2.*0.146^2)));
    FRsctx(2,Tpts>=tstim) = FRbaseCtx;
    
    % STN Subcortical input
    FRsubc(1,Tpts>=tgo) = 50*exp(-((Tpts(1:L4).*10-0.15).^2./(2.*0.056^2)));
elseif flag == 6
    % STN/D1/D2 Sensory Cortical input
    FRsctx(1,Tpts>=tstim) = FRbaseCtx + 13*exp(-((Tpts(1:L).*10-peak).^2./(2.*0.146^2)));
    FRsctx(2,Tpts>=tstim) = FRbaseCtx;
    
    % STN Subcortical input
    FRsubc(1,Tpts>=tgo) = 50*exp(-((Tpts(1:L4).*10-0.15).^2./(2.*0.056^2)));
    FRsubc(1,Tpts>=tstop) = 0;
    FRsubc(2,:) = 0;
    
    % Input to GPe-arky
    FRinarky(1,Tpts>=tstopa) = 140*exp(-((Tpts(1:L3).*10-0.15).^2./(2.*arkysd^2)));%0.15%0.056
    FRinarky(2,:) = 0;
elseif flag == 7
    % STN/D1/D2 Sensory Cortical input
    FRsctx(1,Tpts>=tstim) = FRbaseCtx + 13*exp(-((Tpts(1:L).*10-peak).^2./(2.*0.146^2)));
    FRsctx(2,Tpts>=tstim) = FRbaseCtx;
    
    % STN Subcortical input
    FRsubc(1,Tpts>=tgo) = 50*exp(-((Tpts(1:L4).*10-0.15).^2./(2.*0.056^2)));
    FRsubc(1,Tpts>=tstop) = 140*exp(-((Tpts(1:L2).*10-0.15).^2./(2.*0.056^2)));
    FRsubc(2,:) = 0;
    
    % Input to GPe-arky
    FRinarky(1,Tpts>=tstopa) = 0;
    FRinarky(2,:) = 0;
end

data.params.sctxInput = FRsctx;
data.params.stopInput = FRsubc;
data.params.stopaInput = FRinarky;

load realDataInterpolated
data.real.time= TI;
data.real.gpi1 = FRgpi1I;
data.real.gpi2 = FRgpi2I;
data.real.gpe = FRgpeI;
data.real.stn = FRstnI;
data.real.gpiNstn = FRgpiNstnI;