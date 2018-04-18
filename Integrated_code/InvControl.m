function [psm_q, tracking_error] = InvControl(psm_q_pre, psm_x_dsr, psm_xdot_dsr, psm)

    for i = 1:length(psm_q_pre)
        q(i) = psm_q_pre(i);
    end
    
    delta_t = 0.001;
    K = (1/delta_t)*diag([1, 1, 1, 1, 1, 1]);
    
    while 1 == 1
        pose_cur = FKine(psm, q);
        pose = pose_cur(:,:,end);        
        error = Err(psm_x_dsr, pose); 

        jac = JacCompute(pose_cur, psm);
        jpinv = PseudoInv(jac);
            
        q_dot = jpinv * (psm_xdot_dsr + K * error.e);
        q_cur = q' + q_dot * delta_t;
        tracking_error = [error.dis; error.th];
        if error.dis <= 0.01 && error.th <= 0.01
            break;
        end       
      
        for j = 1:length(q)
            q(j) = q_cur(j);
        end        
    end
    psm_q = q_cur;
end

