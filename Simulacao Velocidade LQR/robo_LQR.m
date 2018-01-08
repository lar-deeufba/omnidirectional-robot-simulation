clear all
close all

ts=0.06;

%-----------------------------------%
%CONSTANTES

s = tf('s');
I = eye(3);
Z = zeros(3);

% REFERENCIA

Vref = 0.4;
Vnref = 0;
Wref = 0;

%-----------------------------------%
%PARAMETROS DO MODELO

Bv = 0.7;
Bvn = 0.7;
Bw = 0.011;

Cv = 0.28;
Cvn = 0.14;
Cw = 0.0086;

M = 1.551;
J = 0.0062;

b = 0.1;
r = 0.0505;
l = 19;

La = 0.00011;
Ra = 1.69;
Kv = 0.0059;
Kt = 0.0059;

%-----------------------------------%
%MATRIZES - MODELO

Ae = -3*l*l*Kt*Kt/(2*r*r*Ra);
Be = l*Kt/(r*Ra);

Ac = diag([(Ae-Bv)/M (Ae-Bvn)/M (Ae*b*b - Bw)/J]);
Bc = [0 sqrt(3)/(2*M) -sqrt(3)/(2*M) ; -1/M 1/(2*M) 1/(2*M) ; b/J b/J b/J]*Be;
Cc = I;
Dc = Z;
%Kc = diag([-Cv/M -Cvn/M -Cw/J]);
Kc = Z;

%Gc = [-1.2939 0 0;0 -1.1262 0;0 0 4.4444];
Gc = Z;

%-----------------------------------%
%CONSTANTES DO STICTION

deltaSv = 1;
deltaSvn = 1;
deltaSw = 1;
Vsv = 1;
Vsvn = 1;
Vsw = 1;
deltaS = [deltaSv;deltaSvn;deltaSw];
Vs = [Vsv;Vsvn;Vsw];

%-----------------------------------%
%MATRIZES - MODELO DISCRETO

SYS = ss(Ac,Bc,Cc,0);

SYSd = c2d(SYS,ts);

[Ad, Bd, Cd, Dd] = ssdata(SYSd);

Ag = [Ad Z ; Cd*Ad I];
Bg = [Bd ; Cd*Bd];
Cg = [Z I];
Dg = Dc;

%-----------------------------------%
%MATRIZES - MODELO AUMENTADO

Aa = [Ad Z; Cd*Ad I];
Ba = [Bd; Cd*Bd];
Ca = [Z I];

%-----------------------------------%
%Constantes Para Calculo do Otimizador

Umin = -6;
Umax = 6;

Q = 100*eye(6);
% Qy = diag([100,100,100]);

R = I;
% Ry = I;

[Kdlqr S E] = dlqr(Ag, Bg, Q, R);
% [Kdlqry, Sy, Ey] = dlqry(Ag, Bg, Cg, Dg, Qy, Ry);

%-----------------------------------%

np = 0.00005;
alpha = 0.85;

% sim('simula_axebot_com_atraso_controlador_sem_atraso')
sim('simula_axebot_com_atraso_controlador_com_preditor_smith')
% sim('simula_axebot_com_atraso_controlador_com_preditor_otimo')

grafico;