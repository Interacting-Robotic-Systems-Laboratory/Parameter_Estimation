clear all
close all
restoredefaultpath
%% add path
addpath('UKF');
addpath('Utility');
addpath('LAE');
addpath('pathmexmaci64');
%addpath('export_fig-master');

%% set the inertia parameters and noise
% 'wooden' 'steel' 'plastic' 'acrylic'
Object = 'wooden';
SW_Settings = Setting(Object);
FW_Settings = Setting(Object);
N_1 = 1;
N_2 = 5;
Prdiction_window = 20;
estimation_size = N_2 - N_1+1;
SW_Settings.N_1 = N_1;
SW_Settings.N_2 = N_2;
SW_Settings.Estimation_window = [N_1 N_2]; % position of initial estimation window
SW_Settings.Prdiction_window = Prdiction_window;

FW_Settings.Estimation_window = [N_1 N_2]; % position of initial estimation window
FW_Settings.Prdiction_window = Prdiction_window;
FW_Settings.N_1 = N_1;
FW_Settings.N_2 = N_2;
i_begin = 34;
i_end = 60;

%% compute parameters
for i = i_begin:i_end
    %load the data
    data_index = num2str(i);
    D415_solution_name = strcat('D415_solution_',data_index,'.mat');

    load(D415_solution_name);

    D415_T = Solution_D415.Timestamp;
    D415_q_x = Solution_D415.q_x;
    D415_q_y = Solution_D415.q_y;
    D415_theta = Solution_D415.theta;
    

    [D415_Data,D415_N] = compute_parameters_main(SW_Settings,FW_Settings,D415_T,D415_q_x,D415_q_y,D415_theta);
    
    
    %save data
    save(strcat('D415_Data_',data_index),'D415_Data');
end

%% model prediction
for i = i_begin:i_end
    %load the data
    data_index = num2str(i);
    D415_data_name = strcat('D415_Data_',data_index,'.mat');

    load(D415_data_name);
   
    D415_Data =  predict_trajectory_main(SW_Settings, FW_Settings, D415_Data);
    %save data
    save(strcat('D415_Data_',data_index),'D415_Data');
end

%% compute errors

for i = i_begin:i_end
    %load the data
    data_index = num2str(i);
    D415_data_name = strcat('D415_Data_',data_index,'.mat');

    load(D415_data_name);
   
    [ D415_Data.SW_CL_Err, D415_Data.FW_UKF_Err] = compute_prediction_error(Prdiction_window,N_1,N_2,D415_Data);
    %save data
    save(strcat('D415_Data_',data_index),'D415_Data');
end



