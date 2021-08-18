clear all
close all
restoredefaultpath
%% add path
addpath('Utility');
addpath('export_fig-master');
addpath('offline_utility');

load('WB_para.mat');
load('ST_para.mat');
load('PL_para.mat');
range1 = [0 0.2];
range2 = 1*[0 0.3];
bitn1 = 0.008;
bitn2 = 1;
%% collect the params
WB = [];
ST = [];
PL = [];
for i = 1:60
    trial_WB = WB_para(:,:,i);
    trial_WB = cell2mat(trial_WB);

    param = trial_WB(1:3,trial_WB(4,:) == 1);
    %param = trial_WB(1:3,~isnan(trial_WB (4,:)));
    WB = [WB, param];
    
    trial_ST = ST_para(:,:,i);
    trial_ST = cell2mat(trial_ST);

    param = trial_ST(1:3,trial_ST(4,:) == 1);
    %param = trial_ST(1:3,~isnan(trial_ST(4,:)));
    ST = [ST, param];
    
    trial_PL = PL_para(:,:,i);
    trial_PL = cell2mat(trial_PL);

    param = trial_PL(1:3,trial_PL(4,:) == 1);
    %param = trial_PL(1:3,~isnan(trial_PL(4,:)));
    PL = [PL, param];
    
    
end

WB = WB(:,WB(1,:)<0.4 & WB(1,:)>0.15 & WB(2,:)<0.4 & WB(2,:)>0.15 & WB(3,:)<40e-3 & WB(3,:)>0);
ST = ST(:,ST(1,:)<0.4 & ST(1,:)>0.15 & ST(2,:)<0.4 & ST(2,:)>0.15 & ST(3,:)<40e-3 & ST(3,:)>0);
PL = PL(:,PL(1,:)<0.4 & PL(1,:)>0.15 & PL(2,:)<0.4 & PL(2,:)>0.15 & PL(3,:)<40e-3 & PL(3,:)>0);
%% plot the histogram for parameters WB

tcikh1 = figure;
subplot(3,1,1)
xline(0.234,'k-.','LineWidth',1.5);
hold on
xline(0.251,'k--','LineWidth',1.5);
histogram(real(WB(1,:)),'Normalization','probability','BinWidth',bitn1,'FaceColor','k','FaceAlpha',.3);
grid on
xlim([0.15 0.4]);
xticks([0.15 0.2 0.23 0.255 0.3 0.35 0.4 ]);
xticklabels({'0.15','0.2','\bf{0.234}','\bf{0.251}','0.3','0.35','0.4'});
hold on

ylim(range1);
ax = gca;
ax.FontSize = 12; 
legend('Median', 'Mean','FontSize',12)

xlabel(' \alpha of the wooden block ','FontSize',12);

subplot(3,1,2)
xline(0.231,'k-.','LineWidth',1.5)
hold on
xline(0.244,'k--','LineWidth',1.5)
histogram(real(WB(2,:)),'Normalization','probability','BinWidth',bitn1,'FaceColor','k','FaceAlpha',.3);
grid on
xlim([0.15 0.4]);
xticks([0.15 0.2 0.225 0.25 0.3 0.35 0.4 ]);
xticklabels({'0.15','0.2','\bf{0.231}','\bf{0.244}','0.3','0.35','0.4'});
hold on

ylim(range1);
ax = gca;
ax.FontSize = 12; 
legend('Median', 'Mean','FontSize',12)
xlabel(' \beta of the wooden block ','FontSize',12);

subplot(3,1,3)
xline(6.6,'k-.','LineWidth',1.5)
hold on
xline(8.3,'k--','LineWidth',1.5)

histogram(1000*real(WB(3,:)),'Normalization','probability','BinWidth',bitn2,'FaceColor','k','FaceAlpha',.3);
grid on
xlim([0 40]);
ylim(range2);
xlabel(' \gamma of the wooden block (mm)','FontSize',12);
xticks([0 6 8.5 15 20 25 30 35 40]);
xticklabels({'0','{\bf 6.6}','{\bf 8.3}','15','20','25','30','35','40'});
hold on


ax = gca;
ax.FontSize = 12; 
legend('Median', 'Mean','FontSize',12)
export_fig(h1,'param_WB.png','-m3.5','-transparent') ;

