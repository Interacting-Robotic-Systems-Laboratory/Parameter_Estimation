function h = plot_trajectories_D415(estimation_size,Prdiction_size,N_1,N_2,position,D415_Data)
T_initial = estimation_size+1; 
%% load Brio data

D415_T = D415_Data.T;

D415_q = D415_Data.q;
D415_q(3,:) = (180/pi)*D415_q(3,:);
D415_q(1:2,:) = 1000*D415_q(1:2,:);


D415_N_prediction = min(N_2 + Prdiction_size, size(D415_T,2));

position_D415 = min(size(D415_Data.FW_UKF_Q_p,3), position);
% fixing window
D415_FW_UKF_Q_p = D415_Data.FW_UKF_Q_p(:,:,position_D415);
D415_FW_UKF_Q_p(1:2,:) = 1000*D415_FW_UKF_Q_p(1:2,:);
D415_FW_UKF_Q_p(3,:) = (180/pi)*D415_FW_UKF_Q_p(3,:);


D415_FW_CL_Q_p = D415_Data.FW_CL_Q_p(:,:,position_D415);
D415_FW_CL_Q_p(1:2,:) = 1000*D415_FW_CL_Q_p(1:2,:);
D415_FW_CL_Q_p(3,:) = (180/pi)*D415_FW_CL_Q_p(3,:);

% GP
D415_GP_Q_p = D415_Data.GP_Q_p(:,:,position_D415);
D415_GP_Q_p(1:2,:) = 1000*D415_GP_Q_p(1:2,:);
D415_GP_Q_p(3,:) = (180/pi)*D415_GP_Q_p(3,:);


%% error data
D415_SW_UKF_Err = D415_Data.SW_UKF_Err;
D415_SW_CL_Err = D415_Data.SW_CL_Err;
D415_FW_UKF_Err = D415_Data.FW_UKF_Err;
D415_FW_CL_Err = D415_Data.FW_CL_Err;
D415_GP_Err = D415_Data.GP_q_p_Err;


%% parameter para


FW_UKF_para = D415_Data.FW_UKF_para(:,:,position_D415);
FW_UKF_Para_std = D415_Data.FW_UKF_para_std(:,:,position_D415);

FW_CL_para = D415_Data.FW_CL_para(:,:,position_D415);

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
    % fixing estimation window for Brio
    subplot(3,3,3*I-2)
    plot(D415_T,D415_q(I,:),'r.');

    hold on
    
    plot(D415_T(1:N_2),D415_q(I,1:N_2),'ko');
    hold on
    plot(D415_T(N_2+1:D415_N_prediction),D415_FW_UKF_Q_p(I,N_2+1:D415_N_prediction),'g.');
    hold on
    plot(D415_T(N_2+1:D415_N_prediction),D415_FW_CL_Q_p(I,N_2+1:D415_N_prediction),'k.');
    hold on
    plot(D415_T(N_2+1:D415_N_prediction),D415_GP_Q_p(I,N_2+1:D415_N_prediction),'b.');
    xlabel('Time (s)');

    SIZE_y = abs(max(D415_q(I,:)) - min(D415_q(I,:)));
    ylim([min(D415_q(I,:))-0.5*SIZE_y, max(D415_q(I,:))+0.5*SIZE_y])
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
%     plot(D415_T(T_initial:T_initial+position_Brio-1), abs(Brio_SW_UKF_Err(I,1:position_Brio)),'g');
%     hold on
%     plot(Brio_T(T_initial:T_initial+position_Brio-1), abs(Brio_FW_UKF_Err(I,1:position_Brio)),'g.');
%     hold on
%     plot(D415_T(T_initial:T_initial+position_Brio-1), abs(Brio_SW_CL_Err(I,1:position_Brio)),'k');
%     hold on
%     plot(Brio_T(T_initial:T_initial+position_Brio-1), abs(Brio_FW_CL_Err(I,1:position_Brio)),'k.');
%     hold on
    plot(D415_T(T_initial:T_initial+position_D415-1), abs(D415_SW_UKF_Err(I,1:position_D415)),'g');
    hold on
    plot(D415_T(T_initial:T_initial+position_D415-1), abs(D415_FW_UKF_Err(I,1:position_D415)),'g.');
    hold on
    plot(D415_T(T_initial:T_initial+position_D415-1), abs(D415_SW_CL_Err(I,1:position_D415)),'k');
    hold on
    plot(D415_T(T_initial:T_initial+position_D415-1), abs(D415_FW_CL_Err(I,1:position_D415)),'k.');
    hold on
    plot(D415_T(T_initial:T_initial+position_D415-1), abs(D415_GP_Err(I,1:position_D415)),'b.');
    if I == 1 
        xlim([min(D415_T(T_initial), D415_T(T_initial)), max(D415_T(end), D415_T(end))]);
        ylim([0 10]);
        ylabel('q_x (mm)');
    elseif I == 2 
        xlim([ D415_T(T_initial), D415_T(end)]);
        ylim([0 10]);
        ylabel('q_y (mm)');
    else
       xlim([D415_T(T_initial), D415_T(end)]);
        ylim([0 10]);
        ylabel('\theta (degrees)');
    end

    lgd=legend('SW UKF','FW UKF','SW CL','FW CL','GP','Location','northeast');
    lgd.NumColumns = 3;
    grid on
   subplot(3,3,3*I)
    plot(D415_T,FW_UKF_para(I,:),'g.');
    hold on
    plot(D415_T,FW_CL_para_good(I,:),'k.');
    hold on
    plot(D415_T,FW_CL_para_overestimated(I,:),'r.');
    hold on
    plot(D415_T,FW_UKF_para(I,:)-FW_UKF_Para_std(I,:),'g--');
    hold on
    plot(D415_T,FW_UKF_para(I,:)+FW_UKF_Para_std(I,:),'g--');
    hold on
       
    xlabel('Time (s)');
    if I == 1
        ylabel('\alpha');
        axis([0 D415_T(end) 0 0.5]);

    elseif I == 2
        ylabel('\beta');
        axis([0 D415_T(end) 0 0.5]);
    else
        ylabel('\gamma');
        axis([0 D415_T(end) 0 0.02]);
    end
    lgd=legend('UKF','CL','CL_o','UKF-1\sigma','Location','northeast');
    lgd.NumColumns = 2;
    grid on
end





end