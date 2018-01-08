close all

t = linspace(0,size(V,1)-1,size(V,1))';
%% Velocidade
figure
subplot(3,1,1)
plot(t,V,'-*b','MarkerSize',3,'linewidth',1.5)
hold on
plot(t,Vref,'--k','linewidth',1)
legend('V','V_r_e_f','location','northeast')
ylim([-0.8 0.8])
xlabel('Samples')
ylabel('v (m/s)')
grid on

subplot(3,1,2)
plot(t,Vn,'-*b','MarkerSize',3,'linewidth',1.5)
hold on
plot(t,Vnref,'--k','linewidth',1)
legend('V_n','V_n_r_e_f','location','northeast')
ylim([-0.8 0.8])
xlabel('Samples')
ylabel('v_n (m/s)')
grid on

subplot(3,1,3)
plot(t,W,'-*b','MarkerSize',3,'linewidth',1.5)
hold on
plot(t,Wref,'--k','linewidth',1)
legend('W','W_r_e_f','location','northeast')
ylim([-5 5])
xlabel('Samples')
ylabel('w (rad/s)')
grid on

%% Sinal Controle
figure
subplot(3,1,1)
plot(t,u1,'-*b','MarkerSize',3,'linewidth',1.5)
%legend('X','location','northeast')
ylim([-3 3])
xlabel('Samples')
ylabel('u_1 (V)')
grid on

subplot(3,1,2)
plot(t,u2,'-*b','MarkerSize',3,'linewidth',1.5)
%legend('Y','location','northeast')
ylim([-3 3])
xlabel('Samples')
ylabel('u_2 (V)')
grid on

subplot(3,1,3)
plot(t,u3,'-*b','MarkerSize',3,'linewidth',1.5)
%legend('theta','location','northeast')
ylim([-3 3])
xlabel('Samples')
ylabel('u_3 (V)')
grid on

%% Ruido
figure
plot(t,noise,'black--*','MarkerSize',3,'linewidth',1.5)
%legend('X','location','northeast')
%ylim([-3 3])
xlabel('Samples')
ylabel('Noise')
grid on

% % %% Atraso
% % figure
% % plot(t,delay,'black-*','MarkerSize',3,'linewidth',1)
% % %legend('X','location','northeast')
% % %ylim([-3 3])
% % xlabel('Samples')
% % ylabel('Delay (s)')
% % grid on