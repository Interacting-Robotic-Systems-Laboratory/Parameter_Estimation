function plot_trajectory(position, Theta)

figure
subplot(3,1,1)
plot(Theta);
title('Orientation (degree)')
subplot(3,1,2)
plot(position(:,1));
title('Position q_x (mm)')
subplot(3,1,3)
plot(position(:,2));
title('Position q_y (mm)')
end