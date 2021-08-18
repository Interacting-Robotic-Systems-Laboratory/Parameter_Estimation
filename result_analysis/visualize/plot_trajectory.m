function h = plot_trajectory(S,N_1,N_2,position,Data,I)
T = Data.T;
q = Data.q;
q(3,:) = (180/pi)*q(3,:);
q(1:2,:) = 1000*q(1:2,:);

N_prediction = N_2 + S.Prdiction_window;

Data_end = size(T,2);

if Data_end <= N_prediction
    N_prediction = Data_end;
end



UKF_Q_p = Data.UKF_Q_p(:,:,position);
UKF_Q_p(1:2,:) = 1000*UKF_Q_p(1:2,:);
UKF_Q_p(3,:) = (180/pi)*UKF_Q_p(3,:);

UKF_para = Data.UKF_para(:,:,position);
UKF_Para_std = Data.UKF_para_std(:,:,position);

CL_Q_p = Data.CL_Q_p(:,:,position);
CL_Q_p(1:2,:) = 1000*CL_Q_p(1:2,:);
CL_Q_p(3,:) = (180/pi)*CL_Q_p(3,:);

CL_para = Data.CL_para(:,:,position);

J1 = CL_para(4,:) == 1;
J2 = CL_para(4,:) == 0;
CL_para_overestimated(1:3,:) = CL_para(1:3,:);
CL_para_overestimated(1:3,J1) = NaN;
CL_para_good(1:3,:) = CL_para(1:3,:);
CL_para_good(1:3,J2) = NaN;

h = figure;
subplot(2,1,1)
plot(T,q(I,:),'r.');

hold on
% estimation window
plot(T(N_1:N_2),q(I,N_1:N_2),'ko');
hold on
plot(T(N_2+1:N_prediction),UKF_Q_p(I,N_2+1:N_prediction),'g.');
hold on
plot(T(N_2+1:N_prediction),CL_Q_p(I,N_2+1:N_prediction),'k.');
xlabel('Time (s)');

SIZE_y = abs(max(q(I,:)) - min(q(I,:)));
ylim([min(q(I,:))-0.5*SIZE_y, max(q(I,:))+0.5*SIZE_y])

UKF_Err = UKF_Q_p(I,N_prediction) - q(I,N_prediction);
CL_Err =  CL_Q_p(I,N_prediction) - q(I,N_prediction);
if I == 1
    UKF_Err = num2str(round(UKF_Err));
    CL_Err = num2str(round(CL_Err));
    ylabel('q_x (mm)');
elseif I == 2
    UKF_Err = num2str(round(UKF_Err));
    CL_Err = num2str(round(CL_Err));
    ylabel('q_y (mm)');
else
    UKF_Err = num2str(round(UKF_Err*10)/10);
    CL_Err = num2str(round(CL_Err*10)/10);
    ylabel('\theta (degrees)');
end
lgd=legend('Measurement','Est Window','UKF','CL','Location','northwest');
lgd.NumColumns = 2;
grid on

text(0.6*T(end),0.8*(max(q(I,:))+0.5*SIZE_y),strcat('UKF Error: ',UKF_Err,'; CL Error: ', CL_Err));

subplot(2,1,2)
plot(T,UKF_para(I,:),'g.');
hold on
plot(T,CL_para_good(I,:),'k.');
hold on
plot(T,CL_para_overestimated(I,:),'r.');
hold on
plot(T,UKF_para(I,:)-UKF_Para_std(I,:),'g--');
hold on
plot(T,UKF_para(I,:)+UKF_Para_std(I,:),'g--');
hold on
xlabel('Time (s)');
if I == 1
    ylabel('\alpha');
    axis([0 T(end) 0 0.5]);
    
elseif I == 2
    ylabel('\beta');
    axis([0 T(end) 0 0.5]);
else
    ylabel('\gamma');
    axis([0 T(end) 0 0.02]);
end
lgd=legend('UKF','CL','CL_o','UKF-1\sigma','Location','northeast');
lgd.NumColumns = 2;
grid on




end