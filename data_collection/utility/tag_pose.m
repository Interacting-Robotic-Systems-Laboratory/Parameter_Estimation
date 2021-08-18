function [position, Theta,Mean, Std]= tag_pose(Frame,K, tagsize,Hw)



%Hw = eye(4);
for i = 1:length(Frame)
    try
    I = Frame{i};
    I = undistortImage(I,K,"OutputView","same");
    [id,~,pose] = readAprilTag(I,"tag36h11",K,tagsize);
    I = find(id == 1);
    Pc_t = zeros(4,4);
    Pc_t(1:3,1:3) = pose(I).Rotation;
    Pc_t(1:3,4) = 1000*pose(I).Translation';
    Pc_t(4,4) = 1;
    Pw_t = Hw\Pc_t;
    eul = tform2eul(Pw_t);
    if eul(1) == 0
        Theta(i) = NaN;
        position(i,1:3) = [NaN,NaN,NaN];
    else
        if abs(eul(1)) <= pi/10 
            Theta(i) = eul(1)*(180/pi);
            position(i,1:3) = Pw_t(1:3,4)';
        else
            Theta(i) = wrapTo2Pi(eul(1))*(180/pi);
            position(i,1:3) = Pw_t(1:3,4)';
        end
        

    end
    catch
        Theta(i) = NaN;
        position(i,1:3) = [NaN,NaN,NaN];
    end
end
Mean = mean([position,Theta'],'omitnan');
Std = std([position,Theta'],'omitnan');
Mean = Mean';
Std = Std';


end