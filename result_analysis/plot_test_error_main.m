clear all
close all
restoredefaultpath

addpath('offline_utility');
addpath('Utility');
addpath('visualize');
addpath('results_new');
addpath('export_fig-master');

%% plot train and test errors
load('WB_Err_offline.mat');
load('ST_Err_offline.mat');
load('PL_Err_offline.mat');

load('result_WB.mat');
load('result_ST.mat');
load('result_PL.mat');

h1 = plot_Error_test(WB_error, ST_error, PL_error, WB_Err_offline, ST_Err_offline, PL_Err_offline);

export_fig offline_error.png -m3.5 -transparent