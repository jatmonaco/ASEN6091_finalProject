function [satPositions, satClkCorr] = satpos(transmitTime, prnList, eph, ...
    constell) 

% making a list of which channels are under which constellation 
numSats = length(prnList);
GALList = find(constell == "GAL");
GPSList = find(constell == "GPS");

% returning the satellite positions for each constellation
satPositions_GAL = [];
satClkCorr_GAL = [];
satPositions_GPS = [];
satClkCorr_GPS = [];

if ~isempty(GALList)
    [satPositions_GAL, satClkCorr_GAL] = satpos_GAL(transmitTime(GALList), prnList(GALList), ...
                                             eph.GAL); 
end

if ~isempty(GPSList)
    [satPositions_GPS, satClkCorr_GPS] = satpos_GPS(transmitTime(GPSList), prnList(GPSList),eph.GPS);
end

% collecting results and returning them in the same order in which they
% came
satPositions = zeros(3, numSats);
satClkCorr = zeros(1,numSats);

satPositions(:,GALList) = satPositions_GAL;
satClkCorr(GALList) = satClkCorr_GAL;

satPositions(:,GPSList) = satPositions_GPS;
satClkCorr(GPSList) = satClkCorr_GPS;

end 
