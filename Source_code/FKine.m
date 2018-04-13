%forward Kinematics
function T = FKine(psm_config, DOF, tip)

T = repmat(sym(zeros(4)), 1, 1, DOF + 1);
temp = eye(4);

for i = 1:1:DOF
    temp = temp * SetFrame(psm_config(i, 2:5));
    T(:,:,i) = temp;
end

T(:,:,DOF + 1) = temp * SetFrame(tip);

end
    