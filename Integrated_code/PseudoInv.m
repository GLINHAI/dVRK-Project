% pseudo inverse computation
function J_pinv = PseudoInv(jac)

    [U,S,V] = svd(jac);
    for i = 1:min(size(jac, 1), size(jac, 2))
        if S(i,i) ~= 0
            S(i,i) = 1 / S(i,i);    
        end
    end
    J_pinv = V * S' * U';

end