%% 
myDir = uigetdir; %gets directory
myFiles = dir(fullfile(myDir,'*.fig')); %gets all MOV files in struct

for k = 1:length(myFiles)
    a = split(myFiles(k).name,'.');
    name = a{1};
    b = strcat(name,'.pdf');
    fig = openfig(myFiles(k).name);
    saveas(gcf,b)
    close all
end