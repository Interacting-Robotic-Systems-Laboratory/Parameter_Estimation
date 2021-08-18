function [q_f_est, v_f_est, Data] = smooth(S, Data,flag)
N_2 = S.Estimation_window(2); % the end index of estimation window
T = Data.T;
q_x = Data.q(1,:);
q_y = Data.q(2,:);
theta = Data.q(3,:);
%% choose the smooth method 
method = 'pureQuadratic'; % 'linear' 'pureQuadratic' 'constant' 'raw'

%% smooth the "observed" raw data 
X1 = T(1:N_2)';
Y1 = q_x(1:N_2)';

X2 = T(1:N_2)';
Y2 = q_y(1:N_2)';

X3 = T(1:N_2)';
Y3 = theta(1:N_2)';

if  strcmp(method,'raw')
    Q_fx = Y1;
    Q_fy = Y2;
    Q_ftheta = Y3;
else
    % smooth q_x 
    gprMd1 = fitrgp(X1,Y1,'Basis',method,'FitMethod','exact','PredictMethod','exact');
    [Q_fx,~,~] = predict(gprMd1,X1);
    
    % smooth q_y 
    gprMd2 = fitrgp(X2,Y2,'Basis',method,'FitMethod','exact','PredictMethod','exact');
    [Q_fy,~,~] = predict(gprMd2,X2);
    
    % smooth theta
    gprMd3 = fitrgp(X3,Y3,'Basis',method,'FitMethod','exact','PredictMethod','exact');
    [Q_ftheta,~,~] = predict(gprMd3,X3);
end


V_fx = (Q_fx(2:end) - Q_fx(1:end-1))./(T(2:N_2)'-T(1:N_2-1)');

V_fy = (Q_fy(2:end) - Q_fy(1:end-1))./(T(2:N_2)'-T(1:N_2-1)');


W_fz = (Q_ftheta(2:end) - Q_ftheta(1:end-1))./(T(2:N_2)'-T(1:N_2-1)');

q_f_est = [Q_fx';Q_fy';Q_ftheta'];
v_f_est = NaN(3,N_2);
v_f_est(:,2:end) = [V_fx';V_fy';W_fz'];


%% smooth the entire raw data 
if (flag == 1) % the flag determine whether to smooth the entire raw data
    if strcmp(method,'raw')
        Data.q_f = Data.q;
        Data.v_f = Data.v;
    else  
        X1 = T';
        Y1 = q_x';
        gprMd1 = fitrgp(X1,Y1,'Basis',method,'FitMethod','exact','PredictMethod','exact');
        % smooth q_x 
        [Q_f,~,~] = predict(gprMd1,X1);
        Q_x = Q_f(1:end);
        V_fx = (Q_f(2:end) - Q_f(1:end-1))./(T(2:end)-T(1:end-1))';

        X2 = T';
        Y2 = q_y';
        gprMd2 = fitrgp(X2,Y2,'Basis',method,'FitMethod','exact','PredictMethod','exact');
        % smooth q_y 
        [Q_f,~,~] = predict(gprMd2,X2);
        Q_y = Q_f(1:end);
        V_fy = (Q_f(2:end) - Q_f(1:end-1))./(T(2:end)-T(1:end-1))';

        X3 = T';
        Y3 = theta';
        gprMd3 = fitrgp(X3,Y3,'Basis',method,'FitMethod','exact','PredictMethod','exact');
        % smooth theta 
        [Q_f,~,~] = predict(gprMd3,X1);
        Theta = Q_f(1:end);
        W_fz = (Q_f(2:end) - Q_f(1:end-1))./(T(2:end)-T(1:end-1))';

        Data.q_f = [Q_x';Q_y';Theta'];

        v_f = NaN(3,size(T,2));
        v_f(:,2:end) = [V_fx';V_fy';W_fz'];
        Data.v_f = v_f;
    end
end
end