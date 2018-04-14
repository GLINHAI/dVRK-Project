%forward Kinematics
function T = FKine(config, q)

    T = repmat(zeros(4), 1, 1, config.DOF + 1);
    temp = eye(4);
    lk = config.link;

    for i = 1:config.DOF
    
        if 1 == lk(i).type
            temp = temp * SetFrame([lk(i).a, lk(i).alpha,...
                                    lk(i).d, lk(i).theta + q(i)]);
        elseif 2 == lk(i).type
            temp = temp * SetFrame([lk(i).a, lk(i).alpha,...
                                    lk(i).d + q(i), lk(i).theta]);
        end
    
      T(:,:,i) = temp;
    end

    T(:,:,config.DOF + 1) = temp * SetFrame(config.tip);

end
    