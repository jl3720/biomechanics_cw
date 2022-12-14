function tmat = get_lab_limb_tmat(data, is_left, is_shank)
    rss = vec(2:4)';
    rsi = vec(5:7)';
    ral = vec(8:10)';
    ram = vec(11:end)';
    
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

    if is_left
        if is_shank
            origin = 

    
    tmat = [x_hat_105, y_hat_105, z_hat_105, origin];
    tmat = [tmat; 0 0 0 1];
end