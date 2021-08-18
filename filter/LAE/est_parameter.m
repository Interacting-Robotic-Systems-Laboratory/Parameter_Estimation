function para_chosen = est_parameter(para)

J = find(para(4,:) == 1);
method = 'median';

if  strcmp(method,'median') 
    if isempty(J)
        para_chosen = [median(para(1,:),'omitnan');median(para(2,:),'omitnan');median(para(3,:),'omitnan')];
    else
        para_chosen = [median(para(1,J),'omitnan');median(para(2,J),'omitnan');median(para(3,J),'omitnan')];
    end      
elseif strcmp(method,'Last')
    index = max(J);
    para_chosen = [para(1,index),para(2,index),para(3,index)];
end


para_chosen = min(1,para_chosen);
para_chosen = max(0,para_chosen);
end