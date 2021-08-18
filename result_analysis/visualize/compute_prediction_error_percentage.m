function [SW_UKF_Err_p, SW_CL_Err_p, FW_UKF_Err_p, FW_CL_Err_p, GP_Err_p] = compute_prediction_error_percentage(Prdiction_window,N_1,N_2,Data)

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


N = size(FW_UKF_q_p, 3);
for i = 1:N
    N_prediction = min(N_2 - N_1 + Prdiction_window + i, size(T,2));
    SW_UKF_Err_p(:,i) = 100*abs(SW_UKF_q_p(:,N_prediction,i) - q(:,N_prediction))./abs(q(:,N_prediction) - q(:,N_prediction-Prdiction_window));
    SW_CL_Err_p(:,i) =  100*abs(SW_CL_q_p(:,N_prediction,i) - q(:,N_prediction))./abs(q(:,N_prediction) - q(:,N_prediction-Prdiction_window));
    
    FW_UKF_Err_p(:,i) = 100*abs(FW_UKF_q_p(:,N_prediction,i) - q(:,N_prediction))./abs(q(:,N_prediction) - q(:,N_prediction-Prdiction_window));
    FW_CL_Err_p(:,i) =  100*abs(FW_CL_q_p(:,N_prediction,i) - q(:,N_prediction))./abs(q(:,N_prediction) - q(:,N_prediction-Prdiction_window));
    
    GP_Err_p(:,i) = 100*abs(GP_q_p(:,N_prediction,i) - q(:,N_prediction))./abs(q(:,N_prediction) - q(:,N_prediction-Prdiction_window));
end
end