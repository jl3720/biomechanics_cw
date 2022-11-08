function lab_tmat_lts_i = get_lab_tmat_lts_i(frame, data)
    lt = data(:,{'Frame','L_Thigh_SuperiorX', 'L_Thigh_SuperiorY', 'L_Thigh_SuperiorZ', 'L_Thigh_InferiorX', 'L_Thigh_InferiorY', 'L_Thigh_InferiorZ', 'L_Thigh_LateralX', 'L_Thigh_LateralY', 'L_Thigh_LateralZ'});
    lti = lt{lt{:,'Frame'} == frame, :};
    
    lt_supi = lti(2:4);
    lt_infi = lti(5:7);
    lt_lati = lti(8:end);
    
    sii = lt_infi - lt_supi;
    sli = lt_lati - lt_supi;
    
    y_hati = -sii./norm(sii);
    
    ni = cross(sii, sli);
    x_hati = ni./norm(ni);
    z_hati = cross(x_hati,y_hati);
    
    rot_mati = [x_hati', y_hati', z_hati'];
    rot_mati(4,:) = 0;
    pltsi = [lt_supi';1];
    lab_tmat_lts_i = [rot_mati, pltsi];
end