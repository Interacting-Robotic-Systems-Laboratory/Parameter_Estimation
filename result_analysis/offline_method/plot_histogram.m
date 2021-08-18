
Params = parameter_collection(CL_para);

h1 = figure;
subplot(3,1,1)
histogram(real(Params(1,:)),'Normalization','probability','BinWidth',0.008);
grid on
xlim([0.15 0.45]);
ylim([0 0.15]);
xlabel(' \alpha of the wooden block ');
subplot(3,1,2)
histogram(real(Params(2,:)),'Normalization','probability','BinWidth',0.008);
grid on
xlim([0.15 0.45]);
ylim([0 0.15]);
xlabel(' \beta of the wooden block ');
subplot(3,1,3)
histogram(1000*real(Params(3,:)),'Normalization','probability','BinWidth',1);
grid on
xlim([0 40]);
ylim([0 0.25]);
xlabel(' \gamma of the wooden block (mm)');
