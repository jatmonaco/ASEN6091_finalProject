function [pos,el, az, dop] = leastSquarePos_combined(satpos,obs,settings,GAL_chn)

[~,numSats] = size(satpos); 

if isempty(GAL_chn) || length(GAL_chn) == numSats
    [pos,el, az, dop] = leastSquarePos(satpos,obs,settings);
    pos(5) = 0;
else
    [pos,el, az, dop] = leastSquarePos_dtsys(satpos,obs,settings,GAL_chn);
end