function [Error, Para ]= compute_error_main(Prdiction_window, i_begin,i_end, N_1, N_2, Data_name)
% function compute_error_main computes the error with the given
% Prdiction_window size
Error = struct();
Para = struct();
%% load the data


%SW_UKF_Err_i = cell(30,1);
%FW_UKF_Err_i = cell(30,1);
SW_CL_Err_i = cell(30,1);
%FW_CL_Err_i = cell(30,1);
%GP_Err_i = cell(30,1);

%SW_UKF_Err_T = [];
%FW_UKF_Err_T = [];
SW_CL_Err_T = [];
%FW_CL_Err_T = [];
%GP_Err_T = [];


%SW_UKF_para = [];
%FW_UKF_para = [];
SW_CL_para = [];
%FW_CL_para = [];

%SW_UKF_para_trial = [];
%FW_UKF_para_trial = [];
SW_CL_para_trial = [];
%FW_CL_para_trial = [];


%SW_UKF_para_i = cell(30,1);
%FW_UKF_para_i = cell(30,1);
SW_CL_para_i = cell(30,1);
%FW_CL_para_i = cell(30,1);
    
for i = i_begin:i_end
    
    data_index = num2str(i);
    data_name = strcat(Data_name,'_',data_index,'.mat');


    Data = load(data_name);
    input = getfield(Data,Data_name);
     %% compute predition errors
    [SW_CL_Err, ~] = compute_prediction_error(Prdiction_window,N_1,N_2,input);
%     [SW_UKF_Err_p, SW_CL_Err_p, FW_UKF_Err_p,...
%         FW_CL_Err_p, GP_Err_p] = compute_prediction_error_percentage(Prdiction_window,N_1,N_2,input);

    % errors for each individual current step
    %SW_UKF_Err_i = histogram_error(SW_UKF_Err_i,SW_UKF_Err);
    %FW_UKF_Err_i = histogram_error(FW_UKF_Err_i,FW_UKF_Err);
    SW_CL_Err_i = histogram_error(SW_CL_Err_i,SW_CL_Err);
    %FW_CL_Err_i = histogram_error(FW_CL_Err_i,FW_CL_Err);
    %GP_Err_i = histogram_error(GP_Err_i,GP_Err);
    
    % parameters for each individual current step
    %SW_UKF_para_i = histogram_error(SW_UKF_para_i, input.SW_UKF_para_chosen);
    %FW_UKF_para_i = histogram_error(FW_UKF_para_i, input.FW_UKF_para_chosen);
    SW_CL_para_i = histogram_error(SW_CL_para_i, input.SW_CL_para_chosen);
    %FW_CL_para_i = histogram_error(FW_CL_para_i, input.FW_CL_para_chosen);
    % the union of errors 
    %SW_UKF_Err_T = [SW_UKF_Err_T, SW_UKF_Err];
    %FW_UKF_Err_T = [FW_UKF_Err_T, FW_UKF_Err];
    SW_CL_Err_T = [SW_CL_Err_T, SW_CL_Err];
    %FW_CL_Err_T = [FW_CL_Err_T, FW_CL_Err];
    %GP_Err_T = [GP_Err_T, GP_Err];
    
    % the parameters chosen to predict 
    %SW_UKF_para = [SW_UKF_para, input.SW_UKF_para_chosen];
    %FW_UKF_para = [FW_UKF_para, input.FW_UKF_para_chosen];
    SW_CL_para = [SW_CL_para, input.SW_CL_para_chosen];
    %FW_CL_para = [FW_CL_para, input.FW_CL_para_chosen];
    
    % the parameters chosen for each examples
    %SW_UKF_para_trial = [SW_UKF_para_trial, mean(input.SW_UKF_para_chosen,2)];
    %FW_UKF_para_trial = [FW_UKF_para_trial, mean(input.FW_UKF_para_chosen,2)];
    SW_CL_para_trial = [SW_CL_para_trial, mean(input.SW_CL_para_chosen,2)];
    %FW_CL_para_trial = [FW_CL_para_trial, mean(input.FW_CL_para_chosen,2)];
    
    % the mean of errors in each trial i
    %Error.mean_SW_UKF_Err_trial_i(:,i) = [mean(sqrt(SW_UKF_Err(1,:).^2+SW_UKF_Err(2,:).^2),'omitnan');mean(abs(SW_UKF_Err(3,:)),'omitnan')];
    %Error.mean_FW_UKF_Err_trial_i(:,i) = [mean(sqrt(FW_UKF_Err(1,:).^2+FW_UKF_Err(2,:).^2),'omitnan');mean(abs(FW_UKF_Err(3,:)),'omitnan')];
    Error.mean_SW_CL_Err_trial_i(:,i) = [mean(sqrt(SW_CL_Err(1,:).^2+SW_CL_Err(2,:).^2),'omitnan');mean(abs(SW_CL_Err(3,:)),'omitnan')];
    %Error.mean_FW_CL_Err_trial_i(:,i) = [mean(sqrt(FW_CL_Err(1,:).^2+FW_CL_Err(2,:).^2),'omitnan');mean(abs(FW_CL_Err(3,:)),'omitnan')];
    %Error.mean_GP_Err_trial_i(:,i) = [mean(sqrt(GP_Err(1,:).^2+GP_Err(2,:).^2),'omitnan');mean(abs(GP_Err(3,:)),'omitnan')];

