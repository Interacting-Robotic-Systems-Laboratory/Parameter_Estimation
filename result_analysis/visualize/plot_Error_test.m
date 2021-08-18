function [h1] = plot_Error_test(WB_Error, ST_Error, PL_Error, ...
WB_offline, ST_offline, PL_offline)

d1 = 2;
d2 = 2;
for i = 1:20
   WB_mean_Err_T(:,i) = WB_Error.w{i}.mean_FW_UKF_Err_T;
   ST_mean_Err_T(:,i) = ST_Error.w{i}.mean_FW_UKF_Err_T;
   PL_mean_Err_T(:,i) = PL_Error.w{i}.mean_FW_UKF_Err_T;
   WB_CI_95(:,i) = WB_Error.w{i}.CI_95_FW_UKF_Err_T;
   ST_CI_95(:,i) = ST_Error.w{i}.CI_95_FW_UKF_Err_T;
   PL_CI_95(:,i) = PL_Error.w{i}.CI_95_FW_UKF_Err_T;
end
WB_offline_mean = WB_offline.Mean;
ST_offline_mean = ST_offline.Mean;
PL_offline_mean = PL_offline.Mean;

WB_offline_CI_95 = WB_offline.CI_95;
ST_offline_CI_95 = ST_offline.CI_95;
PL_offline_CI_95 = PL_offline.CI_95;

h1 = figure;

T = [5 10 15 20];

subplot(2,1,1)
y1 = [WB_offline_mean(1,T)', ST_offline_mean(1,T)', PL_offline_mean(1,T)'];
y2 = [WB_mean_Err_T(1,T)', ST_mean_Err_T(1,T)', PL_mean_Err_T(1,T)'];

b1 = bar(T,y1,0.5,'w','LineWidth',1);
hold on
b2 = bar(T,y2,0.25,'k','FaceAlpha',.3,'LineWidth',1);
hold on

n = size(y1,2);
x1 = [];
for i = 1:n
    x1 = [x1 ; b1(i).XEndPoints];
end

std_y1 = [WB_offline_CI_95(1,T)' ST_offline_CI_95(1,T)' PL_offline_CI_95(1,T)'];
errorbar(x1,y1',std_y1','k','LineStyle', 'none','CapSize',8);    

n = size(y2,2);
x2 = [];
for i = 1:n
    x2 = [x2 ; b2(i).XEndPoints];
end

std_y2 = [WB_CI_95(1,T)' ST_CI_95(1,T)' PL_CI_95(1,T)'];
errorbar(x2,y2',std_y2','k','LineStyle', 'none','CapSize',4);    


xtips1 = b1(1).XEndPoints;
ytips1 = max(b1(1).YEndPoints, b2(1).YEndPoints)+d1;
labels1 ='WB';
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

xtips2 = b1(2).XEndPoints;
ytips2 =  max(b1(2).YEndPoints, b2(2).YEndPoints)+d1;
labels2 ='ST';
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

xtips3 = b2(3).XEndPoints;
ytips3 =  max(b1(3).YEndPoints, b2(3).YEndPoints)+d1;
labels3 ='PL';
text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

xlim([2 23]);
xticks([5 10 15 20 ]);
xticklabels({'5 steps (0.083 s)','10 steps (0.166 s)','15 steps (0.25 s)','20 steps (0.333 s)'});
ylim([0 30]);
grid on
hold off
lgd = legend([b1(1), b2(1)],{'Offline','Online (UKF)'},'Location','northwest');
lgd.NumColumns = 1;
xlabel('Prediction window steps');
ylabel('RMSE in translation (mm)');



subplot(2,1,2)
y1 = [WB_offline_mean(2,T)', ST_offline_mean(2,T)', PL_offline_mean(2,T)'];
y2 = [WB_mean_Err_T(2,T)', ST_mean_Err_T(2,T)', PL_mean_Err_T(2,T)'];

b1 = bar(T,y1,0.5,'w','LineWidth',1);
hold on
b2 = bar(T,y2,0.25,'k','FaceAlpha',.3,'LineWidth',1);
hold on

n = size(y1,2);
x1 = [];
for i = 1:n
    x1 = [x1 ; b1(i).XEndPoints];
end

std_y1 = [WB_offline_CI_95(2,T)' ST_offline_CI_95(2,T)' PL_offline_CI_95(2,T)'];
errorbar(x1,y1',std_y1','k','LineStyle', 'none','CapSize',8);    

n = size(y2,2);
x2 = [];
for i = 1:n
    x2 = [x2 ; b2(i).XEndPoints];
end

std_y2 = [WB_CI_95(2,T)' ST_CI_95(2,T)' PL_CI_95(2,T)'];
errorbar(x2,y2',std_y2','k','LineStyle', 'none','CapSize',4);    

xtips1 = b1(1).XEndPoints;
ytips1 =  max(b1(1).YEndPoints, b2(1).YEndPoints)+d2;
labels1 ='WB';
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

xtips2 = b1(2).XEndPoints;
ytips2 =  max(b1(2).YEndPoints, b2(2).YEndPoints)+d2;
labels2 ='ST';
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

xtips3 = b2(3).XEndPoints;
ytips3 =  max(b1(3).YEndPoints, b2(3).YEndPoints)+d2;
labels3 ='PL';
text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

xlim([2 23]);
xticks([5 10 15 20 ]);
xticklabels({'5 steps (0.083 s)','10 steps (0.166 s)','15 steps (0.25 s)','20 steps (0.333 s)'});
ylim([0 20]);
grid on
hold off
lgd = legend([b1(1), b2(1)],{'Offline','Online (UKF)'},'Location','northwest');
lgd.NumColumns = 1;

xlabel('Prediction window steps');
ylabel('RMSE in rotation (degree)');



end