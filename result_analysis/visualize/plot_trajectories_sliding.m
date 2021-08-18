function h = plot_trajectories_sliding(estimation_size,Prdiction_size,N_1,N_2,position,Brio_Data,D415_Data)
T_initial = estimation_size+1; 
%% load Brio data

Brio_T = Brio_Data.T;
D415_T = D415_Data.T;

Brio_q = Brio_Data.q;
Brio_q(3,:) = (180/pi)*Brio_q(3,:);
Brio_q(1:2,:) = 1000*Brio_q(1:2,:);


Brio_N_prediction = min(N_2 + Prdiction_size, size(Brio_T,2));
position_Brio = min(size(Brio_Data.FW_UKF_Q_p,3), position);
position_D415 = min(size(D415_Data.FW_UKF_Q_p,3), position);
% sliding window
Brio_SW_UKF_Q_p = Brio_Data.SW_UKF_Q_p(:,:,position_Brio);
Brio_SW_UKF_Q_p(1:2,:) = 1000*Brio_SW_UKF_Q_p(1:2,:);
Brio_SW_UKF_Q_p(3,:) = (180/pi)*Brio_SW_UKF_Q_p(3,:);


Brio_SW_CL_Q_p = Brio_Data.SW_CL_Q_p(:,:,position_Brio);
Brio_SW_CL_Q_p(1:2,:) = 1000*Brio_SW_CL_Q_p(1:2,:);
Brio_SW_CL_Q_p(3,:) = (180/pi)*Brio_SW_CL_Q_p(3,:);

%% error data
Brio_SW_UKF_Err = Brio_Data.SW_UKF_Err;
Brio_SW_CL_Err = Brio_Data.SW_CL_Err;
Brio_FW_UKF_Err = Brio_Data.FW_UKF_Err;
Brio_FW_CL_Err = Brio_Data.FW_CL_Err;

D415_SW_UKF_Err = D415_Data.SW_UKF_Err;
D415_SW_CL_Err = D415_Data.SW_CL_Err;
D415_FW_UKF_Err = D415_Data.FW_UKF_Err;
D415_FW_CL_Err = D415_Data.FW_CL_Err;


%% plot

h = figure;
h.Position = [100 100 2*560 3*420/2];
for I = 1:3
    % sliding estimation window for Brio
    subplot(3,2,2*I-1)
    plot(Brio_T,Brio_q(I,:),'r.');

    hold on
    
    plot(Brio_T(N_1:N_2),Brio_q(I,N_1:N_2),'ko');
    hold on
    plot(Brio_T(N_2+1:Brio_N_prediction),Brio_SW_UKF_Q_p(I,N_2+1:Brio_N_prediction),'g.');
    hold on
    plot(Brio_T(N_2+1:Brio_N_prediction),Brio_SW_CL_Q_p(I,N_2+1:Brio_N_prediction),'k.');
    xlabel('Time (s)');

    SIZE_y = abs(max(Brio_q(I,:)) - min(Brio_q(I,:)));
    ylim([min(Brio_q(I,:))-0.5*SIZE_y, max(Brio_q(I,:))+0.5*SIZE_y])
    if I == 1
        ylabel('q_x (mm)');
    elseif I == 2
        ylabel('q_y (mm)');
    else
        ylabel('\theta (degrees)');
    end
    lgd=legend('Measure','Est Window','UKF','CL','Location','northwest');
    lgd.NumColumns = 2;
    grid on

    % prediction errors
    subplot(3,2,2*I)
    plot(Brio_T(T_initial:T_initial+position_Brio-1), abs(Brio_SW_UKF_Err(I,1:position_Brio)),'g');
    hold on
%     plot(Brio_T(T_initial:T_initial+position_Brio-1), abs(Brio_FW_UKF_Err(I,1:position_Brio)),'g.');
%     hold on
    plot(Brio_T(T_initial:T_initial+position_Brio-1), abs(Brio_SW_CL_Err(I,1:position_Brio)),'k');
    hold on
%     plot(Brio_T(T_initial:T_initial+position_Brio-1), abs(Brio_FW_CL_Err(I,1:position_Brio)),'k.');
%     hold on
    plot(D415_T(T_initial:T_initial+position_D415-1), abs(D415_SW_UKF_Err(I,1:position_D415)),'g.');
    hold on
%     plot(D415_T(T_initial:T_initial+position_D415-1), abs(D415_FW_UKF_Err(I,1:position_D415)),'go');
%     hold on
    plot(D415_T(T_initial:T_initial+position_D415-1), abs(D415_SW_CL_Err(I,1:position_D415)),'k.');
    hold on
%    plot(D415_T(T_initial:T_initial+position_D415-1), abs(D415_FW_CL_Err(I,1:position_D415)),'ko');
    if I == 1 
        xlim([min(Brio_T(T_initial), D415_T(T_initial)), max(Brio_T(end), D415_T(end))]);
        ylim([0 10]);
        ylabel('q_x (mm)');
    elseif I == 2 
        xlim([min(Brio_T(T_initial), D415_T(T_initial)), max(Brio_T(end), D415_T(end))]);
        ylim([0 10]);
        ylabel('q_y (mm)');
    else
       xlim([min(Brio_T(T_initial), D415_T(T_initial)), max(Brio_T(end), D415_T(end))]);
        ylim([0 10]);
        ylabel('\theta (degrees)');
    end

    lgd=legend('Brio UKF','Brio CL','D415 UKF','D415 CL','Location','northeast');
    lgd.NumColumns = 2;
    grid on
    
end





end