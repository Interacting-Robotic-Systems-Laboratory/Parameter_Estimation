function Data = PF_main(S,Data)
T = Data.T;
%P - initial noise, Q -process noise, R - measurement noise
P = S.P;
z = Data.z;
q = Data.UKF_q_i;
v = Data.UKF_v_i;
u = zeros(6,1);
N_p = S.N_Particle;
para_ini = S.para_ini;
N_end = Data.N_end;
%% particle filter
Data = initial_belief(q,v,para_ini,Data,N_p,P);
N = S.Window;

for i = 1:N
    if i == 1
        state = Data.PF_State_i;
    else
        state = Data.PF_State{i-1};
    end
    S.h = T(i+1)-T(i);
    [X,X_var]= PF(S,state,z(:,i),u);  
    Data.PF_State{i} = X;
    Data.PF_variance{i} = X_var;
    [Out,~,~] = unique(X', 'rows', 'stable');
    O = Out(1,:);
    Data.PF_para(:,i) = O(7:9);
    Data.PF_para_std(:,i) = [sqrt(X_var(7,7)),sqrt(X_var(8,8)),sqrt(X_var(9,9))];
    Data.PF_Q_std(:,i) = [sqrt(X_var(1,1)),sqrt(X_var(2,2)),sqrt(X_var(3,3))];
end


v_o = O(4:6);
Para = O(7:9);
for i = N+1:N_end
    S.h = T(i+1)-T(i);
    
    if i == N+1
        v = v_o;
        q = z(:,N);
    else
        v = v_p;
        q = q_p;
    end
    
    [q_p,v_p] = particle_prediction(S,q,v,Para,u,1);
    Data.PF_Q_p(:,i) = q_p;
end

end