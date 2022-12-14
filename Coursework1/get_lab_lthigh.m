function tmat = get_lab_lthigh(frame, data)
    lab_rs_ra = data(:,{'Frame', 'L_Thigh_SuperiorX', 'L_Thigh_SuperiorY', 'L_Thigh_SuperiorZ', 'L_Thigh_InferiorX','L_Thigh_InferiorY','L_Thigh_InferiorZ', 'L_Knee_LateralX','L_Knee_LateralY','L_Knee_LateralZ', 'L_Knee_MedialX','L_Knee_MedialY', 'L_Knee_MedialZ'});
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

    patella = data(:, {'Frame', 'L_PatellaX', 'L_PatellaY', 'L_PatellaZ'});
    patella105 = patella{patella{:,'Frame'} == frame, :};
    patella105 = patella105(2:end)';
    
    tmat = [x_hat_105, y_hat_105, z_hat_105, patella105];
    tmat = [tmat; 0 0 0 1];
end
