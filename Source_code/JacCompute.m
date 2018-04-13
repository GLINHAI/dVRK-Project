function jac = JacCompute(T, DOF, config)


jac = sym(zeros(6, DOF));
for i = 1:DOF
    dis_vec = T(1:3, 4, end) - T(1:3, 4, i);
    jac(1:3, i) = cross(T(1:3, 3, i), dis_vec);

    if 'r' == config(i, 1)
        thou = 1;
    elseif 'p' == config(i, 1)
        thou = 0;
    else
        fprintf('Incorrect Link Type!!');
    end
    
    jac(4:6, i) = T(1:3, 3, i) * thou;
end

end