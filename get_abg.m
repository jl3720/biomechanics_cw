function [alpha, beta, gamma] = get_abg(tmat)
    beta = atan2(tmat(1,3), tmat(1,1))*180/pi;
    gamma = atan2(tmat(3,2), tmat(2,2))*180/pi;
    alpha = atan2(-tmat(1,2), sqrt((tmat(1,1))^2+(tmat(1,3))^2))*180/pi;
end