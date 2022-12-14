load("StudentData22.mat")
%% 2a)
PB_SI = PB.*133.322;  % mmHg -> Pa
PSM_SI = PSM.*133.322;
Q_SI = (Q./10^6)./60;  % microlitre /min -> litre/sec

R = 125*10^-6;  % radius in meters
L = 0.3;  %  length in meters
mu_apparent_b = (pi*R^4/(8*L)).*PB_SI./Q_SI;
mu_apparent_sm = (pi*R^4/(8*L)).*PSM_SI./Q_SI;

%% 2c)

fitout_b = GeneralLinearFit(log(Q_SI), log(mu_apparent_b))
fitout_sm = GeneralLinearFit(log(Q_SI), log(mu_apparent_sm))

nb = fitout_b.b1 + 1
kb = 4*exp(fitout_b.b0)*((fitout_b.b1+1)/(3*fitout_b.b1+4))^(fitout_b.b1+1)*(pi*R^3)^fitout.b1

nsm = fitout_sm.b1 + 1
ksm = 4*exp(fitout_sm.b0)*(((fitout_sm.b1+1)/(3*fitout_sm.b1+4))^(fitout_sm.b1+1))*(pi*R^3)^fitout_sm.b1

%% 2d)

kb_ans = kb*10^3
ksm_ans = ksm*10^3

%% 2e) Plot of apparent viscosity vs flow rate

fig1 = figure(1);

subplot(1,2,1); hold on; grid on;

% Plot raw data
% plot(Q, mu_apparent_sm.*10^3, 'bo-')  % Suspension Medium
% plot(Q, mu_apparent_b.*10^3, 'ro-')  % Blood
scatter(Q, mu_apparent_sm.*10^3, 'b')  % Suspension Medium
scatter(Q, mu_apparent_b.*10^3, 'r')  % Blood

% Plot best fits from power law
plot((exp(fitout_sm.xfit).*(10^6.*60)), exp(fitout_sm.yfit).*1000, 'b')
plot((exp(fitout_b.xfit).*(10^6.*60)), exp(fitout_b.yfit).*1000, 'r')

% Plot cbands
plot((exp(fitout_sm.xfit).*(10^6.*60)), exp(fitout_sm.cbands).*1000, 'b--')
plot((exp(fitout_b.xfit).*(10^6.*60)), exp(fitout_b.cbands).*1000, 'r--')

% Format graph
title('Linear plot for \mu_{app} vs flow rate with power law fit')
legend('SM Raw Data', 'B Raw Data', 'SM Power Law fit', 'B Power Law fit',  'SM Confidence Intervals', '', 'B Confidence Intervals')
xlabel('Flow rate (\muL/min)')
ylabel('Apparent viscosity, \mu_{app} (\muPa s)')
hold off;

subplot(1,2,2); hold on; grid on;
% Plot raw data
scatter(Q, mu_apparent_sm.*10^3, 'b')  % Suspension Medium
scatter(Q, mu_apparent_b.*10^3, 'r')  % Blood

% Plot best fits from power law
plot((exp(fitout_sm.xfit).*(10^6.*60)), exp(fitout_sm.yfit).*1000, 'b')
plot((exp(fitout_b.xfit).*(10^6.*60)), exp(fitout_b.yfit).*1000, 'r')

% Plot cbands
plot((exp(fitout_sm.xfit).*(10^6.*60)), exp(fitout_sm.cbands).*1000, 'b--')
plot((exp(fitout_b.xfit).*(10^6.*60)), exp(fitout_b.cbands).*1000, 'r--')

% Format graph
title('           Logarithmic plot for \mu_{app} vs flow rate with power law fit')
legend('SM Raw Data', 'B Raw Data', 'SM Power Law fit', 'B Power Law fit',  'SM Confidence Intervals', '', 'B Confidence Intervals')
xlabel('Flow rate (\muL/min)')
ylabel('Apparent viscosity, \mu_{app} (\muPa s)')

set(gca, 'xscale', 'log', 'yscale', 'log')
hold off;

%% 