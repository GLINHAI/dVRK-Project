function InvControl(psm_q_initial, psm_x_dsr, psm_xdot_dsr, psm)

    for i = 1:length(psm_q_initial)
        q(i) = psm_q_initial(i);
    end
    
    