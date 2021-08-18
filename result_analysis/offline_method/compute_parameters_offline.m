function FW_CL_para = compute_parameters_offline(FW_Settings,D415_T,D415_q_x,D415_q_y,D415_theta)
%% preprocess and denoise raw data
flag = 0;
D415_Data = preprocess(D415_T,D415_q_x,D415_q_y,D415_theta);
%N_1 start point, N_2 end point
N_1 = 1;
N_2 = length(D415_Data.T);

FW_Settings.Estimation_window = [N_1 N_2]; % position of initial estimation window
FW_Settings.N_1 = N_1;
FW_Settings.N_2 = N_2;
    
[D415_q_f_est, D415_v_f_est, D415_Data] = smooth(FW_Settings, D415_Data,flag);

%%  closed_form


FW_CL_para = Closed_form_main(FW_Settings, D415_Data.T, D415_q_f_est, D415_v_f_est);

  


end