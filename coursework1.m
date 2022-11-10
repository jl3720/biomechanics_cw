clc;
data = readtable("Marker_data_2022.xlsx");
format longg;
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
%% 3iii) Redundant Marker Filling
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

%% For loop for 3iii)
clc;
lab_lkm_vecs = [];
tmats = []
k = 1;
for frame=98:123
    lab_tmat_lts_i = get_lab_tmat_lts_i(frame, data);
    tmats(:,:,k) = lab_tmat_lts_i;
    lab_lkm_vecs(:,k) = lab_tmat_lts_i * lts_p_lkm80;
    k = k+1;
end

%% Plotting 3iii)
figure(3); clf; hold on;
title('Redundant Marker Filling of Left Medial Knee kinematics')

% Plot x trajectory
scatter(t, L_Knee_MedialX)
scatter(t(TXF),lab_lkm_vecs(1,:))

% Plot y trajectory
scatter(t, L_Knee_MedialY)
scatter(t(TYF),lab_lkm_vecs(2,:))

% Plot z trajectory
scatter(t, L_Knee_MedialZ)
scatter(t(TZF),lab_lkm_vecs(3,:))
lgd = legend("X Coordinate Raw", "X Coordinate Interpolated", "Y Coordinate Raw", "Y Coordinate Interpolated", "Z Coordinate Raw", "Z Coordinate Interpolated");
lgd.Location = 'southwest';
figure(3);

%% Q4i) Right Thigh to Lab
clc;
format longg;
% lab_rt_rs = [221.6410	371.8530	826.8640	223.3180	338.0770	588.5920	233.6706	339.0758	526.9028	215.0853	196.9434	528.2230];
lab_rt_rs = data(:,{'Frame', 'R_Thigh_SuperiorX', 'R_Thigh_SuperiorY', 'R_Thigh_SuperiorZ', 'R_Thigh_InferiorX', 'R_Thigh_InferiorY', 'R_Thigh_InferiorZ', 'R_Knee_LateralX', 'R_Knee_LateralY', 'R_Knee_LateralZ', 'R_Knee_MedialX', 'R_Knee_MedialY', 'R_Knee_MedialZ'})
lab_rt_rs_105 = lab_rt_rs{lab_rt_rs{:,'Frame'} == 105, :}
rts = lab_rt_rs_105(2:4)'
rti = lab_rt_rs_105(5:7)'
rkl = lab_rt_rs_105(8:10)'
rkm = lab_rt_rs_105(11:end)'

v2 = rkm-rkl
norm(v2)
x_hat_105 = v2./norm(v2)

% rt = data(:,{'Frame','R_Thigh_SuperiorX', 'R_Thigh_SuperiorY', 'R_Thigh_SuperiorZ', 'R_Thigh_InferiorX', 'R_Thigh_InferiorY', 'R_Thigh_InferiorZ'})
% rts_105 = rt{rt{:,'Frame'} == 105,:}
% 
% rts = rts_105(2:4)'
% rti = rts_105(5:end)'

v1 = rts-rti

n_105 = cross(v2,v1)
mag_n = norm(n_105)
z_hat_105 = n_105./norm(n_105)

y_hat_105 = cross(z_hat_105,x_hat_105)

patella = data(:, {'Frame', 'R_PatellaX', 'R_PatellaY', 'R_PatellaZ'})
patella105 = patella{patella{:,'Frame'} == 105, :}
patella105 = patella105(2:end)'
lab_thigh_tmat_105 = [x_hat_105, y_hat_105, z_hat_105, patella105]
lab_thigh_tmat_105 = [lab_thigh_tmat_105; 0 0 0 1]

