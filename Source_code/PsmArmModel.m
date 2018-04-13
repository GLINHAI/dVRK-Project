function psm = PsmArmModel()

    % l_P2Y: l_Pitch2Yaw
    % l_Y2CP: l_Yaw2CtrlPnt
    % 1: revolute joint
    % 2: prismatic joint

    l_RCC = 0.4318;
    l_tool = 0.4162;
    l_P2Y = 0.0091;
    l_Y2CP = 0.0102;
    be = deg2rad(90);
    

    psm.DH = [% type      a      alpha      d      theta
                   1      0          0      0          0];
               
    psm.DOF = size(psm.DH,1);
    
    for i = 1:psm.DOF
        psm.link(i).type = psm.DH(i,1);
        psm.link(i).a = psm.DH(i,2);
        psm.link(i).alpha = psm.DH(i,3);
        psm.link(i).d = psm.DH(i,4);
        psm.link(i).theta = psm.DH(i,5);
    end
    psm.tip = [];
    
end
