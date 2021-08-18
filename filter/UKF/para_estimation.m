function [Para_chosen, Para_chosen_std] = para_estimation( UKF_para, UKF_para_std)

Alpha = UKF_para(1,:);
Beta = UKF_para(2,:);
Gamma = UKF_para(3,:);

Alpha_std = UKF_para_std(1,:);
Beta_std = UKF_para_std(2,:);
Gamma_std = UKF_para_std(3,:);


%% pick the alpha, beta, gamma. 
J1 = find(Alpha_std <= median(Alpha_std,'omitnan')); % pick the alphas that is smaller than median
alpha = Alpha(J1(end)); % find the latest alpha in the subset
alpha_std = Alpha_std(J1(end));
J2 = find(Beta_std <= median(Beta_std,'omitnan'));
beta = Beta(J2(end));
beta_std = Beta_std(J1(end));
J3 = find(Gamma_std <= median(Gamma_std,'omitnan'));
gamma = Gamma(J3(end));
gamma_std = Gamma_std(J1(end));
Para_chosen = [alpha;beta;gamma];
Para_chosen_std = [alpha_std;beta_std;gamma_std;];


end