clc;
data = readtable("Marker_data_2022.xlsx");
%% Q3)
L_Knee_MedialX = data{22:87,'L_Knee_MedialX'};
L_Knee_MedialY = data{22:87,'L_Knee_MedialY'};
L_Knee_MedialZ = data{22:87,'L_Knee_MedialZ'};
t = data{22:87,"time_sec_"};

%% 3i) Linear Interpolation
[XF,TXF] = fillmissing(L_Knee_MedialX, 'linear');
[YF,TYF] = fillmissing(L_Knee_MedialY, 'linear');
[ZF,TZF] = fillmissing(L_Knee_MedialZ, 'linear');

figure(1); clf; hold on;
title('Linear Interpolation of Left Medial Knee kinematics')

% Plot x trajectory
scatter(t, L_Knee_MedialX)
scatter(t(TXF),XF(TXF))

% Plot y trajectory
scatter(t, L_Knee_MedialY)
scatter(t(TYF),YF(TYF))

% Plot z trajectory
scatter(t, L_Knee_MedialZ)
scatter(t(TZF),ZF(TZF))
lgd = legend("X Coordinate Raw", "X Coordinate Interpolated", "Y Coordinate Raw", "Y Coordinate Interpolated", "Z Coordinate Raw", "Z Coordinate Interpolated");
lgd.Location = 'southwest';

%% 3ii) Spline
[XF,TXF] = fillmissing(L_Knee_MedialX, 'spline');
[YF,TYF] = fillmissing(L_Knee_MedialY, 'spline');
[ZF,TZF] = fillmissing(L_Knee_MedialZ, 'spline');

figure(2); clf; hold on;
title('Spline Interpolation of Left Medial Knee kinematics')

% Plot x trajectory
scatter(t, L_Knee_MedialX)
scatter(t(TXF),XF(TXF))

% Plot y trajectory
scatter(t, L_Knee_MedialY)
scatter(t(TYF),YF(TYF))

% Plot z trajectory
scatter(t, L_Knee_MedialZ)
scatter(t(TZF),ZF(TZF))
lgd = legend("X Coordinate Raw", "X Coordinate Interpolated", "Y Coordinate Raw", "Y Coordinate Interpolated", "Z Coordinate Raw", "Z Coordinate Interpolated");
lgd.Location = 'southwest';

%% 3iii) Redundant Marker Filling



figure(2); clf; hold on;
title('Spline Interpolation of Left Medial Knee kinematics')

% Plot x trajectory
scatter(t, L_Knee_MedialX)
scatter(t(TXF),XF(TXF))

% Plot y trajectory
scatter(t, L_Knee_MedialY)
scatter(t(TYF),YF(TYF))

% Plot z trajectory
scatter(t, L_Knee_MedialZ)
scatter(t(TZF),ZF(TZF))
lgd = legend("X Coordinate Raw", "X Coordinate Interpolated", "Y Coordinate Raw", "Y Coordinate Interpolated", "Z Coordinate Raw", "Z Coordinate Interpolated");
lgd.Location = 'southwest';

%% 3 Transformation Matrix for Left Thigh Superior
% left_thigh_sup_x = data{data{:,'Frame'} == 98, "L_Thigh_SuperiorX"}
% left_thigh_sup_y = data{data{:,'Frame'} == 98, "L_Thigh_SuperiorY"}
% left_thigh_sup_z = data{data{:,'Frame'} == 98, "L_Thigh_SuperiorZ"}
% left_thigh_sup = data(:,{'Frame','L_Thigh_SuperiorX', 'L_Thigh_SuperiorY', 'L_Thigh_SuperiorZ'})
% left_thigh_sup = left_thigh_sup(left_thigh_sup{:,'Frame'} == 98, :);
% left_thigh_sup = left_thigh_sup{:,2:end}

lts0 = data(:,{'Frame','L_Thigh_SuperiorX', 'L_Thigh_SuperiorY', 'L_Thigh_SuperiorZ', 'L_Thigh_InferiorX', 'L_Thigh_InferiorY', 'L_Thigh_InferiorZ', 'L_Thigh_LateralX', 'L_Thigh_LateralY', 'L_Thigh_LateralZ'})
lts = lts0{lts0{:,'Frame'} == 98, :}
lt_sup = lts(2:4)
lt_inf = lts(5:7)
lt_lat = lts(8:end)

si = lt_inf - lt_sup
sl = lt_lat - lt_sup

y_hat = -si./norm(si)

n = cross(si, sl);
x_hat = n./norm(n)
z_hat = cross(x_hat,y_hat)

rot_mat = [x_hat', y_hat', z_hat'];
rot_mat(4,:) = 0;
plts = [lt_sup';1];
t_mat = [rot_mat, plts]
%% 3iii)
lts80 = lts0{lts0{:,'Frame'} == 80, :}

lt_sup80 = lts80(2:4)
lt_inf80 = lts80(5:7)
lt_lat80 = lts80(8:end)

si80 = lt_inf80 - lt_sup80
sl80 = lt_lat80 - lt_sup80

y_hat80 = -si80./norm(si80)

n80 = cross(si80, sl80);
x_hat80 = n80./norm(n80)
z_hat80 = cross(x_hat80,y_hat80)

rot_mat80 = [x_hat80', y_hat80', z_hat80'];
rot_mat80(4,:) = 0;
plts80 = [lt_sup80';1];
t_mat80 = [rot_mat80, plts80];

lkm = data(:,{'Frame','L_Knee_MedialX','L_Knee_MedialY', 'L_Knee_MedialZ'});
lkm80 = lkm{lkm{:,'Frame'} == 80, :};
lkm80 = [lkm80(2:end), 1]'
lts_p_lkm80 = inv(t_mat80) * lkm80

lab_p_lkm_98 = t_mat*lts_p_lkm80

