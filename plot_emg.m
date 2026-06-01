function plot_emg(EMG,fsamp,amp,flag_filter)
% written by GRY on 2024/7/25
% Input:
% EMG: rawEMG in matrix form（channel by sample）
% fsamp：sampling frequency
% amp: the coefficient you want to enlarge when drawing

channelnum=size(EMG,1);
if flag_filter
    LowFreq = 20;   % low frequency of passband
    HighFreq = 500; % high frequency of passband
    [para_bpFilter(1,:),para_bpFilter(2,:)] = butter(4,[LowFreq/fsamp*2 HighFreq/fsamp*2]); % EMG band pass filter
    fo = 50; % power frequency
    q = 10;
    bw = (fo/(fsamp/2))/q;
    [para_combFilter(1,:),para_combFilter(2,:)] = iircomb(round(fsamp/fo),bw,'notch');
    for ch = 1:channelnum
        EMG(ch,:) = filter(para_bpFilter(1,:),para_bpFilter(2,:),EMG(ch,:));
        EMG(ch,:) = filter(para_combFilter(1,:),para_combFilter(2,:),EMG(ch,:));
    end
end
t = [1:length(EMG)]/fsamp;
% figure
for i = 1:channelnum
    plot_EMG{i} = line(0,0,'Color',[0.7 0.7 0.7],'linewidth',2);
end
for ch = 1:channelnum
    set(plot_EMG{ch},'xdata',t,'ydata',amp*EMG(ch,:)+ch);
end
ylim([0,channelnum+1])
set(gca, 'ytick', []);
set(gca, 'yticklabel', []);