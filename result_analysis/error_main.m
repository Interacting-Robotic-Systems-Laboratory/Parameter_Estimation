clear all
close all
restoredefaultpath
%% add path
addpath('Utility');
addpath('results/wooden_block/');
addpath('export_fig-master');
addpath('visualize')
N_1 = 1;
N_2 = 10;
estimation_size = N_2 - N_1 + 1;

i_begin = 1;
i_end = 60;

%% compute errors
N = 20; % the maximum prediction window size
for i = 1:N
    
    Prdiction_window = i;
    [D415_error.w{i}] = compute_error_main(Prdiction_window,i_begin,i_end, N_1, N_2, 'D415_Data');
    
end

%% plot gif
% filename1 = strcat('Brio_histogram','.gif'); 
% filename2 = strcat('D415_histogram','.gif'); 
% filename3 = strcat('Brio_error','.gif'); 
% filename4 = strcat('D415_error','.gif'); 
% 
% for i = 1:20
%     Prdiction_window = i;
%     % plot histograms
%     h1 = plot_histogram(i_begin,i_end,' D415',D415_error.w{i},Prdiction_window);
% 
%     h2 = plot_histogram(i_begin,i_end,' Brio',Brio_error.w{i},Prdiction_window);
%     % plot Error at each steps
%     h3 = plot_Error_i(i_begin,i_end,' D415',D415_error.w{i},Prdiction_window);
%     h4 = plot_Error_i(i_begin,i_end,' Brio',Brio_error.w{i},Prdiction_window);
%     
%     % Capture the plot as an image 
%     frame1 = getframe(h1); 
%     im1 = frame2im(frame1); 
%     [imind1,cm1] = rgb2ind(im1,256); 
%     
%     frame2 = getframe(h2); 
%     im2 = frame2im(frame2); 
%     [imind2,cm2] = rgb2ind(im2,256); 
%     
%     frame3 = getframe(h3); 
%     im3 = frame2im(frame3); 
%     [imind3,cm3] = rgb2ind(im3,256); 
%     
%     frame4 = getframe(h4); 
%     im4 = frame2im(frame4); 
%     [imind4,cm4] = rgb2ind(im4,256); 
%     % Write to the GIF File 
%     if i == 1 
%       imwrite(imind1,cm1,filename1,'gif','DelayTime',1, 'Loopcount',inf); 
%       imwrite(imind2,cm2,filename2,'gif','DelayTime',1, 'Loopcount',inf); 
%       imwrite(imind3,cm3,filename3,'gif','DelayTime',1, 'Loopcount',inf); 
%       imwrite(imind4,cm4,filename4,'gif','DelayTime',1, 'Loopcount',inf); 
%     else 
%       imwrite(imind1,cm1,filename1,'gif','DelayTime',1,'WriteMode','append'); 
%       imwrite(imind2,cm2,filename2,'gif','DelayTime',1,'WriteMode','append'); 
%       imwrite(imind3,cm3,filename3,'gif','DelayTime',1,'WriteMode','append'); 
%       imwrite(imind4,cm4,filename4,'gif','DelayTime',1,'WriteMode','append'); 
%     end 
%     close all  
% end
%% plot parameters
% figure
% histogram(real(D415_para.FW_CL_para(3,:)),'Normalization','probability','BinWidth',0.001);
% hold on
% histogram(real(D415_para.FW_UKF_para(3,:)),'Normalization','probability','BinWidth',0.001);
% histogram(real(D415_para.SW_UKF_para(3,:)),'Normalization','probability','BinWidth',0.001);
% histogram(real(D415_para.SW_CL_para(3,:)),'Normalization','probability','BinWidth',0.001);


%% plot total errors
h1 = plot_Error_total_2(i_begin,i_end,' D415',D415_error);
%h2 = plot_Error_total_2(i_begin,i_end,' Brio',Brio_error); 
export_fig(h1,'Ch9_D415_T_Err_PL.png','-m3.5','-transparent') ;
%export_fig(h2,'Ch9_Brio_T_Err_PL.png','-m3.5','-transparent') ;
% export_fig(h3,'Ch9_Brio_T_Err_WB_p.png','-m3.5','-transparent') ;
% export_fig(h4,'Ch9_Brio_T_Err_WB_o.png','-m3.5','-transparent') ;

%% plot trial's errors
% 
% plot_Error_trial_i(i_begin,i_end,' D415',D415_error);
% plot_Error_trial_i(i_begin,i_end,' Brio',Brio_error);