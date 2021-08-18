function plot_Error_total_percentage(i_begin,i_end,Data_name,Error)
for i = 1:20
   mean_SW_UKF_Err_T(:,i) = Error.w{i}.mean_SW_UKF_Err_T;
   mean_FW_UKF_Err_T(:,i) = Error.w{i}.mean_FW_UKF_Err_T;
   mean_SW_CL_Err_T(:,i) = Error.w{i}.mean_SW_CL_Err_T;
   mean_FW_CL_Err_T(:,i) = Error.w{i}.mean_FW_CL_Err_T;
   mean_GP_Err_T(:,i) = Error.w{i}.mean_GP_Err_T;
   
   std_SW_UKF_Err_T(:,i) = Error.w{i}.std_SW_UKF_Err_T;
   std_FW_UKF_Err_T(:,i) = Error.w{i}.std_FW_UKF_Err_T;
   std_SW_CL_Err_T(:,i) = Error.w{i}.std_SW_CL_Err_T;
   std_FW_CL_Err_T(:,i) = Error.w{i}.std_FW_CL_Err_T;
   std_GP_Err_T(:,i) = Error.w{i}.std_GP_Err_T;
   
end

h = figure;
h.Position = [100 100 2*560 2*420/2];
T = [5 10 15 20];
TITLE = strcat(' Prediction error', '(',Data_name, ' : Trials #',num2str(i_begin),'-#',num2str(i_end),')');
sgtitle(TITLE);
subplot(2,2,1)
y = [mean_SW_UKF_Err_T(1,T)' mean_FW_UKF_Err_T(1,T)' mean_SW_CL_Err_T(1,T)' mean_FW_CL_Err_T(1,T)' mean_GP_Err_T(1,T)'];
bar(T,y);

xlim([2 23]);
ylim([0 20]);
grid on
lgd = legend('SW UKF','FW UKF','SW CL','FW CL','GP','Location','northwest');
lgd.NumColumns = 1;
xlabel('Prediction window steps');
ylabel('Position (mm)');
title('Mean absolute error');

subplot(2,2,2)
y = [std_SW_UKF_Err_T(1,T)' std_FW_UKF_Err_T(1,T)' std_SW_CL_Err_T(1,T)' std_FW_CL_Err_T(1,T)' std_GP_Err_T(1,T)'];
bar(T,y);

xlim([2 23]);
ylim([0 20]);
grid on
lgd = legend('SW UKF','FW UKF','SW CL','FW CL','GP','Location','northwest');
lgd.NumColumns = 1;
xlabel('Prediction window steps');
ylabel('Position (mm)');
title('One standard deviation');

subplot(2,2,3)
y = [mean_SW_UKF_Err_T(2,T)' mean_FW_UKF_Err_T(2,T)' mean_SW_CL_Err_T(2,T)' mean_FW_CL_Err_T(2,T)' mean_GP_Err_T(2,T)'];
bar(T,y);

xlim([2 23]);
ylim([0 20]);
grid on
lgd = legend('SW UKF','FW UKF','SW CL','FW CL','GP','Location','northwest');
lgd.NumColumns = 1;


xlabel('Prediction window steps');
ylabel('Orientation (degree)');

subplot(2,2,4)
y = [std_SW_UKF_Err_T(2,T)' std_FW_UKF_Err_T(2,T)' std_SW_CL_Err_T(2,T)' std_FW_CL_Err_T(2,T)' std_GP_Err_T(2,T)'];
bar(T,y);

xlim([2 23]);
ylim([0 20]);
grid on
lgd = legend('SW UKF','FW UKF','SW CL','FW CL','GP','Location','northwest');
lgd.NumColumns = 1;


xlabel('Prediction window steps');
ylabel('Orientation (degree)');


end