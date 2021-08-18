clear all
close all
load('Brio_mean_angle.mat');
load('D415_mean_angle.mat');
%% compare the ground truth with obervation
for i = 1:9
    for j = 1:9
        Ground_truth(i,j,1) = (j-1)*20-80; 
    end
end

Diff_D415 = (D415_mean-Ground_truth);
Diff_Brio = (Brio_mean-Ground_truth);
Diff_D415 = reshape(Diff_D415, [81,1]);
std_D415 = std(Diff_D415);
histogram(Diff_D415,'FaceColor','yellow')
hold on
histogram(Diff_Brio,'FaceColor','green')
legend('D415','Brio')
title('Orientation (Degree)')