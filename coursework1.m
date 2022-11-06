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

lts = data(:,{'Frame','L_Thigh_SuperiorX', 'L_Thigh_SuperiorY', 'L_Thigh_SuperiorZ', 'L_Thigh_InferiorX', 'L_Thigh_InferiorY', 'L_Thigh_InferiorZ', 'L_Thigh_LateralX', 'L_Thigh_LateralY', 'L_Thigh_LateralZ'})
lts = lts{lts{:,'Frame'} == 98, :}
lt_sup = lts(2:4)
lt_inf = lts(5:7)
lt_lat = lts(8:end)

