function error = Err(x_dsr, x_cur)

    % error
    % .pos : position difference (3-by-1 vector)
    % .dis : absolute distance between dsr and cur (scalar)
    % .ori : orientation difference (3-by-1 vector)
    % .th : angle difference (scalar)
    % .e : combination of position and orientation error (6-by-1 vector)
    
    T_dsr = x_dsr(1:3,4);
    R_dsr = x_dsr(1:3,1:3);
    T_cur = x_cur(1:3,4);
    R_cur = x_cur(1:3,1:3);
    
    error.pos = T_dsr - T_cur;
    error.dis = sqrt(error.pos(1)^2 + error.pos(2)^2 + error.pos(3)^2);

    R_e = R_cur' * R_dsr;

    error.ori = 0.5 * (cross(R_cur(:,1), R_dsr(:,1)) +...
                       cross(R_cur(:,2), R_dsr(:,2)) +...
                       cross(R_cur(:,3), R_dsr(:,3)));
                   
%     error.ori = R_cur * 0.5 * [R_e(3,2) - R_e(2,3); 
%                                R_e(1,3) - R_e(3,1);
%                                R_e(2,1) - R_e(1,2)];
                 
    ct = 0.5 * (R_e(1,1) + R_e(2,2) + R_e(3,3) - 1);
    if ct >= 1.0
        error.th = 0.0;
    elseif ct <= -1.0
        error.th = deg2rad(180);
    else
        error.th = acos(ct);
    end
    
    error.e = [error.pos' error.ori']';

end