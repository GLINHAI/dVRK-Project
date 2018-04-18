function InvControl(psm_q_initial, psm_x_dsr, psm_xdot_dsr, psm)
    
    delta_t = 0.001;
    K = 1/delta_t * diag([1, 1, 1, 1, 1, 1]);
    k = 0;
    t = 0;
    period = [];

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
%             [T_cur T_dsr]
            error = Err(T_cur, T_dsr, R_cur, R_dsr);
                        
            jac = JacCompute(pose_cur, psm);
            jpinv = PseudoInv(jac);  
            
            q_dot = jpinv * (psm_xdot_dsr(:,i) + K * error.e);
            q_cur = q' + q_dot * delta_t;
            
            t = t + delta_t;
            k = k + 1;
            period = [period t];
            dise(k) = error.dis;
            orie(k) = error.th;
            
            if error.dis <= 0.01 && error.th <= 0.01
                flag = true;
            end
            
            for j = 1:length(q)
                q(j) = q_cur(j);
            end            
            
        end
    end
    
    subplot(2,1,1);
    plot(period, dise, 'LineWidth', 1.5);
    title('distance error vs. time');
    xlabel('time(s)');
    ylabel('distance error');
    axis([0 2.5 0 0.015]);
    grid on;
    
    subplot(2,1,2);
    plot(period, orie, 'LineWidth', 1.5);
    title('orientation error vs. time');
    xlabel('time(s)');
    ylabel('orientation error');
    axis([0 2.5 0 0.13]);
    grid on;
end