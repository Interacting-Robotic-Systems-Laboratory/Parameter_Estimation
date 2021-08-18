clear all
close all
restoredefaultpath
addpath('Utility');
addpath('pathmexmaci64');
addpath('offline_utility');
% 'wooden' 'steel' 'plastic' 'acrylic'

Object = 'wooden';
SW_Settings = Setting(Object);
FW_Settings = Setting(Object);
N_1 = 1;
N_2 = 10;
Prdiction_window = 20;
estimation_size = N_2 - N_1+1;
SW_Settings.N_1 = N_1;
SW_Settings.N_2 = N_2;
SW_Settings.Estimation_window = [N_1 N_2]; % position of initial estimation window
SW_Settings.Prdiction_window = Prdiction_window;
%wooden_block, plastic_plate, steel
addpath('results/wooden_block/');
Data_name = 'D415_Data';

%% training data for computing the parameters

load('WB_para.mat');
Err = cell(20,1);
   
k = 5;
k_size = 60/k;
range = 1:60;
for j = 5:k
    range_T = range;
    range_T(k_size*(j-1)+1:k_size*j) = [];
    Params = [];
    for i = range_T 
        trial = WB_para(:,:,i);
        trial = cell2mat(trial);
    
        params = trial(1:3,trial(4,:) == 1);
        %params = trial(1:3,~isnan(trial(4,:)));
        Params = [Params, params];
        
    end
    para_chosen = real(median(Params,2));
   
    
    %% testing data
 
    for i = 1%i = k_size*(j-1)+1:k_size*j
        data_index = num2str(i);
        data_name = strcat('D415_Data_',data_index,'.mat');

        load(data_name);

        Out = prediction_testing(SW_Settings,D415_Data,para_chosen);
        for k = 1:20
            Err{k} = [Err{k}, Out{k}.Err];
        end
        
        

    end
   
end


 %% Error
for k = 1:20
    Error = Err{k};
    msize = size(Error,2);
    idx = randperm(msize);
    sample_size = 300;
    picked_Err = Error(:,idx(1:sample_size));
    Mean(:,k) = [mean(sqrt(picked_Err(1,:).^2+picked_Err(2,:).^2),'omitnan');mean(abs(picked_Err(3,:)),'omitnan')];
    Std(:,k) = [std(sqrt(picked_Err(1,:).^2+picked_Err(2,:).^2),'omitnan');std(abs(picked_Err(3,:)),'omitnan')];
    
    CI_95(:,k) = 1.96*Std(:,k)/sqrt(sample_size);
end
offline.Err = Err;
offline.Mean = Mean;
offline.Std = Std;
offline.CI_95 = CI_95;

