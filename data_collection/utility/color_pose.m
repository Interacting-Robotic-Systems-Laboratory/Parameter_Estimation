function [position, Theta,Mean, Std]= color_pose(Frame,param,threshold,height)


R = param.RotationMatrices(:,:,1);
T = param.TranslationVectors(1,:); 
T(3) = T(3) - height +2;% wooden block: minus 76.2mm in z axis, checkerboard: plus 2mm in z axis
K = param.Intrinsics;

N = length(Frame);

position = zeros(N,3);
Theta = zeros(N,1);

for i = 1:N
    try
    I = Frame{i};
    
    [u,v,theta] = Pose(I,K, threshold);
    imagepoints = [u,v];
    Q = pointsToWorld(K,R,T,imagepoints);
    position(i,1:3) = [Q,2];
    
    Theta(i,1) = theta;
    
    catch
    position(i,1:3) = [NaN,NaN,NaN];
    Theta(i,1) = NaN;
    end
end
Mean = mean([position,Theta]);
Std = std([position,Theta]);
end