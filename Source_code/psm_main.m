
clear;
clc;

%% the configuration of PSM

syms t1 t2 t3 d4;
DOF = 4;

psm_config = [% type    a    alpha    d    theta
                 'r'    0    -pi/2    0       t1;...
                 'r'  0.2        0    0       t2;...
                 'r'  0.5        0    0       t3;...
                 'p'    0        0   d4        0];
          

tip = [0.2 0 0 0];
%% forward kinematics

T = FKine(psm_config, DOF, tip);
jac_sym = JacCompute(T, DOF, psm_config);


for i = 1:DOF + 1
    trans = T(:,:,i);
    P = trans(1:3, 4);
    x(i) = P(1,1);
    y(i) = P(2,1);
    z(i) = P(3,1);
end

t1 = 0.5*pi;
t2 = 0.5*pi;
t3 = 0.25*pi;
d4 = 1.0;

X = eval(x);
Y = eval(y);
Z = eval(z);

plot3(X, Y, Z, '-o', 'LineWidth', 2);
grid on;