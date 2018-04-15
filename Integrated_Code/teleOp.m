classdef teleOp < handle
  properties(Access = public)

    isStarted = false;
    psm_js_publisher;
    jointStateMsg;
    dt = 0.001;
    

  end

    methods(Access = public)

        function obj = teleOp(mtm_q_initial,psm_q_initial,psm_js_publisher,jointStateMsg)

            if (nargin > 3)
                obj.psm_js_publisher = psm_js_publisher;
                obj.jointStateMsg = jointStateMsg;
            end
            
            global mtm psm;
            global mtm_q_pre psm_q_pre; 
%             global dt;
            dt = 0.001;
            mtm_q_pre = mtm_q_initial;
            psm_q_pre = psm_q_initial;
            mtm = MtmArmModel();
            psm = PsmArmModel();

        end

        
        function  [psm_q,tracking_err] = run(obj, mtm_q)

            global mtm psm;
            global mtm_q_pre psm_q_pre; 
%             global dt;
            
            [psm_x_dsr, psm_xdot_dsr] = DsrCompute(mtm, mtm_q_pre, mtm_q);
            psm_q = InvControl(psm_q_pre, psm_x_dsr, psm_xdot_dsr, psm);
            
            psm_q_pre = psm_q;
            mtm_q_pre = mtm_q;
        end

        function  callback_update_mtm_q(obj, q)
            obj.jointStateMsg.Position = obj.run(q);
            tElapsed = toc(obj.tStart);
            if (tElapsed > 0.033)
                obj.tStart = tic;
                obj.psm_js_publisher.send(obj.jointStateMsg);
            end
        end

    end
end