end
%% Return Errors in each individual current step
N = 5; % N is the number of steps that the sliding window moves forward
for i = 1:N
    
    %Error.mean_SW_UKF_Err_i(:,i) = mean(abs(SW_UKF_Err_i{i}),2,'omitnan');
    %Error.std_SW_UKF_Err_i(:,i) = std(abs(SW_UKF_Err_i{i}),0,2,'omitnan');
    
    %Error.mean_FW_UKF_Err_i(:,i) = mean(abs(FW_UKF_Err_i{i}),2,'omitnan');
    %Error.std_FW_UKF_Err_i(:,i) = std(abs(FW_UKF_Err_i{i}),0,2,'omitnan');
    
    Error.mean_SW_CL_Err_i(:,i) = mean(abs(SW_CL_Err_i{i}),2,'omitnan');
    Error.std_SW_CL_Err_i(:,i) = std(abs(SW_CL_Err_i{i}),0,2,'omitnan');
    
    %Error.mean_FW_CL_Err_i(:,i) = mean(abs(FW_CL_Err_i{i}),2,'omitnan');
    %Error.std_FW_CL_Err_i(:,i) = std(abs(FW_CL_Err_i{i}),0,2,'omitnan');
    
    %Error.mean_GP_Err_i(:,i) = mean(abs(GP_Err_i{i}),2,'omitnan');
    %Error.std_GP_Err_i(:,i) = std(abs(GP_Err_i{i}),0,2,'omitnan');
    
end

%Error.SW_UKF_Err_i = SW_UKF_Err_i;
%Error.FW_UKF_Err_i = FW_UKF_Err_i;
Error.SW_CL_Err_i = SW_CL_Err_i;
%Error.FW_CL_Err_i = FW_CL_Err_i;
%Error.GP_Err_i = GP_Err_i;

%% Return Total Error

% randomly pick samples from the set with the given sample_size
msize = size(SW_CL_Err_T,2);
idx = randperm(msize);
sample_size = 300;

%picked_SW_UKF_Err_T = SW_UKF_Err_T(:,idx(1:sample_size));
%picked_FW_UKF_Err_T = FW_UKF_Err_T(:,idx(1:sample_size));
picked_SW_CL_Err_T = SW_CL_Err_T(:,idx(1:sample_size));
%picked_FW_CL_Err_T = FW_CL_Err_T(:,idx(1:sample_size));
%picked_GP_Err_T = GP_Err_T(:,idx(1:sample_size));


