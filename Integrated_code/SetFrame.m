% transfer matrix
function T = SetFrame(r_config)

    a = r_config(1);
    alpha = r_config(2);
    d = r_config(3);
    theta = r_config(4);

    sa = sin(alpha);
    ca = cos(alpha);
    st = sin(theta);
    ct = cos(theta);
  
    T_inter = [   ct   -st   0     a;...
               st*ca ct*ca -sa -sa*d;...
               st*sa ct*sa  ca  ca*d;...
                   0     0   0     1];
            
    T = T_inter;

end