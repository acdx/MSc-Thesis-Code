function yp = DDEfunc(t,y,Z,p,w)

% unwrap input
%%%%%%%%%%%%%%%%%%%%%%%%%
persistent Tpts FRsctx FRsctx1 FRsctx2 FRsubc FRsubc1 FRsubc2 FRinarky FRinarky1 FRinarky2 % define fixed parameters as persistent so that they do not need to redefined on every function call
Tpts  = p.Tpts;

FRsctx = p.sctxInput;
FRsctx1 = interp1(Tpts,FRsctx(1,:),t);
FRsctx2 = interp1(Tpts,FRsctx(2,:),t);

FRsubc = p.stopInput;
FRsubc1 = interp1(Tpts,FRsubc(1,:),t);
FRsubc2 = interp1(Tpts,FRsubc(2,:),t);

FRinarky = p.stopaInput;
FRinarky1 = interp1(Tpts,FRinarky(1,:),t);
FRinarky2 = interp1(Tpts,FRinarky(2,:),t);

% Str1
persistent Tstr1 Mstr1 Bstr1 
Tstr1  = p.fixed.str1(1);     % Short time constant
Mstr1  = p.fixed.str1(2);     % Maximum firing rate
Bstr1  = p.fixed.str1(3);     % Firing rate in absence of inputs

% Str2
persistent Tstr2 Mstr2 Bstr2 
Tstr2  = p.fixed.str2(1);
Mstr2  = p.fixed.str2(2);
Bstr2  = p.fixed.str2(3);

% STN
persistent Tstn Mstn Bstn 
Tstn   = p.fixed.stn(1);    
Mstn   = p.fixed.stn(2);
Bstn   = p.fixed.stn(3);

% GPe
persistent Tgpe Mgpe Bgpe
Tgpe  = p.fixed.gpe(1);         
Mgpe  = p.fixed.gpe(2);
Bgpe  = p.fixed.gpe(3);

% GPi
persistent Tgpi Mgpi Bgpi 
Tgpi  = p.fixed.gpi(1);         
Mgpi  = p.fixed.gpi(2);
Bgpi  = p.fixed.gpi(3);

% Ctx
persistent Tctx Mctx Bctx 
Tctx  = p.fixed.ctx(1);         
Mctx  = p.fixed.ctx(2);
Bctx  = p.fixed.ctx(3);

% Other
persistent Da  
Da       = p.fixed.da;

% Variable connection strength parameters
%%%%%%%%%%%%%%%%%%%%%%%%%
Wmctx_stn  = w(1);
Wgpe_stn   = w(2);
Wstr2_gpe  = w(3);
Wstn_gpe   = w(4);
Wgpe_gpe   = w(5);
Wgpe_gpi   = w(6);
Wstr1_gpi  = w(7);
Wstn_gpi   = w(8);
Wstr_str   = w(9);
Wgpi_mctx  = w(10);
Wsctx_str  = w(11);
Wsctx_stn  = w(12);
Wmctx_str  = w(13);
Wsctx_mctx = p.fixed.Wsm;
Wgpe_str   = w(14);
WgpeR      = w(15);
Wgpe_gpea  = w(16); 
Wstn_gpea  = w(17);
Wcont_gpea = w(18);
Wgpea_cont = w(19);
Wgpea_sel = w(20);
Wgpea_gpe = w(21);
Wsubcortical_STN = w(22);
Winputs_arky = w(23);

% inputs to DDEs
%%%%%%%%%%%%%%%%%%%%%%%%%

% Channel 1
str11 = -Wstr_str.*sigSTR1(Z(11,3)) + Wsctx_str.*(1+Da).*FRsctx1 + Wmctx_str.*(1+Da).*sigCTX(Z(21,5)) - Wgpe_str.*sigGPE(Z(17,3)) - Wgpea_sel.*sigGPEA(Z(25,3));
str21 = -Wstr_str.*sigSTR2(Z(13,3)) + Wsctx_str.*(1-Da).*FRsctx1 + Wmctx_str.*(1-Da).*sigCTX(Z(21,5)) - Wgpe_str.*sigGPE(Z(17,3)) - Wgpea_cont.*sigGPEA(Z(25,3));
stn1  = -Wgpe_stn.*sigGPE(Z(7,1)) + Wmctx_stn.*sigCTX(Z(21,2)) + Wsctx_stn.*FRsctx1 + FRsubc1.*Wsubcortical_STN;
gpe1  = -Wstr2_gpe.*sigSTR2(Z(3,3)) + Wstn_gpe.*sigSTN(Z(5,2))+Wstn_gpe.*sigSTN(Z(15,2))-Wgpe_gpe.*sigGPE(Z(17,1)) - WgpeR.*sigGPE(Z(7,1)) - Wgpea_gpe.*sigGPEA(Z(25,1));
gpea1 = -Wcont_gpea.*sigSTR2(Z(3,3)) + Wstn_gpea.*sigSTN(Z(5,2))+Wstn_gpea.*sigSTN(Z(15,2)) - Wgpe_gpea.*sigGPE(Z(7,1))+FRinarky1.*Winputs_arky - WgpeR.*sigGPEA(Z(25,1));
gpi1  = -Wstr1_gpi.*sigSTR1(Z(1,4)) + Wstn_gpi.*sigSTN(Z(5,2))+Wstn_gpi.*sigSTN(Z(15,2))-Wgpe_gpi.*sigGPE(Z(17,2));
mctx1 = -Wgpi_mctx.*sigGPI(Z(9,5))  + Wsctx_mctx.*FRsctx1; 

