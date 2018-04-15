
clear;
clc;

load('dvrk_mtm_psm.mat');

psm = PsmArmModel();
InvControl(psm_q_initial, psm_x_dsr, psm_xdot_dsr, psm);


          




