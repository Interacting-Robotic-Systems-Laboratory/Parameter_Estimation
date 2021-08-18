function h = plot_histogram(i_begin,i_end,Data_name,Error,N_step)

SW_UKF_Err_T = Error.SW_UKF_Err_T;
FW_UKF_Err_T = Error.FW_UKF_Err_T;
SW_CL_Err_T = Error.SW_CL_Err_T;
FW_CL_Err_T = Error.FW_CL_Err_T;
GP_Err_T = Error.GP_Err_T;

xrange = [-15 15];
yrange = [0 0.25];
y = -30:0.1:30;
mu_SW_UKF = mean(SW_UKF_Err_T, 2);
mu_FW_UKF = mean(FW_UKF_Err_T, 2);
mu_SW_CL = mean(SW_CL_Err_T, 2);
mu_FW_CL = mean(FW_CL_Err_T, 2);
mu_GP = mean( GP_Err_T, 2);

sigma_SW_UKF = std(SW_UKF_Err_T,0, 2);
sigma_FW_UKF = std(FW_UKF_Err_T,0, 2);
sigma_SW_CL = std(SW_CL_Err_T,0, 2);
sigma_FW_CL = std(FW_CL_Err_T,0, 2);
sigma_GP = std( GP_Err_T,0, 2);

f_SW_UKF = exp(-(y-mu_SW_UKF).^2./(2*sigma_SW_UKF.^2))./(sigma_SW_UKF*sqrt(2*pi));
f_FW_UKF = exp(-(y-mu_FW_UKF).^2./(2*sigma_FW_UKF.^2))./(sigma_FW_UKF*sqrt(2*pi));
f_SW_CL = exp(-(y-mu_SW_CL).^2./(2*sigma_SW_CL.^2))./(sigma_SW_CL*sqrt(2*pi));
f_FW_CL = exp(-(y-mu_FW_CL).^2./(2*sigma_FW_CL.^2))./(sigma_FW_CL*sqrt(2*pi));
f_GP = exp(-(y-mu_GP).^2./(2*sigma_GP.^2))./(sigma_GP*sqrt(2*pi));

h = figure;
h.Position = [100 100 2*560 3*420/2];
TITLE = strcat('Histograms of error for ', num2str(N_step),' Steps of Prediction ','(', Data_name, ' :Trials #',num2str(i_begin),'-#',num2str(i_end),')');
sgtitle(TITLE);
subplot(3,3,1)
histogram(SW_UKF_Err_T(1,:),'BinWidth',1,'Normalization','pdf','FaceColor','green');
hold on
histogram(SW_CL_Err_T(1,:),'BinWidth',1,'Normalization','pdf','FaceColor','black');
hold on
plot(y,f_SW_UKF(1,:),'g','LineWidth',1.5);
hold on
plot(y,f_SW_CL(1,:),'k','LineWidth',1.5);
hold on
plot((mu_SW_UKF(1))*ones(30,1),0:0.01:0.29,'g','LineWidth',1.5);
hold on
plot((mu_SW_UKF(1) - sigma_SW_UKF(1))*ones(30,1),0:0.01:0.29,'g--','LineWidth',1.5);
hold on
plot((mu_SW_UKF(1) + sigma_SW_UKF(1))*ones(30,1),0:0.01:0.29,'g--','LineWidth',1.5);

hold on
plot((mu_SW_CL(1))*ones(30,1),0:0.01:0.29,'k','LineWidth',1.5);
hold on
plot((mu_SW_CL(1) - sigma_SW_CL(1))*ones(30,1),0:0.01:0.29,'k--','LineWidth',1.5);
hold on
plot((mu_SW_CL(1) + sigma_SW_CL(1))*ones(30,1),0:0.01:0.29,'k--','LineWidth',1.5);


title('Sliding Window');
xlabel('Error in q_x (mm)');
ylabel('Probability');
grid on
legend('UKF','CL','Location','northeast');
xlim(xrange);
ylim(yrange);

subplot(3,3,2)
histogram(FW_UKF_Err_T(1,:),'BinWidth',1,'Normalization','pdf','FaceColor','green');
hold on
histogram(FW_CL_Err_T(1,:),'BinWidth',1,'Normalization','pdf','FaceColor','black');
hold on
plot(y,f_FW_UKF(1,:),'g','LineWidth',1.5);
hold on
plot(y,f_FW_CL(1,:),'k','LineWidth',1.5);

hold on
plot((mu_FW_UKF(1))*ones(30,1),0:0.01:0.29,'g','LineWidth',1.5);
hold on
plot((mu_FW_UKF(1) - sigma_FW_UKF(1))*ones(30,1),0:0.01:0.29,'g--','LineWidth',1.5);
hold on
plot((mu_FW_UKF(1) + sigma_FW_UKF(1))*ones(30,1),0:0.01:0.29,'g--','LineWidth',1.5);

