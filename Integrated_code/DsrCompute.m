function [psm_x_dsr, psm_xdot_dsr] = DsrCompute(mtm, mtm_q_pre, mtm_q)
    
    Trans_Mat = [-1.0000    0.0000         0   -0.0001;
                  0.0000   -1.0000    0.0000   -0.3639;
                       0    0.0000    1.0000   -0.0359;
                       0         0         0    1.0000];
    R = diag([-1, -1, 1]);
%     R = eye(3);
                   
    T_mtm = FKine(mtm, mtm_q);
    T_mtm_pre = FKine(mtm, mtm_q_pre);
    error = Err(T_mtm(:,:,end), T_mtm_pre(:,:,end));
    
    psm_x_dsr = Trans_Mat * T_mtm(:,:,end);
    psm_xdot_dsr = [R * error.e(1:3);
                    R * error.e(4:6)];
                
end
    
    
    