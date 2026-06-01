function [ConfString_start,ConfString_stop,NumChan] = OTconfigure(device,para)
switch device
    case 'MuoviPro'
        MuoviEn = zeros(1,4);
        MuoviEn(para) = 1;

        % Number of acquired channel depending on the acquisition mode
        NumChanVsModeMuovi = [38 38 38 38];

        SizeComm = sum(MuoviEn)*2;
        ConfString_start(1) = SizeComm + 1;   %GO

        % Create the command to send to Muovi/Muovi+/Sessantaquattro+
        sampFreq = 2000;
        NumChan = 6;
        j = 2;
        for i = 1:length(MuoviEn)
            if MuoviEn(i)
                 ConfString_start(j) = (i-1)*16 + 8 + 1;
                 NumChan = NumChan + 38;
                 j = j+1;
            end 
        end
     
        ConfString_start(j) = CRC8(ConfString_start, j-1);

        ConfString_stop = [];
        ConfString_stop(1) = 0;
        ConfString_stop(2) = CRC8(ConfString_stop, 1);
    case 'Quattrocento'
        ConfString_start = 'startTX';
        ConfString_stop = 'stopTX';
        NumChan = 0;
end
