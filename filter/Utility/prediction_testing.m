function  W = prediction_testing(SW_Settings, Data, para_chosen)
N_1 = SW_Settings.N_1;
N_2 = SW_Settings.N_2;

N = length(Data.T) - N_2 - SW_Settings.Prdiction_window + 1;
if N < 1
    N = 1;
end
for k = 1:N

   % FW_Settings.Estimation_window = [N_1, N_2+k-1];
    SW_Settings.Estimation_window = [N_1+k-1, N_2+k-1];

    [q_f_est, v_f_est, Data] = smooth(SW_Settings, Data, flag);

    
    % fixed window
%     Out.FW_UKF_Q_p(:,:,k) = predict_trajectory(FW_Settings, Data.T , q_f_est, v_f_est, FW_UKF_para_chosen); 
%     Out.FW_CL_Q_p(:,:,k) = predict_trajectory(FW_Settings, Data.T , q_f_est, v_f_est, FW_CL_para_chosen);   
%     % sliding window
    Out.Q_p(:,:,k) = predict_trajectory(SW_Settings, Data.T , q_f_est, v_f_est, para_chosen);
   % Out.SW_CL_Q_p(:,:,k) = predict_trajectory(SW_Settings, Data.T , q_f_est, v_f_est, SW_CL_para_chosen);   
    
end

T = Data.T;
q = Data.q_f;
q(3,:) = (180/pi)*q(3,:);
q(1:2,:) = 1000*q(1:2,:);


% FW_UKF_q_p = Out.FW_UKF_Q_p;
% FW_UKF_q_p(1:2,:,:) = 1000*FW_UKF_q_p(1:2,:,:);
% FW_UKF_q_p(3,:,:) = (180/pi)*FW_UKF_q_p(3,:,:);

q_p = Out.Q_p;
q_p(1:2,:,:) = 1000*q_p(1:2,:,:);
q_p(3,:,:) = (180/pi)*q_p(3,:,:);

% FW_CL_q_p = Out.FW_CL_Q_p;
% FW_CL_q_p(1:2,:,:) = 1000*FW_CL_q_p(1:2,:,:);
% FW_CL_q_p(3,:,:) = (180/pi)*FW_CL_q_p(3,:,:);
% 
% SW_CL_q_p = Out.SW_CL_Q_p;
% SW_CL_q_p(1:2,:,:) = 1000*SW_CL_q_p(1:2,:,:);
% SW_CL_q_p(3,:,:) = (180/pi)*SW_CL_q_p(3,:,:);

for k = 1:20
    Prdiction_window = k;
    N1 = size(q_p, 3) - (N_1- 1);
    % number of steps with current prediction window
    N2 = size(T,2) - (N_2 - N_1 + Prdiction_window);
    N = min(N1, N2);
    if N < 1
        N = 1;
    end
    for i = 1:N
        j = min(N_2- 10 +i, size(q_p,3));
        N_prediction = min(N_2 - N_1 + Prdiction_window + i, size(T,2));
        W{k}.Err(:,i) = q_p(:,N_prediction,j) - q(:,N_prediction);
%         W{k}.SW_CL_Err(:,i) =  SW_CL_q_p(:,N_prediction,j) - q(:,N_prediction);
% 
%         W{k}.FW_UKF_Err(:,i) = FW_UKF_q_p(:,N_prediction,j) - q(:,N_prediction);
%         W{k}.FW_CL_Err(:,i) =  FW_CL_q_p(:,N_prediction,j) - q(:,N_prediction);
    end
end
end