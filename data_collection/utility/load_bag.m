function [Frame, TimeStamp] = load_bag(bag_name)
bag = rosbag(bag_name);

% Select a topic 'image/data'
bSel = select(bag,'Topic','/device_0/sensor_1/Color_0/image/data');
N = bSel.NumMessages;
Images = readMessages(bSel);
for i = 1:N
    Frame{i} =  permute(reshape(Images{i}.Data',[3,640,480]),[3 2 1]);
    if i == 1
        T_begin = Images{i}.Header.Stamp.Sec +1e-9*Images{i}.Header.Stamp.Nsec;
        TimeStamp(1) = 0;
    else
        T = Images{i}.Header.Stamp.Sec +1e-9*Images{i}.Header.Stamp.Nsec;
        TimeStamp(i) = T - T_begin;
    end
end

end