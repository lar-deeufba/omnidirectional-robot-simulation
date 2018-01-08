% clc
% clear all
% close all

%-----------------------------------%
%Variaveis

 global AA;
 global BB;
 global CC;
 global Q;
 global R;
 global N;
 global Nu;
 global Umax; 
 global Umin; 
 global I;
 global ts;

%-----------------------------------%
%CONSTANTES

s = tf('s');
I = eye(3);
Z = zeros(3);

ts = 0.06; %Sampling time (s)

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
%Para definir o modelo SISO faça:

%Definindo u1=0; u2=-u3
%          Vn=0; W=0
%Considerando assim apenas a Saida V

%A = Ac(1,1);
%B = 2*Bc(1,2);
%C = 1;

%-----------------------------------%
%MATRIZES - MODELO DISCRETO

SYS = ss(Ac,Bc,Cc,0);

SYSd = c2d(SYS,ts);

[Ad, Bd, Cd, Dd] = ssdata(SYSd);

%-----------------------------------%
%MATRIZES - MODELO AUMENTADO

Aa = [Ad Z; Cd*Ad I];
Ba = [Bd; Cd*Bd];
Ca = [Z I];

%-----------------------------------%
%Constantes Para Calculo do Otimizador

Umin = -6;
Umax = 6;
N = 4;
Nu = 4;

Q = 100*diag(diag(ones(3*N))');
R = diag(diag(ones(3*Nu))');

I = diag(ones(Nu));

%-----------------------------------%
%Matrizes do Preditor com Horizonte N, Nu

[a1,a2] = size(Aa);
[b1,b2] = size(Ba);
[c1,c2] = size(Ca);

AA = zeros(N*a1,a2);
BB = zeros(N*b1,Nu*b2);
CC = zeros(N*c1,N*c2);

AA(1:a1,:) = Aa;
BB(1:b1,1:b2) = Ba;
CC(1:c1,1:c2) = Ca;


for i=2 : N
   AA(i*a1-a1+1:i*a1,:) = AA((i-1)*a1-a1+1:(i-1)*a1,:)*Aa;
   BB(i*b1-b1+1:i*b1,1:b2) = AA((i-1)*a1-a1+1:(i-1)*a1,:)*Ba;
   BB(i*b1-b1+1:i*b1,b2+1:Nu*b2) = BB((i-1)*b1-b1+1:(i-1)*b1,1:Nu*b2-b2);
   CC(i*c1-c1+1:i*c1,i*c2-c2+1:i*c2) = Ca;
end

%H = 2*(BB'*CC'*Q*CC*BB+R);
%H = (H+H')/2;

%-----------------------------------%

np = 0;
alpha = 0.85;

sim('simula_axebot_nao_linear_MPC_PSF.mdl')

grafico