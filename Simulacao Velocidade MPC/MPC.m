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
    
    W = repmat(u(1:3),N,1);
    
    QSI = u(4:9);
 
    %Resolvendo o problema de otimização de forma analitica - Sem Restrições 
    dControl = ((BB'*CC'*Q'*CC*BB+R)^(-1))*BB'*CC'*Q'*(W-CC*AA*QSI);
    
    control = control + dControl(1:3);

    y = control;

end