hold on
plot((mu_FW_CL(1))*ones(30,1),0:0.01:0.29,'k','LineWidth',1.5);
hold on
plot((mu_FW_CL(1) - sigma_FW_CL(1))*ones(30,1),0:0.01:0.29,'k--','LineWidth',1.5);
hold on
plot((mu_FW_CL(1) + sigma_FW_CL(1))*ones(30,1),0:0.01:0.29,'k--','LineWidth',1.5);

title('Fixed Window');
xlabel('Error in q_x (mm)');
ylabel('Probability');
grid on
legend('UKF','CL','Location','northeast');
xlim(xrange);
ylim(yrange);

subplot(3,3,3)
histogram(GP_Err_T(1,:),'BinWidth',1,'Normalization','pdf','FaceColor','blue');
hold on
plot(y,f_GP(1,:),'b','LineWidth',1.5);

hold on
plot((mu_GP(1))*ones(30,1),0:0.01:0.29,'b','LineWidth',1.5);
hold on
plot((mu_GP(1) - sigma_GP(1))*ones(30,1),0:0.01:0.29,'b--','LineWidth',1.5);
hold on
plot((mu_GP(1) + sigma_GP(1))*ones(30,1),0:0.01:0.29,'b--','LineWidth',1.5);

title('GP');
xlabel('Error in q_x (mm)');
ylabel('Probability');
grid on
legend('GP','Location','northeast');
xlim(xrange);
ylim(yrange);

subplot(3,3,4)
histogram(SW_UKF_Err_T(2,:),'BinWidth',1,'Normalization','pdf','FaceColor','green');
hold on
histogram(SW_CL_Err_T(2,:),'BinWidth',1,'Normalization','pdf','FaceColor','black');
hold on
plot(y,f_SW_UKF(2,:),'g','LineWidth',1.5);
hold on
plot(y,f_SW_CL(2,:),'k','LineWidth',1.5);

hold on
plot((mu_SW_UKF(2))*ones(30,1),0:0.01:0.29,'g','LineWidth',1.5);
hold on
plot((mu_SW_UKF(2) - sigma_SW_UKF(2))*ones(30,1),0:0.01:0.29,'g--','LineWidth',1.5);
hold on
plot((mu_SW_UKF(2) + sigma_SW_UKF(2))*ones(30,1),0:0.01:0.29,'g--','LineWidth',1.5);

hold on
plot((mu_SW_CL(2))*ones(30,1),0:0.01:0.29,'k','LineWidth',1.5);
hold on
plot((mu_SW_CL(2) - sigma_SW_CL(2))*ones(30,1),0:0.01:0.29,'k--','LineWidth',1.5);
hold on
plot((mu_SW_CL(2) + sigma_SW_CL(2))*ones(30,1),0:0.01:0.29,'k--','LineWidth',1.5);


xlabel('Error in q_y (mm)');
ylabel('Probability');
grid on
legend('UKF','CL','Location','northeast');
xlim(xrange);
ylim(yrange);

subplot(3,3,5)
histogram(FW_UKF_Err_T(2,:),'BinWidth',1,'Normalization','pdf','FaceColor','green');
hold on
histogram(FW_CL_Err_T(2,:),'BinWidth',1,'Normalization','pdf','FaceColor','black');
hold on
plot(y,f_FW_UKF(2,:),'g','LineWidth',1.5);
hold on
plot(y,f_FW_CL(2,:),'k','LineWidth',1.5);

hold on
plot((mu_FW_UKF(2))*ones(30,1),0:0.01:0.29,'g','LineWidth',1.5);
hold on
plot((mu_FW_UKF(2) - sigma_FW_UKF(2))*ones(30,1),0:0.01:0.29,'g--','LineWidth',1.5);
hold on
plot((mu_FW_UKF(2) + sigma_FW_UKF(2))*ones(30,1),0:0.01:0.29,'g--','LineWidth',1.5);

hold on
plot((mu_FW_CL(2))*ones(30,1),0:0.01:0.29,'k','LineWidth',1.5);
hold on
plot((mu_FW_CL(2) - sigma_FW_CL(2))*ones(30,1),0:0.01:0.29,'k--','LineWidth',1.5);
hold on
plot((mu_FW_CL(2) + sigma_FW_CL(2))*ones(30,1),0:0.01:0.29,'k--','LineWidth',1.5);


xlabel('Error in q_y (mm)');
ylabel('Probability');
grid on
legend('UKF','CL','Location','northeast');
xlim(xrange);
ylim(yrange);

