function h = plot_trajectories_Brio(estimation_size,Prdiction_size,N_1,N_2,position,Brio_Data)
T_initial = estimation_size+1; 
%% load Brio data

Brio_T = Brio_Data.T;


Brio_q = Brio_Data.q;
Brio_q(3,:) = (180/pi)*Brio_q(3,:);
Brio_q(1:2,:) = 1000*Brio_q(1:2,:);


Brio_N_prediction = min(N_2 + Prdiction_size, size(Brio_T,2));
position_Brio = min(size(Brio_Data.FW_UKF_Q_p,3), position);

% fixing window
Brio_FW_UKF_Q_p = Brio_Data.FW_UKF_Q_p(:,:,position_Brio);
Brio_FW_UKF_Q_p(1:2,:) = 1000*Brio_FW_UKF_Q_p(1:2,:);
Brio_FW_UKF_Q_p(3,:) = (180/pi)*Brio_FW_UKF_Q_p(3,:);


Brio_FW_CL_Q_p = Brio_Data.FW_CL_Q_p(:,:,position_Brio);
Brio_FW_CL_Q_p(1:2,:) = 1000*Brio_FW_CL_Q_p(1:2,:);
Brio_FW_CL_Q_p(3,:) = (180/pi)*Brio_FW_CL_Q_p(3,:);

% GP
Brio_GP_Q_p = Brio_Data.GP_Q_p(:,:,position_Brio);
Brio_GP_Q_p(1:2,:) = 1000*Brio_GP_Q_p(1:2,:);
Brio_GP_Q_p(3,:) = (180/pi)*Brio_GP_Q_p(3,:);

%% error data
Brio_SW_UKF_Err = Brio_Data.SW_UKF_Err;
Brio_SW_CL_Err = Brio_Data.SW_CL_Err;
Brio_FW_UKF_Err = Brio_Data.FW_UKF_Err;
Brio_FW_CL_Err = Brio_Data.FW_CL_Err;
Brio_GP_Err = Brio_Data.GP_q_p_Err;
%% parameter para


FW_UKF_para = Brio_Data.FW_UKF_para(:,:,position_Brio);
FW_UKF_Para_std = Brio_Data.FW_UKF_para_std(:,:,position_Brio);

FW_CL_para = Brio_Data.FW_CL_para(:,:,position_Brio);

J1 = FW_CL_para(4,:) == 1;
J2 = FW_CL_para(4,:) == 0;
FW_CL_para_overestimated(1:3,:) = FW_CL_para(1:3,:);
FW_CL_para_overestimated(1:3,J1) = NaN;
FW_CL_para_good(1:3,:) = FW_CL_para(1:3,:);
FW_CL_para_good(1:3,J2) = NaN;



%% plot

h = figure;
h.Position = [100 100 3*560 3*420/2];
for I = 1:3
    % sliding estimation window for Brio
    subplot(3,3,3*I-2)
    plot(Brio_T,Brio_q(I,:),'r.');

    hold on
    
    plot(Brio_T(1:N_2),Brio_q(I,1:N_2),'ko');
    hold on
    plot(Brio_T(N_2+1:Brio_N_prediction),Brio_FW_UKF_Q_p(I,N_2+1:Brio_N_prediction),'g.');
    hold on
    plot(Brio_T(N_2+1:Brio_N_prediction),Brio_FW_CL_Q_p(I,N_2+1:Brio_N_prediction),'k.');
    hold on
    plot(Brio_T(N_2+1:Brio_N_prediction),Brio_GP_Q_p(I,N_2+1:Brio_N_prediction),'b.');
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
    lgd=legend('Measure','Est Window','UKF','CL','GP','Location','northwest');
    lgd.NumColumns = 3;
    grid on

    % prediction errors
    subplot(3,3,3*I-1)
    plot(Brio_T(T_initial:T_initial+position_Brio-1), abs(Brio_SW_UKF_Err(I,1:position_Brio)),'g');
    hold on
    plot(Brio_T(T_initial:T_initial+position_Brio-1), abs(Brio_FW_UKF_Err(I,1:position_Brio)),'g.');
    hold on
    plot(Brio_T(T_initial:T_initial+position_Brio-1), abs(Brio_SW_CL_Err(I,1:position_Brio)),'k');
    hold on
    plot(Brio_T(T_initial:T_initial+position_Brio-1), abs(Brio_FW_CL_Err(I,1:position_Brio)),'k.');
    hold on
    plot(Brio_T(T_initial:T_initial+position_Brio-1), abs(Brio_GP_Err(I,1:position_Brio)),'b.');
    hold on
%     plot(D415_T(T_initial:T_initial+position_D415-1), abs(D415_SW_UKF_Err(I,1:position_D415)),'g.');
%     hold on
%     plot(D415_T(T_initial:T_initial+position_D415-1), abs(D415_FW_UKF_Err(I,1:position_D415)),'go');
%     hold on
%     plot(D415_T(T_initial:T_initial+position_D415-1), abs(D415_SW_CL_Err(I,1:position_D415)),'k.');
%     hold on
%    plot(D415_T(T_initial:T_initial+position_D415-1), abs(D415_FW_CL_Err(I,1:position_D415)),'ko');
    if I == 1 
        xlim([Brio_T(T_initial), Brio_T(end)]);
        ylim([0 10]);
        ylabel('q_x (mm)');
    elseif I == 2 
        xlim([Brio_T(T_initial), Brio_T(end)]);
        ylim([0 10]);
        ylabel('q_y (mm)');
    else
       xlim([Brio_T(T_initial), Brio_T(end)]);
        ylim([0 10]);
        ylabel('\theta (degrees)');
    end

    lgd=legend('SW UKF','FW UKF','SW CL','FW CL','GP','Location','northeast');
    lgd.NumColumns = 3;
    grid on
    subplot(3,3,3*I)
    plot(Brio_T,FW_UKF_para(I,:),'g.');
    hold on
    plot(Brio_T,FW_CL_para_good(I,:),'k.');
    hold on
    plot(Brio_T,FW_CL_para_overestimated(I,:),'r.');
    hold on
    plot(Brio_T,FW_UKF_para(I,:)-FW_UKF_Para_std(I,:),'g--');
    hold on
    plot(Brio_T,FW_UKF_para(I,:)+FW_UKF_Para_std(I,:),'g--');
    hold on
       
    xlabel('Time (s)');
    if I == 1
        ylabel('\alpha');
        axis([0 Brio_T(end) 0 0.5]);

    elseif I == 2
        ylabel('\beta');
        axis([0 Brio_T(end) 0 0.5]);
    else
        ylabel('\gamma');
        axis([0 Brio_T(end) 0 0.02]);
    end
    lgd=legend('UKF','CL','CL_o','UKF-1\sigma','Location','northeast');
    lgd.NumColumns = 2;
    grid on
end





end