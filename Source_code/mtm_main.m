
clear;
clc;
load('dvrk_mtm_psm.mat');
%% the configuration of PSM

syms s1 s2 s3 s4 s5 s6 s7;
DOF = 7;

mtm_config = [% type    a        alpha  d    theta
                 'r'    0        0      0       s1-pi/2;...
                 'r'    0        pi/2   0       s2-pi/2;...
                 'r'    0.2794    0      0       s3+pi/2;...
                 'r'    0.3048+0.0597    -pi/2  0.1506   s4;
                 'r'    0        pi/2   0       s5
                 'r'    0        -pi/2  0       s6-pi/2;
                 'r'    0        pi/2   0       s7;];
tip=[0 0 0 pi/2];
          
%% forward kinematics

T = FKine(mtm_config, DOF, tip);

for i=1:2000
    Tn(:,:,i)=double(subs(T(:,:,DOF+1),[s1,s2,s3,s4,s5,s6,s7],[mtm_q(1,i),mtm_q(2,i),mtm_q(3,i),mtm_q(4,i),mtm_q(5,i),mtm_q(6,i),mtm_q(7,i)]));
%     Tn(:,:,i)=Tn(:,:,i)*B
end




