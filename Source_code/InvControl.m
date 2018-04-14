function InvControl(psm_q_initial, psm_x_dsr, psm_xdot_dsr, psm)

    K = diag([1, 1, 1, 1, 1, 1]);
    delta_t = 0.001;

    for i = 1:length(psm_q_initial)
        q(i) = psm_q_initial(i);
    end
    
    for i = 1:length(psm_x_dsr)
        flag = false;
        R_dsr = psm_x_dsr(1:3,1:3,i);
        T_dsr = psm_x_dsr(1:3,4,i);
        
        while false == flag
            
            pose_cur = FKine(psm, q);
            R_cur = pose_cur(1:3,1:3,end);
            T_cur = pose_cur(1:3,4,end);            
            error = Err(T_cur, T_dsr, R_cur, R_dsr);
                        
            jac = JacCompute(pose_cur, psm);
            jpinv = PseudoInv(jac);  
            
            q_dot = jpinv * (psm_xdot_dsr + K * error.e);
            q_cur = q' + q_dot * delta_t;
            [error.dis; error.th]
            
            if error.dis <=0.01 && error.th <= 0.01
                flag = true;
            end
            
        end
    end
end