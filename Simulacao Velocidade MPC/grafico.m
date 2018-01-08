figure
subplot(3,1,1)
plot(t,V,'-k','linewidth',1.5)
hold on
plot(t,Vref1,'--r','linewidth',1.5)
xlabel('tempo (s)')
ylabel('velocidade (m/s)')
ylim([-0.6 0.6])
grid on
subplot(3,1,2)
plot(t,Vn,'-k','linewidth',1.5)
hold on
plot(t,Vnref1,'--r','linewidth',1.5)
xlabel('tempo (s)')
ylabel('velocidade (m/s)')
ylim([-0.1 0.1])
grid on
subplot(3,1,3)
plot(t,W,'-k','linewidth',1.5)
hold on
plot(t,Wref1,'--r','linewidth',1.5)
xlabel('tempo (s)')
ylabel('velocidade (rad/s)')
ylim([-0.1 0.1])
grid on

figure
subplot(3,1,1)
plot(t,u1,'-k','linewidth',1.5)
xlabel('tempo (s)')
ylabel('u_1 (volts)')
ylim([-1 1])
grid on
subplot(3,1,2)
plot(t,u2,'-k','linewidth',1.5)
xlabel('tempo (s)')
ylabel('u_2 (volts)')
ylim([-4 4])
grid on
subplot(3,1,3)
plot(t,u3,'-k','linewidth',1.5)
xlabel('tempo (s)')
ylabel('u_3 (volts)')
ylim([-4 4])
grid on