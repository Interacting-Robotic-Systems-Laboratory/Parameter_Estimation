function [D415_Data,D415_N] = compute_parameters_main(SW_Settings,FW_Settings,D415_T,D415_q_x,D415_q_y,D415_theta)
N_1 = SW_Settings.N_1;
N_2 = SW_Settings.N_2;

%% preprocess and denoise raw data

flag = 1;

D415_Data = preprocess(D415_T,D415_q_x,D415_q_y,D415_theta);
[D415_q_f_est, D415_v_f_est, D415_Data] = smooth(SW_Settings, D415_Data,flag);

%%  UKF filters and closed_form
D415_N = length(D415_Data.T) - N_2 - SW_Settings.Prdiction_window + 1;




flag = 2;
for i = 1:D415_N
    
    FW_Settings.Estimation_window = [N_1, N_2+i-1];
    SW_Settings.Estimation_window = [N_1+i-1, N_2+i-1];
    if i == 1
        %SW_Settings.para_ini = FW_Settings.para_ini;
    else
         %SW_Settings.para_ini = D415_Data.FW_UKF_para_chosen(:,i-1);

        [D415_q_f_est, D415_v_f_est, D415_Data] = smooth(FW_Settings, D415_Data, flag);
    end
    
    % fixed window

%     [D415_Data.FW_UKF_para(:,:,i), D415_Data.FW_UKF_para_std(:,:,i),...
%          D415_Data.FW_UKF_para_chosen(:,i),...
%          D415_Data.FW_UKF_para_chosen_std(:,i),...
%          D415_Data.UKF_q(:,:,i),D415_Data.UKF_q_std(:,:,i)] = ukf_main(FW_Settings, D415_Data.T, D415_q_f_est, D415_v_f_est);

     [D415_Data.SW_CL_para(:,:,i), ...
        D415_Data.SW_CL_para_chosen(:,i)] = Closed_form_main(SW_Settings, D415_Data.T, D415_q_f_est, D415_v_f_est);
    

end

end