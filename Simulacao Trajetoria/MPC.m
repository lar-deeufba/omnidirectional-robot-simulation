function [ y ] = MPC( u )

    global AA;
    global BB;
    global CC;
    global Q;
    global R;
    global N;

    persistent control;

    if isempty(control)
        control = [0 0 0]';
    end
    
    W = u(1:N*3);
    
    QSI = u(N*(3+1):N*(3+1)+5);
 
    %Resolvendo o problema de otimizacao de forma analitica - Sem Restricoes 
    dControl = ((BB'*CC'*Q'*CC*BB+R)^(-1))*BB'*CC'*Q'*(W-CC*AA*QSI);
    
    control = control + dControl(1:3);

    y = control;

end

