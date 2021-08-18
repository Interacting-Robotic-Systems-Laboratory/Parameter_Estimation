function Q_p = GP_predict_trajectory(S, Data)
N_2 = S.Estimation_window(2); % the end index of estimation window
T = Data.T;
q_x = Data.q(1,:);
q_y = Data.q(2,:);
theta = Data.q(3,:);

N_end = length(T);
Q_p = NaN(3,length(T));

%% choose the smooth method 
method = 'pureQuadratic'; % 'linear' 'pureQuadratic' 'constant' 'raw'

%% smooth the "observed" raw data 
X = T(1:N_2)';
X_p = T(N_2+1:N_end)';

Y1 = q_x(1:N_2)';
Y2 = q_y(1:N_2)';
Y3 = theta(1:N_2)';


% smooth q_x 
gprMd1 = fitrgp(X,Y1,'Basis',method,'FitMethod','exact','PredictMethod','exact');
[Q_p(1,N_2+1:N_end),~,~] = predict(gprMd1,X_p);

% smooth q_y 
gprMd2 = fitrgp(X,Y2,'Basis',method,'FitMethod','exact','PredictMethod','exact');
[Q_p(2,N_2+1:N_end),~,~] = predict(gprMd2,X_p);

% smooth theta
gprMd3 = fitrgp(X,Y3,'Basis',method,'FitMethod','exact','PredictMethod','exact');
[Q_p(3,N_2+1:N_end),~,~] = predict(gprMd3,X_p);






end