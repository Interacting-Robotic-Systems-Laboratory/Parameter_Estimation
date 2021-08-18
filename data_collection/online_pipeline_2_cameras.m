clear all
close all

addpath('utility');


%% load intrinsic and extrinsic parameters
load('HD_10_30.mat'); % load the inertia parameters for brio
load('D415_10_30.mat'); % load the inertia parameters for D415

%% height of the object
height = 22; % wooden block ( 76.2 mm) acrylic square (23 mm) steel part (17mm) plastic plate (22mm)
%% color_threshold_BRIO Pink
RL1 = 100;
RU1 = 255;
GL1 = 0;
GU1 = 100;
BL1 = 0;
BU1 = 255;
Threshold_Brio = [RL1, RU1, GL1, GU1, BL1, BU1];

%% color_threshold_D415 Pink
RL2 = 127;
RU2 = 255;
GL2 = 0;
GU2 = 140;
BL2 = 93;
BU2 = 255;
Threshold_D415 = [RL2, RU2, GL2, GU2, BL2, BU2];




%% Brio camera webcam setup
Brio = videoinput('winvideo', 4, 'MJPG_1920x1080');
src_Brio = getselectedsource(Brio);
triggerconfig(Brio, 'manual');
Brio.FramesPerTrigger = 300;
Brio.LoggingMode = 'memory';

src_Brio.WhiteBalanceMode = 'manual';
src_Brio.WhiteBalance = 2800;
src_Brio.Exposure = -7;
src_Brio.ExposureMode = 'manual';
src_Brio.Focus = 0;
src_Brio.FocusMode = 'manual';
src_Brio.FrameRate = '60.0002';
src_Brio.Zoom = 100;

%% D415 camera webcam setup
D415 = videoinput('winvideo', 3, 'YUY2_640x480');
src_D415 = getselectedsource(D415);
triggerconfig(D415, 'manual');
D415.FramesPerTrigger = 300;
D415.ReturnedColorspace = 'rgb';
D415.LoggingMode = 'memory';

src_D415.WhiteBalanceMode = 'manual';
src_D415.WhiteBalance = 2800;
src_D415.Exposure = -7;
src_D415.ExposureMode = 'manual';
src_D415.FrameRate = '60.0002';

%% start pipeline
flag = 0; % Stopping flags
index = 21; % idex 


while flag == 0
     
     start(Brio);
     start(D415);
     % gathering data
     prompt = 'Start experiment? You have 5 s';
     x = input(prompt);
     trigger(Brio);
     trigger(D415);
     [data_Brio,time_Brio,metadata_Brio] = getdata(Brio);
     [data_D415,time_D415,metadata_D415] = getdata(D415);
     

     prompt2 = ('Times up! Do you want to process? Yes (1), No (2)');
     z = input(prompt2);
     if z == 2
        continue;
     end
     % process data
    for i = 1:size(data_Brio,4)
        I1 = data_Brio(:,:,:,i);
        I2 = undistortImage(I1,Brio_param.Intrinsics,"OutputView","same");
        Frame_Brio{i} = imrotate(I2,180);
    end
    for i = 1:size(data_D415,4)
        I1 = data_D415(:,:,:,i);
        I2 = undistortImage(I1,D415_param.Intrinsics,"OutputView","same");
        Frame_D415{i} = I2;
    end

     % compute and plot the results
     [Position_Brio, Theta_Brio,~, ~]= color_pose(Frame_Brio, Brio_param, Threshold_Brio, height);
     [Position_D415, Theta_D415,~, ~]= color_pose(Frame_D415, D415_param, Threshold_D415, height);
     
     [Solution_Brio, Solution_D415,N_start,N_end_Brio,N_end_D415] = preprocess_2cameras(Position_Brio, Theta_Brio,time_Brio,metadata_Brio, Position_D415, Theta_D415,time_D415,metadata_D415);
     N_D415 = size(Solution_D415.Timestamp,2)
     prompt3 = 'Continue and save (1), without saving (2) or end (3)?';
     y = input(prompt3);
     if y == 1
         flag = 0;
         % set up the file names
         Data_D415.Frame = Frame_D415{N_start:N_end_D415};
         Data_D415.time = time_D415(N_start:N_end_D415) - time_D415(N_start);
     
         Data_Brio.Frame = Frame_Brio{N_start:N_end_Brio};
         Data_Brio.time = time_Brio(N_start:N_end_Brio) - time_Brio(N_start);
     
         data_index = num2str(index);
         
         solution_name_D415 = strcat('D415_solution_',data_index,'.mat');
         data_name_D415 = strcat('D415_data_',data_index,'.mat');
         save(solution_name_D415,'Solution_D415');
         save(data_name_D415,'Data_D415');
         
         solution_name_Brio = strcat('Brio_solution_',data_index,'.mat');
         data_name_Brio = strcat('Brio_data_',data_index,'.mat');
         save(solution_name_Brio,'Solution_Brio');
         save(data_name_Brio,'Data_Brio');
         
         index = index +1;
     elseif y == 2
         flag = 0;
     else
         flag = 1;
     end
     close all
end

delete(Brio);
delete(D415);
clear Brio
clear D415 




