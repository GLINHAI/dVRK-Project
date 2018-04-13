%forward Kinematics
function T = FKine(psm, q)

T = repmat(zeros(4), 1, 1, psm.DOF + 1);
temp = eye(4);
lk = psm.link;

for i = 1:psm.DOF
    
    if 1 == lk(i).type
        temp = temp * SetFrame([lk(i).a, lk(i).alpha,...
                                lk(i).d, lk(i).theta + q(i)]);
    elseif 2 == lk(i).type
        temp = temp * SetFrame([lk(i).a, lk(i).alpha,...
                                lk(i).d + q(i), lk(i).theta]);
    end
    
    T(:,:,i) = temp;
end

T(:,:,psm.DOF + 1) = temp * SetFrame(psm.tip);

end
    