function plot_param()

for I = 1:3
    plot(T,FW_UKF_para(I,:),'g.');
    hold on
    plot(T,FW_CL_para_good(I,:),'k.');
    hold on
    plot(T,FW_CL_para_overestimated(I,:),'r.');
    hold on
    plot(T,FW_UKF_para(I,:)-FW_UKF_Para_std(I,:),'g--');
    hold on
    plot(T,FW_UKF_para(I,:)+FW_UKF_Para_std(I,:),'g--');
    hold on
    
    
    plot(T,SW_UKF_para(I,:),'g*');
    hold on
    plot(T,SW_CL_para_good(I,:),'k*');
    hold on
    plot(T,SW_CL_para_overestimated(I,:),'r*');
    hold on
    plot(T,SW_UKF_para(I,:)-SW_UKF_Para_std(I,:),'g*-');
    hold on
    plot(T,SW_UKF_para(I,:)+SW_UKF_Para_std(I,:),'g*-');
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
end