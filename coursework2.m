load("StudentData22.mat")
%% 2a)
PB_SI = PB.*133.322;  % mmHg -> Pa
PSM_SI = PSM.*133.322;
Q_SI = (Q./10^6./10^3)./60;  % microlitre /min -> m3/sec

R = 125*10^-6;  % radius in meters
L = 0.3;  %  length in meters
mu_apparent_b = (pi*R^4/(8*L)).*PB_SI./Q_SI;
mu_apparent_sm = (pi*R^4/(8*L)).*PSM_SI./Q_SI;

%% 2c)

fitout_b = GeneralLinearFit(log(Q_SI), log(mu_apparent_b))
fitout_sm = GeneralLinearFit(log(Q_SI), log(mu_apparent_sm))

nb = fitout_b.b1 + 1
kb = 4*exp(fitout_b.b0)*((fitout_b.b1+1)/(3*fitout_b.b1+4))^(fitout_b.b1+1)*(pi*R^3)^fitout_b.b1

nsm = fitout_sm.b1 + 1
ksm = 4*exp(fitout_sm.b0)*(((fitout_sm.b1+1)/(3*fitout_sm.b1+4))^(fitout_sm.b1+1))*(pi*R^3)^fitout_sm.b1

%% 2d)

kb_ans = kb*10^3
ksm_ans = ksm*10^3

%% 2e) Plot of apparent viscosity vs flow rate

fig1 = figure(1); clf;

subplot(1,2,1); hold on; grid on;

% Plot raw data
% plot(Q, mu_apparent_sm.*10^3, 'bo-')  % Suspension Medium
% plot(Q, mu_apparent_b.*10^3, 'ro-')  % Blood
scatter(Q, mu_apparent_sm.*10^3, 'b')  % Suspension Medium
scatter(Q, mu_apparent_b.*10^3, 'r')  % Blood

% Plot best fits from power law
plot((exp(fitout_sm.xfit).*(10^9.*60)), exp(fitout_sm.yfit).*1000, 'b')
plot((exp(fitout_b.xfit).*(10^9.*60)), exp(fitout_b.yfit).*1000, 'r')

% Plot cbands
plot((exp(fitout_sm.xfit).*(10^9.*60)), exp(fitout_sm.cbands).*1000, 'b--')
plot((exp(fitout_b.xfit).*(10^9.*60)), exp(fitout_b.cbands).*1000, 'r--')

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
plot((exp(fitout_sm.xfit).*(10^9.*60)), exp(fitout_sm.yfit).*1000, 'b')
plot((exp(fitout_b.xfit).*(10^9.*60)), exp(fitout_b.yfit).*1000, 'r')

% Plot cbands
plot((exp(fitout_sm.xfit).*(10^9.*60)), exp(fitout_sm.cbands).*1000, 'b--')
plot((exp(fitout_b.xfit).*(10^9.*60)), exp(fitout_b.cbands).*1000, 'r--')

% Format graph
title('           Logarithmic plot for \mu_{app} vs flow rate with power law fit')
legend('SM Raw Data', 'B Raw Data', 'SM Power Law fit', 'B Power Law fit',  'SM Confidence Intervals', '', 'B Confidence Intervals')
xlabel('Flow rate (\muL/min)')
ylabel('Apparent viscosity, \mu_{app} (\muPa s)')

set(gca, 'xscale', 'log', 'yscale', 'log')
hold off;

%% Q3a) Calculate shear rate and shear stress for blood
shear_rate_WN = -4.*Q_SI./pi./R^3  % Wall shear rate for newtonian fluid in SI
shear_stress_W_b = -R/2.*PB_SI./L

%% 3b)
G = log(abs(shear_rate_WN))
T = log(abs(shear_stress_W_b))

fitout_3 = GeneralLinearFit(T, G)
dgdt = fitout_3.b1;

%% 3c)
shear_rate_wall = shear_rate_WN./4.*(3+dgdt)  % in SI, Pa s

mu_wall = shear_stress_W_b./shear_rate_wall

%% 3e)
cftool(abs(shear_rate_wall), mu_wall)

%% 3f)

% casson_fit = casson(abs(shear_rate_wall), mu_wall)
% pwr_fit = power_law(abs(shear_rate_wall), mu_wall)

fig2 = figure(2);clf;

subplot(1,2,1);  grid on; hold on;
set(gca, 'xscale', 'log', 'yscale', 'log')
% Plot mu (mPa s) vs shear rate (1/s)
scatter(abs(shear_rate_wall.*10^3), mu_wall, 'r')

% Plot fits of models
g = 10.^(0:0.001:3);  % in Pa

mu_casson = casson_fit.kc+casson_fit.ty./g+2*sqrt(casson_fit.kc*casson_fit.ty./g);
mu_pwr = pwr_fit.kp.*g.^(pwr_fit.n-1);

plot(g.*10^3, mu_casson, 'Color',[0.9290 0.6940 0.1250])  % g converted to mPa
plot(g.*10^3, mu_pwr, 'g')

legend('Raw \mu Data', 'Casson fit', 'Power Law fit')
xlabel('Shear Rate, $\dot{\gamma}$ (1/s)', 'Interpreter', 'latex')
ylabel('Viscosity, \mu_{w} (mPa s)')

subplot(1,2,2); grid on; hold on;
mu_casson_res = casson_fit.kc+casson_fit.ty./shear_rate_wall+2*sqrt(casson_fit.kc*casson_fit.ty./shear_rate_wall);
mu_pwr_res = pwr_fit.kp.*shear_rate_wall.^(pwr_fit.n-1);

res_pwr = mu_wall-mu_pwr_res;
res_cas = mu_wall-mu_casson_res;

plot(abs(shear_rate_wall), res_pwr, 'go-')
plot(abs(shear_rate_wall), res_cas, 'o-', 'Color', [0.9290 0.6940 0.1250])