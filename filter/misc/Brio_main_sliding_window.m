clear all
close all

%% add path
addpath('UKF');
addpath('Utility');
addpath('Closed_form');
addpath('pathmexmaci64');
addpath('export_fig-master');

%% set the inertia parameters and noise
% 'wooden' 'steel' 'plastic' 'acrylic'
Object = 'wooden';
S = Setting(Object);
N_1 = 1;
N_2 = 10;
S.Estimation_window = [N_1 N_2]; % position of initial estimation window
S.Prdiction_window = 10;

%% load the data
data_index = '61';
data_name = strcat('Brio_solution_',data_index,'.mat');
load(data_name);
T = Solution_Brio.Timestamp;
q_x = Solution_Brio.q_x;
q_y = Solution_Brio.q_y;
theta = Solution_Brio.theta;

%% preprocess and denoise raw data
flag = 1;
Data = preprocess(T,q_x,q_y,theta);
[q_f_est, v_f_est, Data] = smooth(S, Data,flag);

%%  UKF filters and closed_form
N = length(Data.T) - N_2 - S.Prdiction_window + 1;
flag = 2;
for i = 1:N
    S.Estimation_window = [N_1+i-1, N_2+i-1];
    
    if i >= 2
%         S.P(7,7) = Data.UKF_para_chosen_std(1,i-1)^2;
%         S.P(8,8) = Data.UKF_para_chosen_std(2,i-1)^2;
%         S.P(9,9) = Data.UKF_para_chosen_std(3,i-1)^2;
        S.para_ini = Data.UKF_para_chosen(:,i-1);
        [q_f_est, v_f_est, Data] = smooth(S, Data, flag);
    end
    [Data.UKF_para(:,:,i), Data.UKF_para_std(:,:,i),...
         Data.UKF_Q_p(:,:,i), Data.UKF_para_chosen(:,i), Data.UKF_para_chosen_std(:,i)] = ukf_main(S, Data.T, q_f_est, v_f_est);
    [Data.CL_Q_p(:,:,i), Data.CL_para(:,:,i), ...
        Data.CL_para_chosen(:,i)] = Closed_form_main(S,Data.T, q_f_est, v_f_est);
    
end


%% plot result
%plot_smoothed_data(Data);
filename1 = strcat('Brio_q_x_sliding_window_',data_index,'.gif'); 
filename2 = strcat('Brio_q_y_sliding_window_',data_index,'.gif');
filename3 = strcat('Brio_theta_sliding_window_',data_index,'.gif');
for i = 1:N
    N_1_p = i;
    N_2_p = N_2 + i - 1;
    %
    h1 = plot_trajectory(S,N_1_p,N_2_p,i,Data,1);
    h2 = plot_trajectory(S,N_1_p,N_2_p,i,Data,2);
    h3 = plot_trajectory(S,N_1_p,N_2_p,i,Data,3);
    % Capture the plot as an image 
    frame1 = getframe(h1); 
    im1 = frame2im(frame1); 
    [imind1,cm1] = rgb2ind(im1,256); 
    
    frame2 = getframe(h2); 
    im2 = frame2im(frame2); 
    [imind2,cm2] = rgb2ind(im2,256); 
    
    frame3 = getframe(h3); 
    im3 = frame2im(frame3); 
    [imind3,cm3] = rgb2ind(im3,256); 
    % Write to the GIF File 
    if i == 1 
      imwrite(imind1,cm1,filename1,'gif', 'Loopcount',inf); 
      imwrite(imind2,cm2,filename2,'gif', 'Loopcount',inf); 
      imwrite(imind3,cm3,filename3,'gif', 'Loopcount',inf); 
    else 
      imwrite(imind1,cm1,filename1,'gif','WriteMode','append'); 
      imwrite(imind2,cm2,filename2,'gif','WriteMode','append'); 
      imwrite(imind3,cm3,filename3,'gif','WriteMode','append'); 
    end 
    close all  
end

