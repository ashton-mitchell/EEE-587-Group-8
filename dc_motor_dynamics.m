clc; close all
% fixed parameters
Ke = 0.01; % Electromotive Force Constant
Km = 0.01; % Torque-current ratio
J = 0.01; % Moment of Inertia of the Rotor
Kd = 0.1; % Damping Ratio of the Inertia of the Rotor
% values to sweep
R_values = [1, 1.1, 1.2];
L_values = [0.05, 0.25, 0.5];
colors = lines(numel(L_values)); % colors for different L values
figure
for iR = 1:numel(R_values)
R = R_values(iR);
subplot(1,3,iR); hold on
legendEntries = cell(numel(L_values),1);
for iL = 1:numel(L_values)
L = L_values(iL);
% state-space matrices
A = [-R/L -Ke/L;
Km/J -Kd/J];
B = [1/L; 0];
C = [0 1];
D = 0;
sys_ss = ss(A,B,C,D);
% compute step response data (5 seconds)
[y,t] = step(sys_ss,5);
% plot step response
plot(t, squeeze(y), ...
'Color', colors(iL,:), ...
'LineWidth', 1.5);
legendEntries{iL} = sprintf('L = %.2g', L);
end
xlabel('Time (s)','FontWeight','bold')
ylabel('Speed (rad/s)','FontWeight','bold')
title(sprintf('R = %.2g', R))
legend(legendEntries,'Location','best')
grid on
% --- NEW: fix y-axis scale for 3rd subplot ---
if iR == 3
ylim([0 0.1])
end
hold off
end
sgtitle('DC Motor Step Responses: Effect of L for Different R Values')
