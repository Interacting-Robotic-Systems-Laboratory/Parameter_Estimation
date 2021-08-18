clear all
close all

%% load intrinsic and extrinsic parameters
addpath('utility');
load('HD_10_9.mat'); % load the inertia parameters for brio
load('D415_10_9.mat'); % load the inertia parameters for D415


%% color_threshold_HD Pink
RL1 = 166;
RU1 = 255;
GL1 = 0;
GU1 = 151;
BL1 = 133;
BU1 = 255;
Threshold_HD = [RL1, RU1, GL1, GU1, BL1, BU1];

%% color_threshold_D415 Pink
RL2 = 134;
RU2 = 255;
GL2 = 0;
GU2 = 106;
BL2 = 93;
BU2 = 255;
Threshold_D415 = [RL2, RU2, GL2, GU2, BL2, BU2];


%% define parameters
tagsize = 48.7e-3; %m 
unit_length = 2*25.4; % mm
unit_angle = 360; %degree
L_X = 34*25.4; % mm
L_Y = 22*25.4; % mm
height = -2; %mm
M = 9;
N = 9;


%% initialize the output
Ground_truth = zeros(M,N,1);
Brio_mean = zeros(M,N,1);
Brio_std = zeros(M,N,1);
D415_mean = zeros(M,N,1);
D415_std = zeros(M,N,1);

%% generate ground truth
for i = 1:M
    for j = 1:N
        Ground_truth(i,j,1) = (j-1)*20-80; 
    end
end
%% compute the result
for i = 9:9
    for j = 1:N

        Save = 0;
        while Save == 0
            prompt1 = 'Start? ';
            X = input(prompt1);
            [brio_mean, brio_std, d415_mean, d415_std] = ground_truth_varify(HD_param, D415_param,Threshold_HD,Threshold_D415,Ground_truth(i,j,:));
            brio_mean(4) 
            d415_mean(4) 
            %ground_truth = [Ground_truth(i,j,1),Ground_truth(i,j,2),Ground_truth(i,j,3),Ground_truth(i,j,4)]
            ground_truth = (j-1)*20-80
            prompt = 'Do you like the plot? 1-Y 2-N';
            x = input(prompt);
            if x ~= 1
                Save = 0;
            else
                Save = 1;  
                A = num2str(i); B = num2str(j);
                C = strcat(A,'_');
                D = strcat(C,B);
                E = strcat(D,'.fig');
                saveas(gcf,E)
            end
            close all
        end
        Brio_mean(i,j,:) = brio_mean(4);
        Brio_std(i,j,:) = brio_std(4);
        D415_mean(i,j,:) = d415_mean(4);
        D415_std(i,j,:) = d415_std(4);
        save('Brio_mean_angle.mat','Brio_mean');
        save('Brio_std_angle.mat','Brio_std');
        save('D415_mean_angle.mat','D415_mean');
        save('D415_std_angle.mat','D415_std');
        
    end
end
