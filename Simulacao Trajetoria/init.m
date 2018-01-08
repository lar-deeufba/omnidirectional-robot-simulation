clear all
close all

Ts=0.06;

% Trajetorias de referencia

% TrajPoints=21;
% TrajX=[0.0 0.2 0.4 0.6 0.8 1.0 1.0 1.0 1.0 1.0 1.0 0.8 0.6 0.4 0.2 0.0 0.0 0.0 0.0 0.0 0.0 ];
% TrajY=[0.0 0.0 0.0 0.0 0.0 0.0 0.2 0.4 0.6 0.8 1.0 1.0 1.0 1.0 1.0 1.0 0.8 0.6 0.4 0.2 0.0 ];
% TrajTheta=[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

p = pi;
tp2 = 3*pi/2;
tp4 = 5*pi/4;

TrajPoints=68;
TrajX=[0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.6 1.6 1.6 1.6 1.6 1.6 1.6 1.6 1.6 1.6 1.7 1.8 1.9 2.0 2.1 2.1 2.1 2.1 2.1 2.1];
TrajY=[0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.0 2.0 2.0 2.0 2.0 1.9 1.8 1.7 1.6 1.5];
TrajTheta=[0.0 p/4 p/4 p/4 p/4 p/4 p/4 p/4 p/4 p/4 p/4 0.0 0.0 0.0 0.0 0.0 0.0 p/2 p/2 p/2 p/2 p/2 p/2 p/2 p/2 p/2 p/2 0.0 0.0 0.0 0.0 0.0 tp2 tp2 tp2 tp2 tp2]; 
  
deg = linspace(pi/2,-pi,31);

TrajX = [TrajX (0.5*cos(deg)+ 2.1)]*4;
TrajY = [TrajY (0.5*sin(deg)+ 1.0)]*4;
TrajTheta = [TrajTheta atan2((0.5*sin(deg)+ 1.0),(0.5*cos(deg)+ 2.1)) ];



% Posicao inicial do Robo
Xini=TrajX(1);
Yini=TrajY(1);
Thetaini=TrajTheta(1);
%spline3d;
