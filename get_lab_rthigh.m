function lab_thigh_tmat_105 = get_lab_rthigh(frame, data)
    lab_rt_rs = data(:,{'Frame', 'R_Thigh_SuperiorX', 'R_Thigh_SuperiorY', 'R_Thigh_SuperiorZ', 'R_Thigh_InferiorX', 'R_Thigh_InferiorY', 'R_Thigh_InferiorZ', 'R_Knee_LateralX', 'R_Knee_LateralY', 'R_Knee_LateralZ', 'R_Knee_MedialX', 'R_Knee_MedialY', 'R_Knee_MedialZ'});
    lab_rt_rs_105 = lab_rt_rs{lab_rt_rs{:,'Frame'} == frame, :};
    rts = lab_rt_rs_105(2:4)';
    rti = lab_rt_rs_105(5:7)';
    rkl = lab_rt_rs_105(8:10)';
    rkm = lab_rt_rs_105(11:end)';
    
    v2 = rkm-rkl;
    norm(v2);
    x_hat_105 = v2./norm(v2);
    
    % rt = data(:,{'Frame','R_Thigh_SuperiorX', 'R_Thigh_SuperiorY', 'R_Thigh_SuperiorZ', 'R_Thigh_InferiorX', 'R_Thigh_InferiorY', 'R_Thigh_InferiorZ'})
    % rts_105 = rt{rt{:,'Frame'} == 105,:}
    % 
    % rts = rts_105(2:4)'
    % rti = rts_105(5:end)'
    
    v1 = rts-rti;
    
    n_105 = cross(v2,v1);
    mag_n = norm(n_105);
    z_hat_105 = n_105./norm(n_105);
    
    y_hat_105 = cross(z_hat_105,x_hat_105);
    
    patella = data(:, {'Frame', 'R_PatellaX', 'R_PatellaY', 'R_PatellaZ'});
    patella105 = patella{patella{:,'Frame'} == frame, :};
    patella105 = patella105(2:end)';
    lab_thigh_tmat_105 = [x_hat_105, y_hat_105, z_hat_105, patella105];
    lab_thigh_tmat_105 = [lab_thigh_tmat_105; 0 0 0 1];
end