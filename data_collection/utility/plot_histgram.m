function plot_histgram(Position_brio, Theta_brio, Position_D415, Theta_D415,Ground_truth)
Theta_ground = Ground_truth(4);
qx_ground = Ground_truth(1);
qy_ground = Ground_truth(2);
qz_ground = Ground_truth(3);
figure
subplot(2,2,1)
histogram(Theta_brio,'FaceColor','b');
hold on
histogram(Theta_D415,'FaceColor','y');
hold on
line([Theta_ground Theta_ground], [0 30],'Color','red','LineWidth',2);
legend('HD','D415','Truth')
title('Orientation (degree)')

subplot(2,2,2)
histogram(Position_brio(:,1),'FaceColor','b');
hold on
histogram(Position_D415(:,1),'FaceColor','y');
hold on
line([qx_ground qx_ground], [0 30],'Color','red','LineWidth',2);
legend('HD','D415','Truth')
title('Position q_x (mm)')

subplot(2,2,3)
histogram(Position_brio(:,2),'FaceColor','b');
hold on
histogram(Position_D415(:,2),'FaceColor','y');
hold on
line([qy_ground qy_ground], [0 30],'Color','red','LineWidth',2);
legend('HD','D415','Truth')
title('Position q_y (mm)')

subplot(2,2,4)
histogram(Position_brio(:,3),'FaceColor','b');
hold on
histogram(Position_D415(:,3),'FaceColor','y');
hold on
line([qz_ground qz_ground], [0 30],'Color','red','LineWidth',2);
legend('HD','D415','Truth')

title('Position q_z (mm)')


end