clear all
close all
restoredefaultpath
%% add path
addpath('Utility');
addpath('results_new');
addpath('export_fig-master');
addpath('visualize')

i_begin = 1;
i_end = 60;

% load('result_WB.mat');
% load('result_ST.mat');
load('result_PL.mat');


% h1 = plot_Error_total_2(WB_error);
% export_fig(h1,'T_Err_WB.png','-m3.5','-transparent') ;
% 
% h1 = plot_Error_total_2(ST_error);
% export_fig(h1,'T_Err_ST.png','-m3.5','-transparent') ;


h1 = plot_Error_total_2(PL_error);
export_fig(h1,'T_Err_PL.png','-m3.5','-transparent') ;