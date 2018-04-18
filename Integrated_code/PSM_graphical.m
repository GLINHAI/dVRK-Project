function PSM_graphical(psm_q)

    % forward kinematics
    psm = PsmArmModel();
    T_psm = FKine(psm, psm_q);
    rot = T_psm(1:3, 1:3, end);
    trans = T_psm(1:3, 4, end);
    
    persistent psm_group;
    frame_length = 0.1;
    frame_width = 1;
    range = 0.3;
    foundFig = findobj('Tag', 'PSM_Fast_Plot');
    patch_scale = 0.05;
    
    if isempty(foundFig)
        fig = figure('Color', 'white');
        clf(fig);
        set(fig, 'Name', 'PSM');
        set(fig, 'DoubleBuffer', 'on', 'Tag', 'PSM_Fast_Plot');
        set(fig, 'Renderer', 'painters');
        view([130 5]);
        hold('on');
        hax = get(fig, 'CurrentAxes');
%         set(hax, 'DrawMode', 'fast');
        grid on;
        axis_length = [-1 1 -1 1 -1 1];
        axis(range * axis_length);

        
        %First Plot
        T = rt2tr(rot, trans);
        T_origin = eye(4);
%         title(sprintf('The position: x:%.4f, y:%.4f, z:%.4f', trans(1,1), trans(2,1), trans(3,1)));
%         set(gca, 'DrawMode', 'fast');
% %         plot_link = plot3(hax, [T_origin(1,4), trans(1,1)],...
% %                                [T_origin(2,4), trans(2,1)],...
% %                                [T_origin(3,4), trans(3,1)], 'k','LineWidth',2);
%         plot_link = trplot(T_origin, hax);
%         plot_patch = patch(hax, patch_length*[-1,1,1,-1],...
%                                 patch_length*[1,1,-1,-1],...
%                                 [0,0,0,0],...
%                                 0.15*[0.859,0.859,0.859]);
%         plot_base = trplot(T_origin,hax,'length',frame_length,'arrow','width', frame_width,'thick',frame_thick,'rgb');
%         plot_tip = trplot(T,hax,'length',frame_length,'arrow','width', frame_width,'thick',frame_thick,'rgb');
%         chain = hggroup;
%         set(plot_link, 'Parent', chain);
%         set(plot_tip, 'Parent', chain);
    else
        hax = get(foundFig, 'CurrentAxes');   
    end
    
  if ~isempty(psm_group)
    delete(psm_group);
  end

    T = rt2tr(rot,trans);
    T_origin=eye(4,4);
    
    plot_link = plot3(hax, [T_origin(1,4), trans(1,1)],...
                           [T_origin(2,4), trans(2,1)],...
                           [T_origin(3,4), trans(3,1)], 'k', 'LineWidth', 1.5);
    plot_patch = patch(hax, patch_scale * [-1, 1, 1, -1],...
                            patch_scale * [1, 1, -1, -1],...
                            patch_scale * [0, 0, 0, 0],...
                            200);
    plot_base = trplot(T_origin, hax, 'length', frame_length,...
                                      'arrow',...
                                      'width', 1.5,...
                                      'thick', 2,...
                                      'rgb');
    plot_tip = trplot(T, hax, 'length', frame_length,...
                              'arrow',...
                              'width', frame_width,...
                              'rgb');
                          
    psm_group = hggroup;
    set(plot_link, 'Parent', psm_group);
    set(plot_patch, 'Parent', psm_group);
    set(plot_base, 'Parent', psm_group);
    set(plot_tip, 'Parent', psm_group);
    title(sprintf('The position: x:%.4f, y:%.4f, z:%.4f', trans(1,1), trans(2,1), trans(3,1)));
    drawnow;
end



