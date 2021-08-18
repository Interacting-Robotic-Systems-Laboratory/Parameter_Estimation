function solution = preprocess(Position, Theta,time)
solution = struct();
N = size(Theta,1);


n_ignore = 5;

%% deal with jump in theta
for i = 2:N
    if Theta(i)-Theta(i-1) >= 90
        Theta(i:end) = Theta(i:end)-180;
    elseif Theta(i)-Theta(i-1) <= -90
        Theta(i:end) = Theta(i:end)+180;
    end
end

%% deal with initial points in the trajectory
start_point = find(~isnan(Theta),1);

start = start_point + n_ignore;

q_x =  Position(start:end,1);
q_y =  Position(start:end,2);
theta = Theta(start:end);

Pose = [Position(start:end,1:2),Theta(start:end)];
Time = time(start:end) - time(start);

solution.q_x = q_x'/1000;
solution.q_y = q_y'/1000;
solution.theta = theta';

solution.Timestamp = Time';

%% deal with jumps in time stamp
h = Time(2:end) - Time(1:end-1);
h_median = median(h);
N_h = length(h);
for i = 1:N_h
    if h(i) >= 1.1*h_median
        diff = h(i) - h_median;
        h(i) = h_median;
        Time(i+1:end) = Time(i+1:end) - diff;
    elseif h(i) <= 0.9*h_median
        diff = h(i) - h_median;
        h(i) = h_median;
        Time(i+1:end) = Time(i+1:end) - diff;
    end
end
%% plot the pose
figure
subplot(3,1,1)
plot(Time,Pose(:,1),'b.');
xlabel('Time (s)');
ylabel('Position (m)');
subplot(3,1,2)
plot(Time,Pose(:,2),'b.');
xlabel('Time (s)');
ylabel('Position (m)')
subplot(3,1,3)
plot(Time,Pose(:,3),'b.');
xlabel('Time (s)');
ylabel('Orientation (degree)')

%% plot the velocity

v_x = (Pose(2:end,1) - Pose(1:end-1,1))./h;
v_y = (Pose(2:end,2) - Pose(1:end-1,2))./h;
w = (Pose(2:end,3) - Pose(1:end-1,3))./h;


figure
subplot(3,1,1)
plot(Time(2:end),v_x,'b.');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
subplot(3,1,2)
plot(Time(2:end),v_y,'b.');
xlabel('Time (s)');
ylabel('Velocity (m/s)')
subplot(3,1,3)
plot(Time(2:end),w,'b.');
xlabel('Time (s)');
ylabel('Angular Velocity (degree/s)')

end