function [T_err, R_err] = Err(T_cur, T_des, R_cur, R_des)

T_err = T_des - T_cur;

R_e = R_cur' * R_des;
R_er = 0.5 * [R_e(3,2) - R_e(2,3);...
              R_e(1,3) - R_e(3,1);...
              R_e(2,1) - R_e(1,2)];

R_err = R_des * R_er;

end