subplot(3,3,6)
histogram(GP_Err_T(2,:),'BinWidth',1,'Normalization','pdf','FaceColor','blue');
hold on
plot(y,f_GP(2,:),'b','LineWidth',1.5);

hold on
plot((mu_GP(2))*ones(30,1),0:0.01:0.29,'b','LineWidth',1.5);
hold on
plot((mu_GP(2) - sigma_GP(2))*ones(30,1),0:0.01:0.29,'b--','LineWidth',1.5);
hold on
plot((mu_GP(2) + sigma_GP(2))*ones(30,1),0:0.01:0.29,'b--','LineWidth',1.5);



xlabel('Error in q_y (mm)');
ylabel('Probability');
grid on
legend('GP','Location','northeast');
xlim(xrange);
ylim(yrange);


subplot(3,3,7)
histogram(SW_UKF_Err_T(3,:),'BinWidth',1,'Normalization','pdf','FaceColor','green');
hold on
histogram(SW_CL_Err_T(3,:),'BinWidth',1,'Normalization','pdf','FaceColor','black');
hold on
plot(y,f_SW_UKF(3,:),'g','LineWidth',1.5);
hold on
plot(y,f_SW_CL(3,:),'k','LineWidth',1.5);

hold on
plot((mu_SW_UKF(3))*ones(30,1),0:0.01:0.29,'g','LineWidth',1.5);
hold on
plot((mu_SW_UKF(3) - sigma_SW_UKF(3))*ones(30,1),0:0.01:0.29,'g--','LineWidth',1.5);
hold on
plot((mu_SW_UKF(3) + sigma_SW_UKF(3))*ones(30,1),0:0.01:0.29,'g--','LineWidth',1.5);

hold on
plot((mu_SW_CL(3))*ones(30,1),0:0.01:0.29,'k','LineWidth',1.5);
hold on
plot((mu_SW_CL(3) - sigma_SW_CL(3))*ones(30,1),0:0.01:0.29,'k--','LineWidth',1.5);
hold on
plot((mu_SW_CL(3) + sigma_SW_CL(3))*ones(30,1),0:0.01:0.29,'k--','LineWidth',1.5);



xlabel('Error in theta (degree)');
ylabel('Probability');
grid on
legend('UKF','CL','Location','northeast');
xlim(xrange);
ylim(yrange);

subplot(3,3,8)
histogram(FW_UKF_Err_T(3,:),'BinWidth',1,'Normalization','pdf','FaceColor','green');
hold on
histogram(FW_CL_Err_T(3,:),'BinWidth',1,'Normalization','pdf','FaceColor','black');
hold on
plot(y,f_FW_UKF(3,:),'g','LineWidth',1.5);
hold on
plot(y,f_FW_CL(3,:),'k','LineWidth',1.5);

hold on
plot((mu_FW_UKF(3))*ones(30,1),0:0.01:0.29,'g','LineWidth',1.5);
hold on
plot((mu_FW_UKF(3) - sigma_FW_UKF(3))*ones(30,1),0:0.01:0.29,'g--','LineWidth',1.5);
hold on
plot((mu_FW_UKF(3) + sigma_FW_UKF(3))*ones(30,1),0:0.01:0.29,'g--','LineWidth',1.5);

hold on
plot((mu_FW_CL(3))*ones(30,1),0:0.01:0.29,'k','LineWidth',1.5);
hold on
plot((mu_FW_CL(3) - sigma_FW_CL(3))*ones(30,1),0:0.01:0.29,'k--','LineWidth',1.5);
hold on
plot((mu_FW_CL(3) + sigma_FW_CL(3))*ones(30,1),0:0.01:0.29,'k--','LineWidth',1.5);


xlabel('Error in theta (degree)');
ylabel('Probability');
grid on
legend('UKF','CL','Location','northeast');
xlim(xrange);
ylim(yrange);

subplot(3,3,9)
histogram(GP_Err_T(3,:),'BinWidth',1,'Normalization','pdf','FaceColor','blue');
hold on
plot(y,f_GP(3,:),'b','LineWidth',1.5);

hold on
plot((mu_GP(3))*ones(30,1),0:0.01:0.29,'b','LineWidth',1.5);
hold on
plot((mu_GP(3) - sigma_GP(3))*ones(30,1),0:0.01:0.29,'b--','LineWidth',1.5);
hold on
plot((mu_GP(3) + sigma_GP(3))*ones(30,1),0:0.01:0.29,'b--','LineWidth',1.5);


xlabel('Error in theta (degree)');
ylabel('Probability');
grid on
legend('GP','Location','northeast');
xlim(xrange);
ylim(yrange);


end