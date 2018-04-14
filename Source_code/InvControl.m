function InvControl(psm_q_initial, psm_x_dsr, psm_xdot_dsr, psm)

    K = 500*diag([1, 1, 1, 1, 1, 1]);
    delta_t = 0.001;
    k = 0;

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
            k = k + 1;
            dise(k) = error.dis;
            orie(k) = error.th;
            
            if error.dis <= 0.01 && error.th <= 0.01
                flag = true;
                PSM_graphical(R_cur, T_cur, i);
%                 graphical2(R_cur, T_cur);
                pause(0.001);
%                 x = R_cur(:,1);
%                 y = R_cur(:,2);
%                 z = R_cur(:,3);
%                 plot3([T_cur(1), T_cur(1) + x(1)],...
%                       [T_cur(2), T_cur(2) + x(2)],...
%                       [T_cur(3), T_cur(3) + x(3)],...
%                       ...
%                       [T_cur(1), T_cur(1) + y(1)],...
%                       [T_cur(2), T_cur(2) + y(2)],...
%                       [T_cur(3), T_cur(3) + y(3)],...
%                       ...
%                       [T_cur(1), T_cur(1) + z(1)],...
%                       [T_cur(2), T_cur(2) + z(2)],...
%                       [T_cur(3), T_cur(3) + z(3)]);
%                   grid on;
%                   axis ([-1 2 -1 2 -1 2]);                  
%                   pause(0.01);
                
%                 quiver3(T_cur(1), T_cur(2), T_cur(3), x(1), x(2), x(3));
            end
            
            for j = 1:length(q)
                q(j) = q_cur(j);
            end            
%             pause(0.1);
        end
    end
%     k = 1:k;
%     figure(1)
%     plot(k, dise, 'LineWidth', 1.5);
%     axis([-20 2000 -0.015 0.015]);
%     figure(2);
%     plot(k, orie, 'LineWidth', 1.5);
%     axis([-20 2000 -0.015 0.015]);
end