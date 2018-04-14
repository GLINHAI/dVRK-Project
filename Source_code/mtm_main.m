
clear;
clc;
load('dvrk_mtm_psm.mat');



mtm = MtmArmModel();

for i=1:60
    T = FKine(mtm, mtm_q(:,i));
end




