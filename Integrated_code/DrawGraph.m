function DrawGraph(psm, psm_q)
%     subplot(1,2,1)
    % plot PSM
    T_psm = FKine(psm, psm_q);
    R = T_psm(1:3,1:3,end);
    T = T_psm(1:3,4,end);
    trans_homo = rt2tr(R, T);
    psm_base = eye(4);
    psm_x = T(1);
    psm_y = T(2);
    psm_z = T(3);
    
    title(sprintf('The position: x:%.4f, y:%.4f, z:%.4f', psm_x, psm_y, psm_z));
    link = plot3([psm_base(1,4), T(1)],...
                 [psm_base(2,4), T(2)],...
                 [psm_base(3,4), T(3)], 'Color', 'k',...
                                        'LineWidth', 2);
    hold on;
    patch([-0.5,0.5,0.5,-0.5],...
          [0.5,0.5,-0.5,-0.5],...
          [0,0,0,0],...
          [0.859,0.859,0.859]);
    hold on;
    base_plot = trplot(psm_base,'length',1,'arrow','width', 1.5,'thick',2,'rgb');
    hold on;
    plot_end = trplot(trans_homo, 'length', 1,...
                                  'arrow',...
                                  'width', 1.5,...
                                  'thick', 2,...
                                  'rgb');
%     
    delete(plot_end);
    delete(base_plot);
    delete(link);
    grid on;
    axis([-3 3 -3 3 -3 3]);
    pause(0.001);
%     subplot(1,2,2)
%     % plot MTM
%     [R_mtm,t_mtm] = tr2rt(T_mtm);
%     T_m = rt2tr(R_mtm,t_mtm);
%     T_origin=eye(4,4);
%     x_e = t_mtm(1,1); y_e = t_mtm(2,1); z_e = t_mtm(3,1);
%     title(sprintf('The position: x:%.4f, y:%.4f, z:%.4f',x_e,y_e,z_e));
%     link = plot3([T_origin(1,4),t_mtm(1,1)],[T_origin(2,4),t_mtm(2,1)],[T_origin(3,4),t_mtm(3,1)],'k','LineWidth',2);
%     hold on;
%     patch([-0.5,0.5,0.5,-0.5],[0.5,0.5,-0.5,-0.5],[0,0,0,0],[0.859,0.859,0.859]);
%     hold on;
%     trplot(T_origin,'length',1,'arrow','width', 1.5,'thick',2,'rgb');
%     hold on;
%     plot_end = trplot(T_m,'length',1,'arrow','width', 1.5,'thick',2,'rgb');
%     
%     delete(plot_end);
%     delete(link);
%     grid on;
%     axis([-3 3 -3 3 -3 3]);
%     
%     
end

function  [R,t] = tr2rt(T)
    t = T(1:3,4);
    R = T(1:3,1:3);
end