%Error.mean_SW_UKF_Err_T = [mean(sqrt(picked_SW_UKF_Err_T(1,:).^2+picked_SW_UKF_Err_T(2,:).^2),'omitnan');mean(abs(picked_SW_UKF_Err_T(3,:)),'omitnan')];
%Error.mean_FW_UKF_Err_T = [mean(sqrt(picked_FW_UKF_Err_T(1,:).^2+picked_FW_UKF_Err_T(2,:).^2),'omitnan');mean(abs(picked_FW_UKF_Err_T(3,:)),'omitnan')];
Error.mean_SW_CL_Err_T = [mean(sqrt(picked_SW_CL_Err_T(1,:).^2+picked_SW_CL_Err_T(2,:).^2),'omitnan');mean(abs(picked_SW_CL_Err_T(3,:)),'omitnan')];
%Error.mean_FW_CL_Err_T = [mean(sqrt(picked_FW_CL_Err_T(1,:).^2+picked_FW_CL_Err_T(2,:).^2),'omitnan');mean(abs(picked_FW_CL_Err_T(3,:)),'omitnan')];
%Error.mean_GP_Err_T = [mean(sqrt(picked_GP_Err_T(1,:).^2+picked_GP_Err_T(2,:).^2),'omitnan');mean(abs(picked_GP_Err_T(3,:)),'omitnan')];

%Error.std_SW_UKF_Err_T = [std(sqrt(picked_SW_UKF_Err_T(1,:).^2+picked_SW_UKF_Err_T(2,:).^2),'omitnan');std(abs(picked_SW_UKF_Err_T(3,:)),'omitnan')];
%Error.std_FW_UKF_Err_T = [std(sqrt(picked_FW_UKF_Err_T(1,:).^2+picked_FW_UKF_Err_T(2,:).^2),'omitnan');std(abs(picked_FW_UKF_Err_T(3,:)),'omitnan')];
Error.std_SW_CL_Err_T = [std(sqrt(picked_SW_CL_Err_T(1,:).^2+picked_SW_CL_Err_T(2,:).^2),'omitnan');std(abs(picked_SW_CL_Err_T(3,:)),'omitnan')];
%Error.std_FW_CL_Err_T = [std(sqrt(picked_FW_CL_Err_T(1,:).^2+picked_FW_CL_Err_T(2,:).^2),'omitnan');std(abs(picked_FW_CL_Err_T(3,:)),'omitnan')];
%Error.std_GP_Err_T = [std(sqrt(picked_GP_Err_T(1,:).^2+picked_GP_Err_T(2,:).^2),'omitnan');std(abs(picked_GP_Err_T(3,:)),'omitnan')];

%Error.CI_95_SW_UKF_Err_T = 1.96*Error.std_SW_UKF_Err_T/sqrt(sample_size);
%Error.CI_95_FW_UKF_Err_T = 1.96*Error.std_FW_UKF_Err_T/sqrt(sample_size);
Error.CI_95_SW_CL_Err_T = 1.96*Error.std_SW_CL_Err_T/sqrt(sample_size);
%Error.CI_95_FW_CL_Err_T = 1.96*Error.std_FW_CL_Err_T/sqrt(sample_size);
%Error.CI_95_GP_Err_T = 1.96*Error.std_GP_Err_T/sqrt(sample_size);


%Error.SW_UKF_Err_T = SW_UKF_Err_T;
%Error.FW_UKF_Err_T = FW_UKF_Err_T;
Error.SW_CL_Err_T = SW_CL_Err_T;
%Error.FW_CL_Err_T = FW_CL_Err_T;
%Error.GP_Err_T = GP_Err_T;

%% return para
%Para.SW_UKF_para = SW_UKF_para;
%Para.FW_UKF_para = FW_UKF_para;
Para.SW_CL_para = SW_CL_para;
%Para.FW_CL_para = FW_CL_para;

%Para.SW_UKF_para_i = SW_UKF_para_i;
%Para.FW_UKF_para_i = FW_UKF_para_i;
Para.SW_CL_para_i = SW_CL_para_i;
%Para.FW_CL_para_i = FW_CL_para_i;

%Para.SW_UKF_para_trial = SW_UKF_para_trial;
%Para.FW_UKF_para_trial = FW_UKF_para_trial;
Para.SW_CL_para_trial = SW_CL_para_trial;
%Para.FW_CL_para_trial = FW_CL_para_trial;

end