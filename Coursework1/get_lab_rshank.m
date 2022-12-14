function tmat = get_lab_rshank(frame, data)
    lab_rs_ra = data(:,{'Frame', 'R_Shank_SuperiorX', 'R_Shank_SuperiorY', 'R_Shank_SuperiorZ', 'R_Shank_InferiorX','R_Shank_InferiorY','R_Shank_InferiorZ', 'R_Ankle_LateralX','R_Ankle_LateralY','R_Ankle_LateralZ', 'RankleMedialX','RankleMedialY', 'RankleMedialZ'});
    lab_rs_ra_i = lab_rs_ra{lab_rs_ra{:,'Frame'} == frame, :};
    rss = lab_rs_ra_i(2:4)';
    rsi = lab_rs_ra_i(5:7)';
    ral = lab_rs_ra_i(8:10)';
    ram = lab_rs_ra_i(11:end)';
    
    v2 = ram-ral;
    norm(v2);
    x_hat_105 = v2./norm(v2);
    
    % rt = data(:,{'Frame','R_Thigh_SuperiorX', 'R_Thigh_SuperiorY', 'R_Thigh_SuperiorZ', 'R_Thigh_InferiorX', 'R_Thigh_InferiorY', 'R_Thigh_InferiorZ'})
    % rts_105 = rt{rt{:,'Frame'} == 105,:}
    % 
    % rts = rts_105(2:4)'
    % rti = rts_105(5:end)'
    
    v1 = rss-rsi;
    
    n_105 = cross(v2,v1);
    mag_n = norm(n_105);
    z_hat_105 = n_105./norm(n_105);
    
    y_hat_105 = cross(z_hat_105,x_hat_105);
    
    tmat = [x_hat_105, y_hat_105, z_hat_105, rsi];
    tmat = [tmat; 0 0 0 1];
end
