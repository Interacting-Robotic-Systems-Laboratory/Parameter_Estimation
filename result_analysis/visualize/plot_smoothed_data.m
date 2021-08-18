function h = plot_smoothed_data(Data)
T = Data.T;
q_x = Data.q(1,:);
q_y = Data.q(2,:);
theta = (180/pi)*Data.q(3,:);

v_x = Data.v(1,:);
v_y = Data.v(2,:);
w = (180/pi)*Data.v(3,:);


q_x_f = Data.q_f(1,:);
q_y_f = Data.q_f(2,:);
theta_f = (180/pi)*Data.q_f(3,:);

v_x_f = Data.v_f(1,:);
v_y_f = Data.v_f(2,:);
w_f = (180/pi)*Data.v_f(3,:);


h = figure;
h.Position = [100 100 2*560 3*420/2];
sgtitle(Data.Name);
subplot(3,2,1)
plot(T,q_x,'r.',T,q_x_f,'b.');
xlabel('Time (s)');
ylabel('Position q_x (m)');
legend('raw data','filtered data');
title('Raw data analysis (position)')
subplot(3,2,3)
plot(T,q_y,'r.',T,q_y_f,'b.');
xlabel('Time (s)');
ylabel('Position q_y (m)');
legend('raw data','filtered data');
subplot(3,2,5)
plot(T,theta,'r.',T,theta_f,'b.');
xlabel('Time (s)');
ylabel('Orientation Theta (degree)');
legend('raw data','filtered data');



subplot(3,2,2)
plot(T,v_x,'r.',T,v_x_f,'b.');
xlabel('Time (s)');
ylabel('Velocity v_x (m/s)');
legend('raw data','filtered data');
title('Raw data analysis (velocity)')
subplot(3,2,4)
plot(T,v_y,'r.',T,v_y_f,'b.');
xlabel('Time (s)');
ylabel('Velocity v_y (m/s)');
legend('raw data','filtered data');
subplot(3,2,6)
plot(T,w,'r.',T,w_f,'b.');
xlabel('Time (s)');
ylabel('Angular velocity w_z (degree/s)');
legend('raw data','filtered data');

end