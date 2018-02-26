function y = translate(x, p)

Mstr1  = p.fixed.str1(2);     % Maximum firing rate
Bstr1  = p.fixed.str1(3);     % Firing rate in absence of inputs

Mstr2  = p.fixed.str2(2);
Bstr2  = p.fixed.str2(3);
         
Mstn   = p.fixed.stn(2);
Bstn   = p.fixed.stn(3);

Mgpe  = p.fixed.gpe(2);
Bgpe  = p.fixed.gpe(3);

Mgpi  = p.fixed.gpi(2);
Bgpi  = p.fixed.gpi(3);

Mctx  = p.fixed.ctx(2);
Bctx  = p.fixed.ctx(3);

% Interneurons and Arky cells

Mgpea  = p.fixed.gpe(2);
Bgpea  = p.fixed.gpe(3);

if size(x,1)<=10
     
    %%% Gompertz Non-linearity
    y(1,:) = Mstr1.* (Bstr1/Mstr1).^(exp(-(exp(1).*x(1,:)) ./Mstr1));
    y(3,:) = Mstr2.* (Bstr2/Mstr2).^(exp(-(exp(1).*x(3,:)) ./Mstr2));
    y(5,:) = Mstn .* (Bstn/Mstn)  .^(exp(-(exp(1).*x(5,:)) ./Mstn));
    y(7,:) = Mgpe .* (Bgpe/Mgpe)  .^(exp(-(exp(1).*x(7,:)) ./Mgpe));
    y(9,:)= Mgpi .* (Bgpi/Mgpi)  .^(exp(-(exp(1).*x(9,:))./Mgpi));
    

elseif size(x,1)>10 && size(x,1)<=28
    y(1,:) = Mstr1.* (Bstr1/Mstr1).^(exp(-(exp(1).*x(1,:)) ./Mstr1));
    y(3,:) = Mstr2.* (Bstr2/Mstr2).^(exp(-(exp(1).*x(3,:)) ./Mstr2));
    y(5,:) = Mstn .* (Bstn/Mstn)  .^(exp(-(exp(1).*x(5,:)) ./Mstn));
    y(7,:) = Mgpe .* (Bgpe/Mgpe)  .^(exp(-(exp(1).*x(7,:)) ./Mgpe));
    y(9,:)= Mgpi .* (Bgpi/Mgpi)  .^(exp(-(exp(1).*x(9,:))./Mgpi));
        
    y(11,:) = Mstr1.* (Bstr1/Mstr1).^(exp(-(exp(1).*x(11,:)) ./Mstr1));
    y(13,:) = Mstr2.* (Bstr2/Mstr2).^(exp(-(exp(1).*x(13,:)) ./Mstr2));
    y(15,:) = Mstn .* (Bstn/Mstn)  .^(exp(-(exp(1).*x(15,:)) ./Mstn));
    y(17,:) = Mgpe .* (Bgpe/Mgpe)  .^(exp(-(exp(1).*x(17,:)) ./Mgpe));
    y(19,:)= Mgpi .* (Bgpi/Mgpi)  .^(exp(-(exp(1).*x(19,:))./Mgpi));
    
    y(21,:)= Mctx .* (Bctx/Mctx)  .^(exp(-(exp(1).*x(21,:))./Mctx));
    y(23,:)= Mctx .* (Bctx/Mctx)  .^(exp(-(exp(1).*x(23,:))./Mctx));

     y(25,:) = Mgpe .* (Bgpe/Mgpe)  .^(exp(-(exp(1).*x(25,:)) ./Mgpe));
     y(27,:) = Mgpe .* (Bgpe/Mgpe)  .^(exp(-(exp(1).*x(27,:)) ./Mgpe));

else  
    y(1,:) = Mstr1.* (Bstr1/Mstr1).^(exp(-(exp(1).*x(1,:)) ./Mstr1));
    y(3,:) = Mstr2.* (Bstr2/Mstr2).^(exp(-(exp(1).*x(3,:)) ./Mstr2));
    y(5,:) = Mstn .* (Bstn/Mstn)  .^(exp(-(exp(1).*x(5,:)) ./Mstn));
    y(7,:) = Mgpe .* (Bgpe/Mgpe)  .^(exp(-(exp(1).*x(7,:)) ./Mgpe));
    y(9,:) = Mgpi .* (Bgpi/Mgpi)  .^(exp(-(exp(1).*x(9,:))./Mgpi));
        
    y(11,:) = Mstr1.* (Bstr1/Mstr1).^(exp(-(exp(1).*x(11,:)) ./Mstr1));
    y(13,:) = Mstr2.* (Bstr2/Mstr2).^(exp(-(exp(1).*x(13,:)) ./Mstr2));
    y(15,:) = Mstn .* (Bstn/Mstn)  .^(exp(-(exp(1).*x(15,:)) ./Mstn));
    y(17,:) = Mgpe .* (Bgpe/Mgpe)  .^(exp(-(exp(1).*x(17,:)) ./Mgpe));
    y(19,:) = Mgpi .* (Bgpi/Mgpi)  .^(exp(-(exp(1).*x(19,:))./Mgpi));
    
    y(21,:) = Mstr1.* (Bstr1/Mstr1).^(exp(-(exp(1).*x(21,:)) ./Mstr1));
    y(23,:) = Mstr2.* (Bstr2/Mstr2).^(exp(-(exp(1).*x(23,:)) ./Mstr2));
    y(25,:) = Mstn .* (Bstn/Mstn)  .^(exp(-(exp(1).*x(25,:)) ./Mstn));
    y(27,:) = Mgpe .* (Bgpe/Mgpe)  .^(exp(-(exp(1).*x(27,:)) ./Mgpe));
    y(29,:) = Mgpi .* (Bgpi/Mgpi)  .^(exp(-(exp(1).*x(29,:))./Mgpi));
    
end
