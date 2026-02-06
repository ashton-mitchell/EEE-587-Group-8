clc; close all

% fixed parameters
Ke = 0.01; % Electromotive Force Constant
Km = 0.01; % Torque-current ratio
J = 0.01; % Moment of Inertia of the Rotor
Kd = 0.1; % Damping Ratio of the Inertia of the Rotor
R = 1; % Resistance
L = 0.25; % Inductance

% values to sweep
V_values = [1 1.2 1.5];
colors = lines(numel(V_values));

A = [-R/L -Ke/L
     Km/J -Kd/J];
B = [1/L; 0];
C = [0 1];
D = 0;

sys_ss = ss(A,B,C,D);
t = linspace(0,5,1000);

%% Armature Current Plot
figure; hold on
for k = 1:numel(V_values)
    V = V_values(k);
    u = V * ones(size(t));
    [y,~,x] = lsim(sys_ss,u,t);
    i = x(:,1);

    plot(t,i,'LineWidth',2,'color',colors(k,:))
end
xlabel('Time (s)','FontWeight','bold')
ylabel('Current i(t) (A)','FontWeight','bold')
legend('1 V', '1.2 V','1.5 V','Location', 'best')
title('Armature Current Response')
grid on

%% Motor Torque Plot
figure; hold on
for k = 1:numel(V_values)
    V = V_values(k);
    u = V * ones(size(t));
    [y,~,x] = lsim(sys_ss,u,t);
    i = x(:,1);
    tau = Km .* i;

    plot(t,tau,'LineWidth',2,'color',colors(k,:))
end
xlabel('Time (s)','FontWeight','bold')
ylabel('Torque \tau(t) (N·m)','FontWeight','bold')
legend('1 V', '1.2 V','1.5 V','Location', 'best')
title('Motor Torque Response')
grid on

%% Phase-Plane Plot
figure; hold on
for k = 1:numel(V_values)
    V = V_values(k);
    u = V * ones(size(t));
    [y,~,x] = lsim(sys_ss,u,t);
    i = x(:,1);
    omega = x(:,2);

    plot(i,omega,'LineWidth',2,'color',colors(k,:))
end

xlabel('Current i(t) (A)','FontWeight','bold')
ylabel('Speed \omega(t) (rad/s)','FontWeight','bold')
legend('1 V', '1.2 V','1.5 V','Location', 'best')
title('Phase-Plane Plot')
grid on
