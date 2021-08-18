function [h1] = plot_Error_total_2(Error)
for i = 1:20
   mean_FW_UKF_Err_T(:,i) = Error.w{i}.mean_FW_UKF_Err_T;
   mean_SW_CL_Err_T(:,i) = Error.w{i}.mean_SW_CL_Err_T;
   
 
   CI_95_FW_UKF_Err_T(:,i) = Error.w{i}.CI_95_FW_UKF_Err_T;
   CI_95_SW_CL_Err_T(:,i) = Error.w{i}.CI_95_SW_CL_Err_T;
   
end

h1 = figure;
%h.Position = [100 100 2*560 2*420/2];
T = [5 10 15 20];
subplot(2,1,1)
y = [mean_FW_UKF_Err_T(1,T)' mean_SW_CL_Err_T(1,T)'];
b = bar(T,y);
b(1).FaceColor = [0 0 0];
b(1).FaceAlpha = 0.5;
b(2).FaceColor = [0 0 0];
b(2).FaceAlpha = 0.3;
hold on

n = size(y,2);
x = [];
for i = 1:n
    x = [x ; b(i).XEndPoints];
end
std_y = [CI_95_FW_UKF_Err_T(1,T)' CI_95_SW_CL_Err_T(1,T)' ];

errorbar(x,y',std_y','k','LineStyle', 'none');    
                          
xlim([2 23]);
ylim([0 30]);
grid on
lgd = legend('UKF','CL','Location','northwest');
lgd.NumColumns = 1;
xlabel('Prediction Window Steps');
ylabel('Position Error (mm)');



subplot(2,1,2)
y = [mean_FW_UKF_Err_T(2,T)' mean_SW_CL_Err_T(2,T)' ];
b = bar(T,y);
hold on
b(1).FaceColor = [0 0 0];
b(1).FaceAlpha = 0.5;
b(2).FaceColor = [0 0 0];
b(2).FaceAlpha = 0.3;

n = size(y,2);
x = [];
for i = 1:n
    x = [x ; b(i).XEndPoints];
end
std_y = [CI_95_FW_UKF_Err_T(2,T)' ...
    CI_95_SW_CL_Err_T(2,T)' ];

errorbar(x,y',std_y','k','LineStyle', 'none');    

xlim([2 23]);
ylim([0 30]);
grid on
lgd = legend('UKF','CL','Location','northwest');
lgd.NumColumns = 1;


xlabel('Prediction window steps');
ylabel('Orientation (degree)');



end