function plot_result_trajectory(N_1, N_2, Prdiction_window, estimation_size, Brio_Data, D415_Data, data_index)
%% load data
Brio_N = length(Brio_Data.T) - N_2 - Prdiction_window + 1;
D415_N = length(D415_Data.T) - N_2 - Prdiction_window + 1;


%% plot result

filename1 = strcat('Brio_plot_',data_index,'.gif'); 
filename2 = strcat('D415_plot_',data_index,'.gif'); 
N = Brio_N;
for i = 1:N
    N_1_p = i;
    N_2_p = N_2 + i - 1;
    %plot_denoised_data(Data);
    h1 = plot_trajectories_Brio(estimation_size,Prdiction_window,N_1_p,N_2_p,i,Brio_Data);
    
    % Capture the plot as an image 
    frame1 = getframe(h1); 
    im1 = frame2im(frame1); 
    [imind1,cm1] = rgb2ind(im1,256); 
    
    % Write to the GIF File 
    if i == 1 
      imwrite(imind1,cm1,filename1,'gif','DelayTime',1, 'Loopcount',inf); 
    else 
      imwrite(imind1,cm1,filename1,'gif','DelayTime',1,'WriteMode','append'); 
    end 
    close all  
end


N = D415_N;
for i = 1:N
    N_1_p = i;
    N_2_p = N_2 + i - 1;
    %plot_denoised_data(Data);

    h2 = plot_trajectories_D415(estimation_size,Prdiction_window,N_1_p,N_2_p,i,D415_Data);
    % Capture the plot as an image 

    frame2 = getframe(h2); 
    im2 = frame2im(frame2); 
    [imind2,cm2] = rgb2ind(im2,256); 
    % Write to the GIF File 
    if i == 1 
      imwrite(imind2,cm2,filename2,'gif','DelayTime',1, 'Loopcount',inf); 
    else 
      imwrite(imind2,cm2,filename2,'gif','DelayTime',1,'WriteMode','append'); 
    end 
    close all  
end
end