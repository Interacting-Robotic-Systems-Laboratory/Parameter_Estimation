function Q_p = predict_trajectory(S,T,q_f_est,v_f_est,Para_chosen)
N_2 = S.Estimation_window(2);
u = zeros(6,1);
N_steps = 1; % number of substeps in prediction

N_end = length(T);
Q_p = NaN(3,length(T));

%% prediction

for i = N_2+1:N_end
    try
        S.h = T(i)-T(i-1);

        if i == N_2+1
            v = v_f_est(:,N_2);
            q = q_f_est(:,N_2);
        else
            v = v_p;
            q = q_p;
        end

        [q_p,v_p] = particle_prediction(S,q,v,Para_chosen,u,N_steps);

        Q_p(:,i) = q_p;
    catch
        
    end
   
end



end