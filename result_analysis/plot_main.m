
clear all
close all
%% add path
addpath('Utility');
addpath('results/wooden_block/');
addpath('export_fig-master');
%% load data
data_index = '6';
Brio_data_name = strcat('Brio_Data_',data_index,'.mat');
D415_data_name = strcat('D415_Data_',data_index,'.mat');
load(Brio_data_name);
load(D415_data_name);
N_1 = 1;
N_2 = 10;
estimation_size = N_2 - N_1 + 1;
Prdiction_window = 20;

Brio_Data.Name = strcat('Brio Data ',data_index);
D415_Data.Name = strcat('D415 Data ',data_index);
%% compute predition errors
[Brio_Data.SW_UKF_Err, Brio_Data.SW_CL_Err, Brio_Data.FW_UKF_Err,...
    Brio_Data.FW_CL_Err, Brio_Data.GP_q_p_Err] = compute_prediction_error(Prdiction_window,N_1,N_2,Brio_Data);

[D415_Data.SW_UKF_Err, D415_Data.SW_CL_Err, D415_Data.FW_UKF_Err,...
    D415_Data.FW_CL_Err, D415_Data.GP_q_p_Err] = compute_prediction_error(Prdiction_window,N_1,N_2,D415_Data);
%% plot result
plot_result_trajectory(N_1, N_2, Prdiction_window, estimation_size, Brio_Data, D415_Data, data_index);
h1 = plot_smoothed_data(Brio_Data);
h2 = plot_smoothed_data(D415_Data);

Brio_data_fig = strcat('Brio_Data_',data_index,'.fig');
D415_data_fig = strcat('D415_Data_',data_index,'.fig');

savefig(h1,Brio_data_fig);

savefig(h2,D415_data_fig);

%close all