function Data = histogram_error(Data,Error)
N = min(size(Error,2),30);

for i = 1:N
    Data{i} = [Data{i}, Error(:,i)];  
end


end