function plot_Error_trial_i(i_begin,i_end,Data_name,Error)
i = 20;
mean_SW_UKF_Err_trial_i = Error.w{i}.mean_SW_UKF_Err_trial_i;
mean_FW_UKF_Err_trial_i = Error.w{i}.mean_FW_UKF_Err_trial_i;
mean_SW_CL_Err_trial_i = Error.w{i}.mean_SW_CL_Err_trial_i;
mean_FW_CL_Err_trial_i = Error.w{i}.mean_FW_CL_Err_trial_i;
mean_GP_Err_trial_i = Error.w{i}.mean_GP_Err_trial_i;

% std_SW_UKF_Err_trial_i = Error.w{i}.std_SW_UKF_Err_trial_i;
% std_FW_UKF_Err_trial_i = Error.w{i}.std_FW_UKF_Err_trial_i;
% std_SW_CL_Err_trial_i = Error.w{i}.std_SW_CL_Err_trial_i;
% std_FW_CL_Err_trial_i = Error.w{i}.std_FW_CL_Err_trial_i;
% std_GP_Err_trial_i = Error.w{i}.std_GP_Err_trial_i;


h = figure;
h.Position = [100 100 3*560 2*420/2];
T = i_begin:i_end;
TITLE = strcat(' Prediction error', '(',Data_name, ' : Trials #',num2str(i_begin),'-#',num2str(i_end),')');
sgtitle(TITLE);
subplot(2,3,1)
y = mean_SW_UKF_Err_trial_i(1,:);


bar(T,y,'r');


xlim([i_begin-1 i_end+1]);
ylim([0 20]);
grid on

xlabel('Experiment ID');
ylabel('Position (mm)');
title('SW UKF');

subplot(2,3,2)
y = mean_SW_CL_Err_trial_i(1,:);

bar(T,y,'r');

xlim([i_begin-1 i_end+1]);
ylim([0 25]);
grid on
title('SW CL');
xlabel('Experiment ID');
ylabel('Position (mm)');

subplot(2,3,3)
y = mean_GP_Err_trial_i(1,:);
bar(T,y,'r');

xlim([i_begin-1 i_end+1]);
ylim([0 20]);
grid on
xlabel('Experiment ID');
ylabel('Position (mm)');
title('GP');


subplot(2,3,4)
y = mean_SW_UKF_Err_trial_i(2,:);

bar(T,y,'r');

xlim([i_begin-1 i_end+1]);
ylim([0 25]);
grid on
lgd = legend('Normal','Plateau','Vibrate','Parabola','Location','northwest');
lgd.NumColumns = 2;


xlabel('Experiment ID');
ylabel('Orientation (degree)');

subplot(2,3,5)
y = mean_SW_CL_Err_trial_i(2,:);

bar(T,y,'r');

xlim([i_begin-1 i_end+1]);
ylim([0 25]);
grid on
lgd = legend('Normal','Plateau','Vibrate','Parabola','Location','northwest');
lgd.NumColumns = 2;


xlabel('Experiment ID');
ylabel('Orientation (degree)');

subplot(2,3,6)
y = mean_GP_Err_trial_i(2,:);

bar(T,y,'r');

xlim([i_begin-1 i_end+1]);
ylim([0 25]);
grid on
xlabel('Experiment ID');
ylabel('Orientation (degree)');



end