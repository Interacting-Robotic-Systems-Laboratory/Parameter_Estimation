function [u,v,theta] = Pose(I,K, threshold)
    height = K.ImageSize(1);
    width = K.ImageSize(2);
     
    RL1 = threshold(1);
    RU1 = threshold(2);
    GL1 = threshold(3);
    GU1 = threshold(4);
    BL1 = threshold(5);
    BU1 = threshold(6);

%     I_x =  1:width;
%     I_y = 1:height;
%     I_x = repmat(I_x-1, 1,height);
%     I_y = repelem(I_y-1,width);
    
    
    data_color = reshape(permute(I,[3,1,2]),[3,width*height]);
    BWp = zeros(width*height,1);
    
    data_color = double(data_color);
    
    P = (data_color(1,:)>=RL1)&(data_color(1,:)<=RU1)&(data_color(2,:)...
        >=GL1)&(data_color(2,:)<=GU1)&(data_color(3,:)>=BL1)&(data_color(3,:)<=BU1); %pink block

    BWp(P) = 1;
            
    BWp = logical(reshape(BWp',[height,width]));
%     CC = bwconncomp(BWp);
%     B = zeros(width*height,1);
%     I = CC.PixelIdxList{1};
%     B(I) = 1;
%     B = logical(reshape(B',[height,width]));
%     [u2,v2] = find(B == 1);
    s = regionprops(BWp,'centroid','Area','Orientation');

    centroids = cat(1,s.Centroid);
    Area = cat(1,s.Area);
    Orientations = cat(1, s.Orientation);
    if isempty(Area)
        Max_area = 0;
    else
        Max_area = max(Area);
    end
    
    if (isempty(centroids) || Max_area <= 50)
        theta = NaN;  
        u = NaN;
        v = NaN;
    else
        [~,index] = max(Area);
        Orientations = Orientations(index);
        centroids = centroids(index,:);
        theta = Orientations;
        
        
        u1 = centroids(1);
        v1 = centroids(2);
 
        u = u1;
        v = v1;

%         imshow(BWp);
%         hold on
%         plot(u,v,'r*');
    end
            
  
            
    

end 