%% plot the histogram for parameters ST
h2 = figure;
subplot(3,1,1)
xline(0.315,'k-.','LineWidth',1.5)
hold on
xline(0.315,'k--','LineWidth',1.5)
histogram(real(ST(1,:)),'Normalization','probability','BinWidth',bitn1,'FaceColor','k','FaceAlpha',.3);
grid on
xlim([0.15 0.4]);
xticks([0.15 0.2 0.25 0.31 0.35 0.4 ]);
xticklabels({'0.15','0.2','0.25','{\bf0.316}({\bf0.317})','0.35','0.4'});
hold on

ax = gca;
ax.FontSize = 12; 
legend('Median', 'Mean','FontSize',12,'Location','northwest')
ylim(range1);
xlabel(' \alpha of the steel part ','FontSize',12);

subplot(3,1,2)
xline(0.329,'k-.','LineWidth',1.5)
hold on
xline(0.323,'k--','LineWidth',1.5)
histogram(real(ST(2,:)),'Normalization','probability','BinWidth',bitn1,'FaceColor','k','FaceAlpha',.3);
grid on
xlim([0.15 0.4]);
xticks([0.15 0.2 0.25  0.329 0.4 ]);
xticklabels({'0.15','0.2','0.25','{\bf0.323} {\bf0.329}','0.4'});
hold on

ax = gca;
ax.FontSize = 12; 
legend('Median', 'Mean','FontSize',12,'Location','northwest')
ylim(range1);
xlabel(' \beta of the steel part ','FontSize',12);

subplot(3,1,3)
xline(3.3,'k-.','LineWidth',1.5)
hold on
xline(4.3,'k--','LineWidth',1.5)

histogram(1000*real(ST(3,:)),'Normalization','probability','BinWidth',bitn2,'FaceColor','k','FaceAlpha',.3);
grid on
xlim([0 40]);
xticks([0 4 10 15 20 25 30 35 40]);
xticklabels({'0','{\bf 3.3} {\bf 4.3}','10','15','20','25','30','35','40'});
hold on
ax = gca;
ax.FontSize = 12; 

legend('Median', 'Mean','FontSize',12)

ylim(range2);
xlabel(' \gamma of the steel part (mm)','FontSize',12);

export_fig(h2,'param_ST.png','-m3.5','-transparent') ;

%% plot the histogram for parameters PL
h3 = figure;
subplot(3,1,1)
xline(0.256,'k-.','LineWidth',1.5)
hold on
xline(0.256,'k--','LineWidth',1.5)
histogram(real(PL(1,:)),'Normalization','probability','BinWidth',bitn1,'FaceColor','k','FaceAlpha',.3);
grid on
xlim([0.15 0.4]);
xticks([0.15 0.2 0.256 0.3 0.35 0.4 ]);
xticklabels({'0.15','0.2','\bf{0.256}','0.3','0.35','0.4'});
hold on
legend('Median', 'Mean','FontSize',12)
ax = gca;
ax.FontSize = 12; 
ylim(range1);
xlabel(' \alpha of the plastic plate ','FontSize',12);

subplot(3,1,2)
xline(0.264,'k-.','LineWidth',1.5)
hold on
xline(0.268,'k--','LineWidth',1.5)

histogram(real(PL(2,:)),'Normalization','probability','BinWidth',bitn1,'FaceColor','k','FaceAlpha',.3);
grid on
xlim([0.15 0.4]);
ax = gca;
ax.FontSize = 12; 
xticks([0.15 0.2 0.264 0.3 0.35 0.4 ]);
xticklabels({'0.15','0.2','\bf{0.264} \bf{0.268}','0.3','0.35','0.4'});
hold on

legend('Median', 'Mean','FontSize',12)
ylim(range1);
xlabel(' \beta of the plastic plate ','FontSize',12);

subplot(3,1,3)
xline(16.9,'k-.','LineWidth',1.5)
hold on
xline(16.9,'k--','LineWidth',1.5)

histogram(1000*real(PL(3,:)),'Normalization','probability','BinWidth',bitn2,'FaceColor','k','FaceAlpha',.3);
grid on
xlim([0 40]);
xticks([0 5 10 16.9 25 30 35 40]);
xticklabels({'0','5','10','\bf{16.9}(\bf{17.1})','25','30','35','40'});
hold on
legend('Median', 'Mean','FontSize',12)

ax = gca;
ax.FontSize = 12; 
ylim(range2);
xlabel(' \gamma of the plastic plate (mm)','FontSize',12);

export_fig(h3,'param_PL.png','-m3.5','-transparent') ;


