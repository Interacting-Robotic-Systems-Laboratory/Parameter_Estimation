function [Mean_brio, Std_brio, Mean_D415, Std_D415] = position_histogram_pipeline(param_HD,param_D415,Threshold_HD,Threshold_D415,Ground_truth)

%% Brio camera webcam
tic
Brio = webcam(4);
Brio.Exposure = -7;
Brio.ExposureMode = 'manual';
Brio.Resolution = '1920x1080';


for i = 1:60
    I = snapshot(Brio);
    Frame{i} = imrotate(I,180);
    %imshow(Frame{i});
end
clear('Brio');

[Position_brio, Theta_brio, Mean_brio, Std_brio]= color_pose(Frame,param_HD,Threshold_HD);
toc

%% D415 camera webcam
tic
D415 = webcam(3);
D415.Exposure = -7;
D415.ExposureMode = 'manual';
D415.Resolution = '640x480';


for i = 1:60
    Frame{i} = snapshot(D415);

    %imshow(Frame{i});
end
clear('D415');
%[Position_D415, Theta_D415, Mean_D415, Std_D415]= tag_pose(Frame, K_D415, tagsize, Hw_D415);
[Position_D415, Theta_D415, Mean_D415, Std_D415]= color_pose(Frame,param_D415,Threshold_D415);
toc


plot_histgram(Position_brio, Theta_brio, Position_D415, Theta_D415,Ground_truth);
%plot_histgram_angle(Theta_brio,Theta_D415,Ground_truth);

end