clear all
close all

addpath('utility');
%% load intrinsic and extrinsic parameters
load('HD_10_30.mat'); % load the inertia parameters 
%% color_threshold_BRIO Pink
RL1 = 100;
RU1 = 255;
GL1 = 0;
GU1 = 100;
BL1 = 0;
BU1 = 255;
Threshold_Brio = [RL1, RU1, GL1, GU1, BL1, BU1];
%% height of the object
height = 76.2; % wooden block ( 76.2 mm) acrylic square (23 mm)

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


%% start pipeline
flag = 0; % Stopping flags

start(Brio);
while flag == 0
     prompt = 'Start experiment? You have 5 s';
     x = input(prompt);
     
     % gathering data
     trigger(Brio);
     [data_Brio,time_Brio,~] = getdata(Brio);
     
     disp('Times up! Start processing!');
     % process data
    for i = 1:size(data_Brio,4)
        I1 = data_Brio(:,:,:,i);
        I2 = undistortImage(I1,Brio_param.Intrinsics,"OutputView","same");
        Frame_Brio{i} = imrotate(I2,180);
    end
     [Position_Brio, Theta_Brio,~, ~]= color_pose(Frame_Brio, Brio_param, Threshold_Brio, height);
     solution = preprocess(Position_Brio, Theta_Brio,time_Brio);
     prompt3 = 'Continue (1) or end (2)?';
     y = input(prompt3);
     if y == 1
         flag = 0;
     else
         flag = 1;
     end
     close all
end


delete(Brio);
clear Brio 