%% 4ii) Right Shank
clc;
format longg;
% lab_rt_rs = [221.6410	371.8530	826.8640	223.3180	338.0770	588.5920	233.6706	339.0758	526.9028	215.0853	196.9434	528.2230];
lab_rs_ra = data(:,{'Frame', 'R_Shank_SuperiorX', 'R_Shank_SuperiorY', 'R_Shank_SuperiorZ', 'R_Shank_InferiorX','R_Shank_InferiorY','R_Shank_InferiorZ', 'R_Ankle_LateralX','R_Ankle_LateralY','R_Ankle_LateralZ', 'RankleMedialX','RankleMedialY', 'RankleMedialZ'})
lab_rs_ra_105 = lab_rs_ra{lab_rs_ra{:,'Frame'} == 105, :}
rss = lab_rs_ra_105(2:4)'
rsi = lab_rs_ra_105(5:7)'
ral = lab_rs_ra_105(8:10)'
ram = lab_rs_ra_105(11:end)'

v2 = ram-ral
norm(v2)
x_hat_105 = v2./norm(v2)

% rt = data(:,{'Frame','R_Thigh_SuperiorX', 'R_Thigh_SuperiorY', 'R_Thigh_SuperiorZ', 'R_Thigh_InferiorX', 'R_Thigh_InferiorY', 'R_Thigh_InferiorZ'})
% rts_105 = rt{rt{:,'Frame'} == 105,:}
% 
% rts = rts_105(2:4)'
% rti = rts_105(5:end)'

v1 = rss-rsi

n_105 = cross(v2,v1)
mag_n = norm(n_105)
z_hat_105 = n_105./norm(n_105)

y_hat_105 = cross(z_hat_105,x_hat_105)

lab_shank_tmat_105 = [x_hat_105, y_hat_105, z_hat_105, rsi]
lab_shank_tmat_105 = [lab_shank_tmat_105; 0 0 0 1]

%% 5 Joint Motion and Angles
lab_R_rt = lab_thigh_tmat_105(1:3,1:3)
R_inv = inv(lab_R_rt)
R_inv_dot_org = R_inv*patella105
rt_lab_tmat_105 = [R_inv, -R_inv_dot_org];
rt_lab_tmat_105 = [rt_lab_tmat_105; 0 0 0 1]

rt_rs_tmat_105 = rt_lab_tmat_105 * lab_shank_tmat_105
check_rt_rs_mat = inv(lab_thigh_tmat_105) * lab_shank_tmat_105
rt_rs_tmat_105 - check_rt_rs_mat

beta = atan2(rt_rs_tmat_105(1,3), rt_rs_tmat_105(1,1))*180/pi
gamma = atan2(rt_rs_tmat_105(3,2), rt_rs_tmat_105(2,2))*180/pi
alpha = atan2(-rt_rs_tmat_105(1,2), sqrt((rt_rs_tmat_105(1,1))^2+(rt_rs_tmat_105(1,3))^2))*180/pi

%% 6 test
test_rshank = get_lab_rshank(105, data)
test_r_thigh = get_lab_rthigh(105, data)

test_thigh_shank = inv(test_r_thigh) * test_rshank

test_beta = atan2(test_thigh_shank(1,3), test_thigh_shank(1,1))*180/pi
test_gamma = atan2(test_thigh_shank(3,2), test_thigh_shank(2,2))*180/pi
test_alpha = atan2(-test_thigh_shank(1,2), sqrt((test_thigh_shank(1,1))^2+(test_thigh_shank(1,3))^2))*180/pi

%% 6
clc;
r_angles = zeros(147,3);
l_angles = zeros(147,3);

for i=[0:size(data,1)-1]
    frame = i+data{1,'Frame'};
    rshank = get_lab_rshank(frame, data);
    rthigh = get_lab_rthigh(frame, data);
    lshank = get_lab_lshank(frame, data);
    lthigh = get_lab_lthigh(frame, data);

    r_rot = inv(rthigh)*rshank;
    l_rot = inv(lthigh)*lshank;

    [ralpha, rbeta, rgamma] = get_abg(r_rot);
    [lalpha, lbeta, lgamma] = get_abg(l_rot);

    r_angles(i+1,:) = [ralpha, rbeta, rgamma];
    l_angles(i+1,:) = [lalpha, lbeta, lgamma];
end

figure(4); clf;hold on;
plot(r_angles(:,1))
plot(r_angles(:,2))
plot(r_angles(:,3))
legend('alpha', 'beta', 'gamma')