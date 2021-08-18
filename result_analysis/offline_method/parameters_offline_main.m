clear all
close all
restoredefaultpath

addpath('Utility');
addpath('results');
addpath('export_fig-master');

%% add path
addpath('UKF');
addpath('Utility');
addpath('Closed_form');
addpath('pathmexmaci64');
addpath('export_fig-master');

%% set the inertia parameters and noise
% 'wooden' 'steel' 'plastic' 'acrylic'
Object = 'plastic';
FW_Settings = Setting(Object);

i_begin = 1;
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

    FW_CL_para{:,:,i} = compute_parameters_offline(FW_Settings,D415_T,D415_q_x,D415_q_y,D415_theta);
    
    %save data
    %save(strcat('D415_Data_',data_index),'D415_Data');
end