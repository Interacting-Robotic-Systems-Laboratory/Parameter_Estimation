function [Brio_Data, D415_Data] = GP_predict_trajectory_main( FW_Settings, Brio_Data, D415_Data)
N_1 = FW_Settings.N_1;
N_2 = FW_Settings.N_2;


Brio_N = length(Brio_Data.T) - N_2 - FW_Settings.Prdiction_window + 1;
D415_N = length(D415_Data.T) - N_2 - FW_Settings.Prdiction_window + 1;

for i = 1:Brio_N
    FW_Settings.Estimation_window = [N_1, N_2+i-1]; 
    Brio_Data.GP_Q_p(:,:,i) = GP_predict_trajectory(FW_Settings, Brio_Data);     
end

for i = 1:D415_N
    FW_Settings.Estimation_window = [N_1, N_2+i-1];
    D415_Data.GP_Q_p(:,:,i) = GP_predict_trajectory(FW_Settings, D415_Data);      
end

end