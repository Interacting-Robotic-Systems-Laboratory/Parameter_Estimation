function Params = parameter_collection(para)
N = size(para,3); % size of trials
Params = [];
for i = 1:N
    trial = para(:,:,i);
    trial = cell2mat(trial);
    
    params = trial(1:3,trial(4,:) == 1);
    
    Params = [Params, params];
end

end