function [X,X_var]= PF(S,state,z,u)
S_t = [];
N_p = S.N_Particle;
%P - initial noise, Q -process noise, R - measurement noise
Q = S.Q; R = S.R;
sigma_q = [Q(1,1),Q(2,2),Q(3,3)];
sigma_v = [Q(4,4),Q(5,5),Q(6,6)];
sigma_para = [Q(7,7),Q(8,8),Q(9,9)];
sigma_measure = [R(1,1),R(2,2),R(3,3)];
eta = 0;
% prediction
i = 1;

while i<=N_p
    q = state(1:3,i);
    v = state(4:6,i);
    para =  state(7:9,i);
    [q_p,v_p] = particle_prediction(S,q,v,para,u,1);
    noise = mvnrnd(zeros(3,1),sigma_q,1);
    q_hat = q_p+noise';
    noise = mvnrnd(zeros(3,1),sigma_v,1);
    v_hat = v_p+noise';
   
    noise = mvnrnd(zeros(3,1),sigma_para,1);
    beta_hat = StateTransPara(S,v_hat,v,u)+noise';
    if (isreal(beta_hat(1)))&&(isreal(beta_hat(2)))&&(isreal(beta_hat(3)))
        
        w_hat= mvnpdf(z',q_hat',sigma_measure);
        i = i+1;
        S_i = [q_hat;v_hat;beta_hat;w_hat];
        S_t = [S_t,S_i];
        eta = eta+w_hat;
    else
        disp('error in PF');
    end
    
    
end

% resampling
L = S_t(10,:);
Q = L / sum(L, 2);
R = cumsum(Q, 2);

% Generating Random Numbers

T = rand(1, N_p);

% Resampling

[~, I] = histc(T, R);
X= S_t(1:9, I + 1);

X_var = X*X'/(N_p-1);
end