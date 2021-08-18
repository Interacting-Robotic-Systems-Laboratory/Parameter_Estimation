function [SW_UKF_Err, SW_CL_Err, FW_UKF_Err, FW_CL_Err, GP_Err] = testing_compute_prediction_error(Prdiction_window,N_1,N_2,Data)
SW_UKF_Err = [];
SW_CL_Err = [];
FW_UKF_Err = [];
FW_CL_Err = [];
GP_Err = [];

T = Data.T;
q = Data.q_f;
q(3,:) = (180/pi)*q(3,:);
q(1:2,:) = 1000*q(1:2,:);

FW_UKF_q_p = Data.FW_UKF_Q_p;
FW_UKF_q_p(1:2,:,:) = 1000*FW_UKF_q_p(1:2,:,:);
FW_UKF_q_p(3,:,:) = (180/pi)*FW_UKF_q_p(3,:,:);

SW_UKF_q_p = Data.SW_UKF_Q_p;
SW_UKF_q_p(1:2,:,:) = 1000*SW_UKF_q_p(1:2,:,:);
SW_UKF_q_p(3,:,:) = (180/pi)*SW_UKF_q_p(3,:,:);

FW_CL_q_p = Data.FW_CL_Q_p;
FW_CL_q_p(1:2,:,:) = 1000*FW_CL_q_p(1:2,:,:);
FW_CL_q_p(3,:,:) = (180/pi)*FW_CL_q_p(3,:,:);

SW_CL_q_p = Data.SW_CL_Q_p;
SW_CL_q_p(1:2,:,:) = 1000*SW_CL_q_p(1:2,:,:);
SW_CL_q_p(3,:,:) = (180/pi)*SW_CL_q_p(3,:,:);

GP_q_p = Data.GP_Q_p;
GP_q_p(1:2,:,:) = 1000*GP_q_p(1:2,:,:);
GP_q_p(3,:,:) = (180/pi)*GP_q_p(3,:,:);

% number of current position when sliding estimation window
N1 = size(FW_UKF_q_p, 3) - (N_2- 10);
% number of steps with current prediction window
N2 = size(T,2) - (N_2 - N_1 + Prdiction_window);
N = min(N1, N2);
if N < 1
    N = 1;
end
for i = 1:N
    j = min(N_2- 10 +i, size(SW_UKF_q_p,3));
    N_prediction = min(N_2 - N_1 + Prdiction_window + i, size(T,2));
    SW_UKF_Err(:,i) = SW_UKF_q_p(:,N_prediction,j) - q(:,N_prediction);
    SW_CL_Err(:,i) =  SW_CL_q_p(:,N_prediction,j) - q(:,N_prediction);
    
    FW_UKF_Err(:,i) = FW_UKF_q_p(:,N_prediction,j) - q(:,N_prediction);
    FW_CL_Err(:,i) =  FW_CL_q_p(:,N_prediction,j) - q(:,N_prediction);
    
    GP_Err(:,i) = GP_q_p(:,N_prediction,j) - q(:,N_prediction);
end
end