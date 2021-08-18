function h = plot_Error_i(i_begin,i_end,Data_name,Error,N_step)

mean_SW_UKF_Err_i = Error.mean_SW_UKF_Err_i;
mean_SW_CL_Err_i = Error.mean_SW_CL_Err_i;
mean_FW_UKF_Err_i = Error.mean_FW_UKF_Err_i;
mean_FW_CL_Err_i = Error.mean_FW_CL_Err_i;
mean_GP_Err_i = Error.mean_GP_Err_i;

std_SW_UKF_Err_i = Error.std_SW_UKF_Err_i;
std_SW_CL_Err_i = Error.std_SW_CL_Err_i;
std_FW_UKF_Err_i = Error.std_FW_UKF_Err_i;
std_FW_CL_Err_i = Error.std_FW_CL_Err_i;
std_GP_Err_i = Error.std_GP_Err_i;

h = figure;
h.Position = [100 100 2*560 3*420/2];
T = 1:20;
TITLE = strcat('Error for prediction with window size of ', num2str(N_step), '(',Data_name, ' : Trials #',num2str(i_begin),'-#',num2str(i_end),')');
sgtitle(TITLE);
subplot(3,2,1)
plot(T,mean_SW_UKF_Err_i(1,:),'g.');
hold on
plot(T,mean_SW_CL_Err_i(1,:),'k.');
hold on
plot(T,mean_GP_Err_i(1,:),'b.');
hold on

plot(T,mean_SW_UKF_Err_i(1,:) + std_SW_UKF_Err_i(1,:),'g--');
hold on
plot(T,mean_SW_UKF_Err_i(1,:) - std_SW_UKF_Err_i(1,:),'g--');
hold on

plot(T,mean_SW_CL_Err_i(1,:) + std_SW_CL_Err_i(1,:),'k--');
hold on
plot(T,mean_SW_CL_Err_i(1,:) - std_SW_CL_Err_i(1,:),'k--');
hold on

plot(T,mean_GP_Err_i(1,:) + std_GP_Err_i(1,:),'k--');
hold on
plot(T,mean_GP_Err_i(1,:) - std_GP_Err_i(1,:),'k--');
hold on

xlim([0 20]);
ylim([-10 30]);
grid on
legend('UKF','CL','Location','northwest');

xlabel('Steps');
ylabel('q_x (mm)');
title('Sliding Window');
subplot(3,2,2)
plot(T,mean_FW_UKF_Err_i(1,:),'g.');
hold on
plot(T,mean_FW_CL_Err_i(1,:),'k.');
hold on
plot(T,mean_FW_UKF_Err_i(1,:) + std_FW_UKF_Err_i(1,:),'g--');
hold on
plot(T,mean_FW_UKF_Err_i(1,:) - std_FW_UKF_Err_i(1,:),'g--');
hold on

plot(T,mean_FW_CL_Err_i(1,:) + std_FW_CL_Err_i(1,:),'k--');
hold on
plot(T,mean_FW_CL_Err_i(1,:) - std_FW_CL_Err_i(1,:),'k--');
hold on

xlim([0 20]);
ylim([-10 30]);
grid on   
legend('UKF','CL','Location','northeast');
xlabel('steps');
ylabel('q_x (mm)');
title('Fixed Window');

subplot(3,2,3)
plot(T,mean_SW_UKF_Err_i(2,:),'g');
hold on
plot(T,mean_SW_CL_Err_i(2,:),'k');
hold on
plot(T,mean_SW_UKF_Err_i(2,:) + std_SW_UKF_Err_i(2,:),'g--');
hold on
plot(T,mean_SW_UKF_Err_i(2,:) - std_SW_UKF_Err_i(2,:),'g--');
hold on

plot(T,mean_SW_CL_Err_i(2,:) + std_SW_CL_Err_i(2,:),'k--');
hold on
plot(T,mean_SW_CL_Err_i(2,:) - std_SW_CL_Err_i(2,:),'k--');
hold on


xlim([0 20]);
ylim([0 10]);
grid on  
legend('UKF','CL','Location','northeast');


xlabel('steps');
ylabel('q_y (mm)');

subplot(3,2,4)
plot(T,mean_FW_UKF_Err_i(2,:),'g.');
hold on
plot(T,mean_FW_CL_Err_i(2,:),'k.');
hold on
plot(T,mean_FW_UKF_Err_i(2,:) + std_FW_UKF_Err_i(2,:),'g--');
hold on
plot(T,mean_FW_UKF_Err_i(2,:) - std_FW_UKF_Err_i(2,:),'g--');
hold on

plot(T,mean_FW_CL_Err_i(2,:) + std_FW_CL_Err_i(2,:),'k--');
hold on
plot(T,mean_FW_CL_Err_i(2,:) - std_FW_CL_Err_i(2,:),'k--');
hold on

xlim([0 20]);
ylim([0 10]);
grid on   
legend('UKF','CL','Location','northeast');
xlabel('steps');
ylabel('q_y (mm)');
subplot(3,2,5)
plot(T,mean_SW_UKF_Err_i(3,:),'g');
hold on
plot(T,mean_SW_CL_Err_i(3,:),'k');
hold on
plot(T,mean_SW_UKF_Err_i(3,:) + std_SW_UKF_Err_i(3,:),'g--');
hold on
plot(T,mean_SW_UKF_Err_i(3,:) - std_SW_UKF_Err_i(3,:),'g--');
hold on

plot(T,mean_SW_CL_Err_i(3,:) + std_SW_CL_Err_i(3,:),'k--');
hold on
plot(T,mean_SW_CL_Err_i(3,:) - std_SW_CL_Err_i(3,:),'k--');
hold on


xlim([0 20]);
ylim([-5 15]);
grid on   
legend('UKF','CL','Location','northeast');


xlabel('steps');
ylabel('theta (degree)');

subplot(3,2,6)
plot(T,mean_FW_UKF_Err_i(3,:),'g.');
hold on
plot(T,mean_FW_CL_Err_i(3,:),'k.');
hold on
plot(T,mean_FW_UKF_Err_i(3,:) + std_FW_UKF_Err_i(3,:),'g--');
hold on
plot(T,mean_FW_UKF_Err_i(3,:) - std_FW_UKF_Err_i(3,:),'g--');
hold on

plot(T,mean_FW_CL_Err_i(3,:) + std_FW_CL_Err_i(3,:),'k--');
hold on
plot(T,mean_FW_CL_Err_i(3,:) - std_FW_CL_Err_i(3,:),'k--');
hold on

xlim([0 20]);
ylim([-5 15]);
grid on       
legend('UKF','CL','Location','northeast'); 
xlabel('steps');
ylabel('theta (degree)');


end