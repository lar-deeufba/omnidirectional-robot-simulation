close all

t = linspace(0,size(V,1)-1,size(V,1))';
%t = linspace(0,199,200)';
%t=t*0.05;

%% Trajetoria
% a = linspace(pi/2,3*pi/2,13);
% xx = 0.5*cos(a)+ 1.6;
% yy= 0.5*sin(a)+ 0.5;

Xd = [0,1,1,0,0]';
Yd = [0,0,1,1,0]';
plot(Xr,Yr,'b-*','MarkerSize',3,'linewidth',1)
hold on
plot(TrajX,TrajY,'black-o')
%ylim([-0.1 1.1])
%xlim([-0.1 1.1])
xlabel('X (m)')
ylabel('Y (m)')
%legend('alpha 0,9','alpha 0,85','referência','location','northeast')
grid on

%% Velocidade
figure
subplot(3,1,1)
plot(t,V,'black-*','MarkerSize',3,'linewidth',1)
%hold on
%plot(t,Vref,'--r','linewidth',1)
%legend('V','V_r_e_f','location','northeast')
ylim([-0.8 0.8])
xlabel('Samples')
ylabel('v (m/s)')
grid on

subplot(3,1,2)
plot(t,Vn,'black-*','MarkerSize',3,'linewidth',1)
%hold on
%plot(t,Vnref,'--black','linewidth',1)
%legend('V_n','V_n_r_e_f','location','northeast')
ylim([-0.8 0.8])
xlabel('Samples')
ylabel('v_n (m/s)')
grid on

subplot(3,1,3)
plot(t,W,'black-*','MarkerSize',3,'linewidth',1)
%hold on
%plot(t,Wref,'--black','linewidth',1)
%legend('W','W_r_e_f','location','northeast')
ylim([-5 5])
xlabel('Samples')
ylabel('w (rad/s)')
grid on

%% Pose
figure
subplot(3,1,1)
plot(t,Xr,'black-*','MarkerSize',3,'linewidth',1)
%legend('X','location','northeast')
%ylim([-3 3])
xlabel('Samples')
ylabel('X (m)')
grid on

subplot(3,1,2)
plot(t,Yr,'black-*','MarkerSize',3,'linewidth',1)
%legend('Y','location','northeast')
%ylim([-0.2 1])
xlabel('Samples')
ylabel('Y (m)')
grid on

subplot(3,1,3)
plot(t,Teta,'black-*','MarkerSize',3,'linewidth',1)
%legend('theta','location','northeast')
%ylim([-0.5 0])
xlabel('Samples')
ylabel('Theta (rad)')
grid on

%% Sinal Controle
figure
subplot(3,1,1)
plot(t,u1,'black-*','MarkerSize',3,'linewidth',1)
%legend('X','location','northeast')
%ylim([-3 3])
xlabel('Samples')
ylabel('u1 (V)')
grid on

subplot(3,1,2)
plot(t,u2,'black-*','MarkerSize',3,'linewidth',1)
%legend('Y','location','northeast')
%ylim([-3 3])
xlabel('Samples')
ylabel('u2 (V)')
grid on

subplot(3,1,3)
plot(t,u3,'black-*','MarkerSize',3,'linewidth',1)
%legend('theta','location','northeast')
%ylim([-3 3])
xlabel('Samples')
ylabel('u3 (V)')
grid on