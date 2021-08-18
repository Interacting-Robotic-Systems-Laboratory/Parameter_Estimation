function [solution_Brio, solution_D415,start,N_end_Brio,N_end_D415] = preprocess_2cameras(Position_Brio, Theta_Brio,time_Brio,metadata_Brio, Position_D415, Theta_D415,time_D415,metadata_D415)

solution_Brio = struct();
solution_D415 = struct();
N_Brio = size(Theta_Brio,1);
N_D415 = size(Theta_D415,1);


n_ignore = 5;
%% synchronize
start_Brio = metadata_Brio(1).AbsTime(end);
start_D415 = metadata_D415(1).AbsTime(end);

diff = start_D415 - start_Brio;

if abs(diff) >=30
    diff = start_D415 + 60-start_Brio;
   
end

time_D415 = time_D415 - time_D415(1) + diff; % shift the time of D415
% time_D415 = 0: (time_D415(end))/300:time_D415(end);
% time_D415 = time_D415'+ diff;
%time_Brio = time_Brio - time_Brio(1); % shift the time of Brio
time_Brio = time_Brio(1):(time_Brio(end) - time_Brio(1))/299:time_Brio(end);
time_Brio = time_Brio' - time_Brio(1);

%% deal with jump in theta
for i = 2:N_Brio
    if Theta_Brio(i)-Theta_Brio(i-1) >= 90
        Theta_Brio(i:end) = Theta_Brio(i:end)-180;
    elseif Theta_Brio(i)-Theta_Brio(i-1) <= -90
        Theta_Brio(i:end) = Theta_Brio(i:end)+180;
    end
end

for i = 2:N_D415
    if Theta_D415(i)-Theta_D415(i-1) >= 90
        Theta_D415(i:end) = Theta_D415(i:end)-180;
    elseif Theta_D415(i)-Theta_D415(i-1) <= -90
        Theta_D415(i:end) = Theta_D415(i:end)+180;
    end
end

%% shift the theta
BRIO_theta_end = Theta_Brio(end);
D415_theta_end = Theta_D415(end);

if BRIO_theta_end - D415_theta_end >= 90
    Theta_D415 = Theta_D415 + 180;
elseif BRIO_theta_end - D415_theta_end <= -90
    Theta_D415 = Theta_D415 - 180;
end

%% deal with initial points in the trajectory
start_point_BRIO = find(~isnan(Theta_Brio),1);
start_point_D415 = find(~isnan(Theta_D415),1);

start = max(start_point_D415,start_point_BRIO) + n_ignore;

%% determine the frame that object stop sliding (N_end)
q_x_Brio = Position_Brio(start:end,1)'/1000;
q_y_Brio = Position_Brio(start:end,2)'/1000;

d_x_Brio = abs(q_x_Brio(2:end) - q_x_Brio(1:end-1));
d_y_Brio = abs(q_y_Brio(2:end) - q_y_Brio(1:end-1));
d_Brio = sqrt(d_x_Brio.^2+d_y_Brio.^2);
d_Brio = [Inf,d_Brio];
threshold = 5e-4;
N_t_Brio = length(time_Brio) - start;
for i = 1:N_t_Brio
    if d_Brio(i) <= threshold
        if (i<=N_t_Brio-1)&&(d_Brio(i+1)>=threshold)
            disp('error in raw data, needs filtering');
        else
            N_end_Brio = i + start;
            break;
        end
    end
    N_end_Brio = i + start;
end


q_x_D415 = Position_D415(start:end,1)'/1000;
q_y_D415 = Position_D415(start:end,2)'/1000;

d_x_D415 = abs(q_x_D415(2:end) - q_x_D415(1:end-1));
d_y_D415 = abs(q_y_D415(2:end) - q_y_D415(1:end-1));
d_D415 = sqrt(d_x_D415.^2+d_y_D415.^2);
d_D415 = [Inf,d_D415];

N_t_D415 = length(time_D415) - start;
for i = 1:N_t_D415
    if d_D415(i) <= threshold
        if (i<=N_t_D415-1)&&(d_D415(i+1)>=threshold)
            disp('error in raw data, needs filtering');
        else
            N_end_D415 = i + start;
            break;
        end
    end
    N_end_D415 = i + start;
end


%% return solution which ignore the initial points

Time_Brio = time_Brio(start:N_end_Brio) - time_Brio(start);
Time_D415 = time_D415(start:N_end_D415) - time_Brio(start);

solution_Brio.q_x =  Position_Brio(start:N_end_Brio,1)'/1000;
solution_Brio.q_y =  Position_Brio(start:N_end_Brio,2)'/1000;
solution_Brio.theta = Theta_Brio(start:N_end_Brio)';

solution_D415.q_x =  Position_D415(start:N_end_D415,1)'/1000;
solution_D415.q_y =  Position_D415(start:N_end_D415,2)'/1000;
solution_D415.theta = Theta_D415(start:N_end_D415)';

solution_Brio.Timestamp = Time_Brio';
solution_D415.Timestamp = Time_D415';


%% plot the pose
figure
subplot(3,1,1)
plot(Time_Brio,solution_Brio.q_x,'r.');
hold on
plot(Time_D415,solution_D415.q_x,'b.');
legend('BRIO','D415');
xlabel('Time (s)');
ylabel('Position (m)');
subplot(3,1,2)
plot(Time_Brio,solution_Brio.q_y,'r.');
hold on
plot(Time_D415,solution_D415.q_y,'b.');
legend('BRIO','D415');
xlabel('Time (s)');
ylabel('Position (m)')
subplot(3,1,3)
plot(Time_Brio,solution_Brio.theta,'r.');
hold on
plot(Time_D415,solution_D415.theta,'b.');
legend('BRIO','D415');
xlabel('Time (s)');
ylabel('Orientation (degree)')

%% plot the velocity
h_Brio = Time_Brio(2:end) - Time_Brio(1:end-1);
h_D415 = Time_D415(2:end) - Time_D415(1:end-1);

v_x_BRIO = (solution_Brio.q_x(2:end) - solution_Brio.q_x(1:end-1))./h_Brio';
v_y_BRIO = (solution_Brio.q_y(2:end) - solution_Brio.q_y(1:end-1))./h_Brio';
w_BRIO = (solution_Brio.theta(2:end) - solution_Brio.theta(1:end-1))./h_Brio';

v_x_D415 = (solution_D415.q_x(2:end) - solution_D415.q_x(1:end-1))./h_D415';
v_y_D415 = (solution_D415.q_y(2:end) - solution_D415.q_y(1:end-1))./h_D415';
w_D415 = (solution_D415.theta(2:end) - solution_D415.theta(1:end-1))./h_D415';


figure
subplot(3,1,1)
plot(Time_Brio(2:end),v_x_BRIO,'r.');
hold on
plot(Time_D415(2:end),v_x_D415,'b.');
legend('BRIO','D415');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
subplot(3,1,2)
plot(Time_Brio(2:end),v_y_BRIO,'r.');
hold on
plot(Time_D415(2:end),v_y_D415,'b.');
legend('BRIO','D415');
xlabel('Time (s)');
ylabel('Velocity (m/s)')
subplot(3,1,3)
plot(Time_Brio(2:end),w_BRIO,'r.');
hold on
plot(Time_D415(2:end),w_D415,'b.');
legend('BRIO','D415');
xlabel('Time (s)');
ylabel('Angular Velocity (degree/s)')

end