% Channel 2
str12 = -Wstr_str.*sigSTR1(Z(1,3))  + Wsctx_str.*(1+Da).*FRsctx2 + Wmctx_str.*(1+Da).*sigCTX(Z(23,5)) - Wgpe_str.*sigGPE(Z(7,3)) -Wgpea_sel.*sigGPEA(Z(27,3));
str22 = -Wstr_str.*sigSTR2(Z(3,3))  + Wsctx_str.*(1-Da).*FRsctx2 + Wmctx_str.*(1-Da).*sigCTX(Z(23,5)) - Wgpe_str.*sigGPE(Z(7,3)) - Wgpea_cont.*sigGPEA(Z(27,3));
stn2  = -Wgpe_stn.*sigGPE(Z(17,1))  + Wmctx_stn.*sigCTX(Z(23,2)) + Wsctx_stn.*FRsctx2 + FRsubc2.*Wsubcortical_STN;
gpe2  = -Wstr2_gpe.*sigSTR2(Z(13,3))+ Wstn_gpe.*sigSTN(Z(5,2))+Wstn_gpe.*sigSTN(Z(15,2))-Wgpe_gpe.*sigGPE(Z(7,1)) - WgpeR.*sigGPE(Z(17,1)) - Wgpea_gpe.*sigGPEA(Z(27,1));
gpea2 = -Wcont_gpea.*sigSTR2(Z(13,3))+ Wstn_gpea.*sigSTN(Z(5,2))+Wstn_gpea.*sigSTN(Z(15,2))-Wgpe_gpea.*sigGPE(Z(17,1))+FRinarky2.*Winputs_arky - WgpeR.*sigGPEA(Z(27,1));
gpi2  = -Wstr1_gpi.*sigSTR1(Z(11,4))+ Wstn_gpi.*sigSTN(Z(5,2))+Wstn_gpi.*sigSTN(Z(15,2))-Wgpe_gpi.*sigGPE(Z(7,2));
mctx2 = -Wgpi_mctx.*sigGPI(Z(19,5)) + Wsctx_mctx.*FRsctx2;                            

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MODEL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yp = zeros(28,1);

% Channel 1
yp(1) = y(2);
yp(2) = (1/Tstr1.^2).*(str11) - (2/Tstr1).*y(2) - (1/Tstr1.^2).*y(1);
 
yp(3) = y(4);
yp(4) = (1/Tstr2.^2).*(str21) - (2/Tstr2).*y(4) - (1/Tstr2.^2).*y(3);

yp(5) = y(6);
yp(6) = (1/Tstn.^2) .*(stn1)  - (2/Tstn) .*y(6) - (1/Tstn.^2) .*y(5);

yp(7) = y(8);
yp(8) = (1/Tgpe.^2).*(gpe1) - (2/Tgpe).*y(8) - (1/Tgpe.^2) .*y(7);

yp(9)= y(10); 
yp(10)= (1/Tgpi.^2).*(gpi1) - (2/Tgpi).*y(10) - (1/Tgpi.^2) .*y(9);

% Channel 2
yp(11) = y(12);
yp(12) = (1/Tstr1.^2).*(str12) - (2/Tstr1).*y(12) - (1/Tstr1.^2).*y(11);

yp(13) = y(14);
yp(14) = (1/Tstr2.^2).*(str22) - (2/Tstr2).*y(14) - (1/Tstr2.^2).*y(13);

yp(15) = y(16);
yp(16) = (1/Tstn.^2) .*(stn2)  - (2/Tstn) .*y(16) - (1/Tstn.^2) .*y(15);

yp(17) = y(18);
yp(18) = (1/Tgpe.^2).*(gpe2) - (2/Tgpe).*y(18) - (1/Tgpe.^2) .*y(17);

yp(19)= y(20); 
yp(20)= (1/Tgpi.^2).*(gpi2) - (2/Tgpi).*y(20) - (1/Tgpi.^2) .*y(19);

% Cortex
yp(21) = y(22);
yp(22) = (1/Tctx.^2).*(mctx1) - (2/Tctx).*y(22) - (1/Tctx.^2) .*y(21);

yp(23) = y(24);
yp(24) = (1/Tctx.^2).*(mctx2) - (2/Tctx).*y(24) - (1/Tctx.^2) .*y(23);

% GPE-Arky
yp(25) = y(26);
yp(26) = (1/Tgpe.^2).*(gpea1) - (2/Tgpe).*y(26) - (1/Tgpe.^2) .*y(25);

yp(27) = y(28);
yp(28) = (1/Tgpe.^2).*(gpea2) - (2/Tgpe).*y(28) - (1/Tgpe.^2) .*y(27);

% Gompertz functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function S = sigSTR1(V) 
        S = Mstr1.* (Bstr1/Mstr1).^(exp(-(exp(1).*V)./Mstr1));
    end
    function S = sigSTR2(V) 
        S = Mstr2.* (Bstr2/Mstr2).^(exp(-(exp(1).*V)./Mstr2));
    end
    function S = sigSTN(V) 
        S = Mstn.* (Bstn/Mstn).^(exp(-(exp(1).*V)./Mstn));
    end
    function S = sigGPE(V) 
        S = Mgpe.* (Bgpe/Mgpe).^(exp(-(exp(1).*V)./Mgpe));
    end
    function S = sigGPEA(V)
        S = Mgpe.* (Bgpe/Mgpe).^(exp(-(exp(1).*V)./Mgpe));
    end
    function S = sigGPI(V) 
        S = Mgpi.* (Bgpi/Mgpi).^(exp(-(exp(1).*V)./Mgpi));
    end
    function S = sigCTX(V) 
        S = Mctx.* (Bctx/Mctx).^(exp(-(exp(1).*V)./Mctx));
    end
end