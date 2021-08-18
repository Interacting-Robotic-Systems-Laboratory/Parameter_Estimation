function Data = preprocess(T,q_x,q_y,theta)
Timestamp = T;
N_t = size(Timestamp,2);
N_start = 2; 

%% deal with issues with timestamps
% The timestamps in two contiguous steps (i-1 and i) can be the same. If this
% error happens, we shift the second timestamp i by dh. The dh supposes to
% be the difference between steps i-1 and i. We aproximate the dh by the
% neighbouring steps (i-2, i-1) and (i, i+1).
for i = 2:N_t
    if Timestamp(i)-Timestamp(i-1) == 0
        disp('error in timestamp!');
        if i == 2
            dh = Timestamp(3) - Timestamp(2);
            Timestamp(i:end) = Timestamp(i:end) + dh;
          
        elseif (2 < i)&&(i <= (N_t-1))
            dh1 = Timestamp(i-1)-Timestamp(i-2);
            dh2 = Timestamp(i+1)-Timestamp(i);
            dh = (dh1+dh2)/2;
            Timestamp(i:end) = Timestamp(i:end)+dh;                     
        else
            dh = Timestamp(i-1)-Timestamp(i-2);
            Timestamp(i:end) = Timestamp(i:end)+dh;
        end
    end
end



%% deal with jump in theta
% We transform the theta from [-pi/2 pi/2] to []. We define the
% threshold = pi/2 for maximum allwed orientation jumps.
theta = theta*(pi/180);
threshold = pi/2; 
for i = 1:N_t-1
    if theta(i+1)-theta(i) >= threshold
        theta(i+1:end) = theta(i+1:end)-pi;
    elseif theta(i+1)-theta(i)<= -threshold
        theta(i+1:end) = theta(i+1:end)+pi; 
    end
end

%% dealing with NaN value
% In step i, the value in q_x, q_y, theta may be NaN. We can replace the value by the
% mean value of i-1 and i+1.
for i = 1:N_t
    if isnan(theta(i))||isnan(q_x(i))||isnan(q_y(i))
        if i == 1
            if isnan(q_x(i))
                q_x(1) = q_x(3) - 2*q_x(2);
                 disp('NaN error in raw data of q_x');
            end
            if isnan(q_y(i))
                 q_y(1) = q_y(3) - 2*q_y(2);
                 disp('NaN error in raw data of q_y');
            end
            if isnan(theta(i))
                theta(1) = theta(3) - 2*theta(2);
                disp('NaN error in raw data of theta');
            end
            
             
        elseif i == N_t
            
            if isnan(q_x(i))
                q_x(N_t) = q_x(N_t-2) + 2*q_x(N_t-1);
                disp('verror in raw data of q_x');
            end
            if isnan(q_y(i))
                q_y(N_t) = q_y(N_t-2) + 2*q_y(N_t-1);
                disp('NaN error in raw data of q_y');
            end
            if isnan(theta(i))
                theta(N_t) = theta(N_t-2) + 2*theta(N_t-1);
                disp('NaN error in raw data of theta');
            end
                      
        else
            if isnan(q_x(i))
                q_x(i) = (q_x(i+1) + q_x(i-1))/2;
                disp('NaN error in raw data of q_x');
            end
            if isnan(q_y(i))
                q_y(i) = (q_y(i+1) + q_y(i-1))/2;
                disp('NaN error in raw data of q_y');
            end
            if isnan(theta(i))
                theta(i) = (theta(i+1) + theta(i-1))/2;
                disp('NaN error in raw data of theta');
            end
        end
       
    end
end

%% determine the frame that object stop sliding (N_end)
d_x = abs(q_x(2:end) - q_x(1:end-1));
d_y = abs(q_y(2:end) - q_y(1:end-1));
d = sqrt(d_x.^2+d_y.^2);
d = [Inf,d];
threshold = 5e-4;
for i = 1:N_t
    if d(i) <= threshold
        if (i<=N_t-1)&&(d(i+1)>=threshold)
            disp('error in raw data, needs filtering');
        else
            N_end = i;
            break;
        end
    end
    N_end = i;
end

%% return the raw data
q = [q_x(N_start:N_end);q_y(N_start:N_end);theta(N_start:N_end)];

Data.T = T(N_start:N_end);

v = zeros(3,N_end-N_start+1);
v(:,1) = [q_x(2)-q_x(1);q_y(2)-q_y(1);theta(2)-theta(1)]./(T(2)- T(1));

v(:,2:end) = [q_x(N_start+1:N_end)-q_x(N_start:N_end-1);q_y(N_start+1:N_end)-q_y(N_start:N_end-1);...
    theta(N_start+1:N_end)-theta(N_start:N_end-1)]./(Data.T(2:end)- Data.T(1:end-1));
Data.q = q;
Data.v = v;




end