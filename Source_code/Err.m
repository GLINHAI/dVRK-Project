function [dis_err, ori_err, theta_err] = Err(T_cur, T_dsr, R_cur, R_dsr)

    dis_err = T_dsr - T_cur;

    R_e = R_cur' * R_dsr;
%     R_er = 0.5 * [R_e(3,2) - R_e(2,3);...
%                   R_e(1,3) - R_e(3,1);...  
%                   R_e(2,1) - R_e(1,2)];
    

    ori_err = 0.5 * [cross(R_cur(:,1), R_dsr(:,1)) +...
                     cross(R_cur(:,2), R_dsr(:,2)) +...
                     cross(R_cur(:,3), R_dsr(:,3))];
                 
    ct = 0.5 * (R_e(1,1) + R_e(2,2) + R_e(3,3) - 1);
    if ct >= 1.0
        theta_err = 0.0;
    elseif ct <= -1.0
        theta_err = deg2rad(180);
    else
        theta_err = acos(ct);
    end

end