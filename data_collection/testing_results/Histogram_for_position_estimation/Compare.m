clear all
close all
load('Brio_mean.mat');
load('D415_mean.mat');
%% compare the ground truth with obervation
unit_length = 2*25.4;
for i = 1:15
    for j = 1:10
        Ground_truth_q_x(i,j) = (i-1)*unit_length+25.4*3.5; 
        Ground_truth_q_y(i,j) = (j-1)*unit_length-25.4*4.5; 
        Ground_truth_q_z(i,j) = 2;
    end
end

Diff_D415_x = (D415_mean(:,:,1)-Ground_truth_q_x);
Diff_Brio_x = (Brio_mean(:,:,1)-Ground_truth_q_x);

Diff_D415_x = reshape(Diff_D415_x, [150,1]);
std_D415_x = std(Diff_D415_x);

Diff_D415_y = (D415_mean(:,:,2)-Ground_truth_q_y);
Diff_Brio_y = (Brio_mean(:,:,2)-Ground_truth_q_y);

Diff_D415_y = reshape(Diff_D415_y, [150,1]);
std_D415_y = std(Diff_D415_y);

Diff_D415_z = (D415_mean(:,:,3)-Ground_truth_q_z);
Diff_Brio_z = (Brio_mean(:,:,3)-Ground_truth_q_z);

figure
histogram(Diff_D415_x,'FaceColor','yellow')
hold on
histogram(Diff_Brio_x,'FaceColor','green')
legend('D415','Brio')
title('Position q_x (mm)')

figure
histogram(Diff_D415_y,'FaceColor','yellow')
hold on
histogram(Diff_Brio_y,'FaceColor','green')
legend('D415','Brio')
title('Position q_y (mm)')

figure
histogram(Diff_D415_z,'FaceColor','yellow')
hold on
histogram(Diff_Brio_z,'FaceColor','green')
legend('D415','Brio')
title('Position q_z (mm)')
