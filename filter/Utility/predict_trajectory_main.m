function  D415_Data =  predict_trajectory_main(SW_Settings, FW_Settings, D415_Data)
N_1 = SW_Settings.N_1;
N_2 = SW_Settings.N_2;

%% prediction
D415_N = length(D415_Data.T) - N_2 - SW_Settings.Prdiction_window + 1;
flag = 2;


for i = 1:D415_N

    FW_Settings.Estimation_window = [N_1, N_2+i-1];
    SW_Settings.Estimation_window = [N_1+i-1, N_2+i-1];

    [D415_q_f_est, D415_v_f_est, D415_Data] = smooth(FW_Settings, D415_Data, flag);

    
    % fixed window
    %D415_Data.FW_UKF_Q_p(:,:,i) = predict_trajectory(FW_Settings, D415_Data.T , D415_q_f_est, D415_v_f_est, D415_Data.FW_UKF_para_chosen(:,i)); 
    % sliding window
    D415_Data.SW_CL_Q_p(:,:,i) = predict_trajectory(SW_Settings, D415_Data.T , D415_q_f_est, D415_v_f_est, D415_Data.SW_CL_para_chosen(:,i));   
    
end

end