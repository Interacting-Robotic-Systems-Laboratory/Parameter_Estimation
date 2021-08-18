clear all
close all

addpath('utility');
%% load intrinsic and extrinsic parameters
load('D415_10_9.mat'); % load the inertia parameters for D415

%% height of the object
height = 76.2; % wooden block (mm)
%% color_threshold_D415 Pink
RL2 = 154;
RU2 = 255;
GL2 = 0;
GU2 = 93;
BL2 = 0;
BU2 = 255;
Threshold_D415 = [RL2, RU2, GL2, GU2, BL2, BU2];


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

index = 1; % idex 
while flag == 0
     prompt = 'Start experiment? You have 5 s';
     x = input(prompt);
     start(D415);
     % gathering data
     trigger(D415);
     [data_D415,time_D415,~] = getdata(D415);

     disp('Times up! Start processing!');
     % compute and plot the results
     for i = 1:size(data_D415,4)
        Frame_D415{i} = data_D415(:,:,:,i);
     end
     [Position_D415, Theta_D415,~, ~]= color_pose(Frame_D415,D415_param,Threshold_D415,height);
     solution_D415 = preprocess(Position_D415, Theta_D415,time_D415);
     prompt3 = 'Continue and save (1), without saving (2) or end (3)?';
     y = input(prompt3);
     if y == 1
         flag = 0;
         % set up the file names
         data_index = num2str(index);
         solution_name = strcat('D415_solution_',data_index,'.mat');
         data_name = strcat('D415_data_',data_index,'.mat');
         save(solution_name,'solution_D415');
         save(data_name,'data');
         index = index +1;
     elseif y == 2
         flag = 0;
     else
         flag = 1;
     end
     close all
end


delete(D415);
clear D415 
