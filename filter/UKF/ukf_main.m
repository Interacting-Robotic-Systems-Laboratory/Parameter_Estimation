function [UKF_para, UKF_para_std, Para_chosen, Para_chosen_std,UKF_q,UKF_q_std,P] = ukf_main(S, T, q_f_est, v_f_est)
%% load data
% we assume the process noise to be the initial noise of the state 
P = S.P; Q = S.Q; R = S.R;
N_1 = S.Estimation_window(1);
N_2 = S.Estimation_window(2);
q_i = q_f_est(:,N_1+1);
v_i = v_f_est(:,N_1+1);

UKF_para = NaN(3,length(T));
UKF_para_std = NaN(3,length(T));
UKF_q = NaN(3,length(T));
UKF_q_std = NaN(3,length(T));
%UKF_Q_std = NaN(3,N_2 - N_1 + 1);


%% Parameter estimation

x = [q_i;v_i;S.para_ini]; 
u = zeros(6,1);

for i = N_1+2:N_2
    
    try
    S.h = T(i+1)-T(i);
    
    [x,P]=ukf(S,x,q_f_est(:,i),u,P,Q,R); 
    
    UKF_para(:,i) = x(7:9);
    UKF_para_std(:,i) = [sqrt(P(7,7)),sqrt(P(8,8)),sqrt(P(9,9))];
    UKF_q(:,i) = x(1:3);
    UKF_q_std(:,i) = [sqrt(P(1,1)),sqrt(P(2,2)),sqrt(P(3,3))];
    catch
        disp('error in UKF');
    end

end


%% compute the parameters

[Para_chosen, Para_chosen_std] = para_estimation(UKF_para, UKF_para_std);

end


