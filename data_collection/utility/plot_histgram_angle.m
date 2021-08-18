function plot_histgram_angle(Theta_brio,Theta_D415,Ground_truth)
Theta_ground = Ground_truth;

figure
histogram(Theta_brio,'FaceColor','b');
hold on
histogram(Theta_D415,'FaceColor','y');
hold on
line([Theta_ground Theta_ground], [0 30],'Color','red','LineWidth',2);
legend('HD','D415','Truth')
title('Orientation (degree)')



end