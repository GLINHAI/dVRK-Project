
clear;
clc;
load('dvrk_mtm_psm.mat');
dt=0.001;

mtm = MtmArmModel();
mtm_q_initial =deg2rad([0 0 0 -42.299 90 0 137.701])';
Trans_Mat=psm_x_dsr(:,:,1)*inv(mtm_x(:,:,1));
for i=1:60
    T = FKine(mtm, mtm_q(:,i));
    psm_x_dsr(:,:,i)=Trans_Mat*T(:,:,mtm.DOF+1);
end

for i=2:10
    psm_xn(:,:,i-1)=(psm_x_dsr(:,:,i)-psm_x_dsr(:,:,i-1))/dt;
    wn=psm_xn(1:3,1:3,i-1)*inv(psm_x_dsr(1:3,1:3,i-1));
    w(:,i-1)=[-wn(2,3);wn(1,3);-wn(1,2);];
    psm_xdot(:,i-1)=[psm_xn(1:3,4,i-1);w(:,i-1);];
end










