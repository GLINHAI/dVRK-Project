function mtm = MtmArmModel()

    % 1: revolute joint
    % 2: prismatic joint

    be = deg2rad(90);
    

    mtm.DH = [% type       a        alpha       d    theta
                   1       0            0       0      -be;...
                   1       0           be       0      -be;...
                   1  0.2794            0       0       be;...
                   1  0.3645          -be  0.1506        0;...
                   1       0           be       0        0;...
                   1       0          -be       0      -be;...
                   1       0           be       0        0];
    
               
    mtm.DOF = size(mtm.DH,1);
    
    for i = 1:mtm.DOF
        mtm.link(i).type = mtm.DH(i,1);
        mtm.link(i).a = mtm.DH(i,2);
        mtm.link(i).alpha = mtm.DH(i,3);
        mtm.link(i).d = mtm.DH(i,4);
        mtm.link(i).theta = mtm.DH(i,5);
    end
    
    mtm.tip=[0 0 0 be];
    
end