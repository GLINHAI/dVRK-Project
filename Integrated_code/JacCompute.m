function jac = JacCompute(T, psm)

    jac = zeros(6, psm.DOF);
    for i = 1:psm.DOF
        dis_vec = T(1:3, 4, end) - T(1:3, 4, i);

        if 1 == psm.link(i).type
            thou = 1;
            jac(1:3, i) = cross(T(1:3, 3, i), dis_vec);
       elseif 2 == psm.link(i).type
            thou = 0;
            jac(1:3, i) = T(1:3, 3, i);
       else
         fprintf('Incorrect Link Type!!');
       end
    
        jac(4:6, i) = T(1:3, 3, i) * thou;
    end

end