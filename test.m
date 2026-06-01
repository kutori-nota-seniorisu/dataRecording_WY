clear;
close all;


fsamp = 2048;
dataFile = "LSQ_Gestures_D11_Session1_Task1_Trial5.mat";
dataFile = "YST_python_Session1_Task1_Trial21.mat";
load(dataFile);
h = figure('Color',[1,1,1],'Position',[50,50,1000,800]);
for gn = 1:6
    tmpData = data_sEMG([1:64]+(gn-1)*64,:); subplot(2,3,gn);
    plotsig_cc(tmpData,fsamp); title("Grid"+gn);
end
sgtitle(dataFile)

gn = 1; fft_cc(data_sEMG(30,:),fsamp);

% gn=2
% tmpData = data_sEMG([1:64]+(gn-1)*64,:);
% figure;
% plotsig_cc(tmpData,fsamp);
% ylim([0.7,1.3])
% title("Grid"+gn);