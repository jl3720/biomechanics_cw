function tmat = get_lab_lshank(frame, data)
    lab_rs_ra = data(:,{'Frame', 'L_Shank_SuperiorX', 'L_Shank_SuperiorY', 'L_Shank_SuperiorZ', 'L_Shank_InferiorX','L_Shank_InferiorY','L_Shank_InferiorZ', 'L_Ankle_LateralX','L_Ankle_LateralY','L_Ankle_LateralZ', 'L_Ankle_MedialX','L_Ankle_MedialY', 'L_Ankle_MedialZ'});
    lab_rs_ra_i = lab_rs_ra{lab_rs_ra{:,'Frame'} == frame, :};
    ss = lab_rs_ra_i(2:4)';
    si = lab_rs_ra_i(5:7)';
    al = lab_rs_ra_i(8:10)';
    am = lab_rs_ra_i(11:end)';
    
    v2 = al - am;
    norm(v2);
    x_hat_105 = v2./norm(v2);
    
    % rt = data(:,{'Frame','R_Thigh_SuperiorX', 'R_Thigh_SuperiorY', 'R_Thigh_SuperiorZ', 'R_Thigh_InferiorX', 'R_Thigh_InferiorY', 'R_Thigh_InferiorZ'})
    % rts_105 = rt{rt{:,'Frame'} == 105,:}
    % 
    % rts = rts_105(2:4)'
    % rti = rts_105(5:end)'
    
    v1 = ss-si;
    
    n_105 = cross(v2,v1);
    mag_n = norm(n_105);
    z_hat_105 = n_105./norm(n_105);
    
    y_hat_105 = cross(z_hat_105,x_hat_105);
    
    tmat = [x_hat_105, y_hat_105, z_hat_105, si];
    tmat = [tmat; 0 0 0 1];
end
