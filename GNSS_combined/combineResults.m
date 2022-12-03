% The purpose of this file is to take saved runs of E5a and L5 and combine
% them into a saved workspace of trkRestuls and settings that may be
% compatable with a new postNavigation file. 

%% Bringing in GPS trkResults
clear 
load savedVar\L5_results.mat

GPS_trkResults = [trkResults(1) trkResults(2) trkResults(4)];

save('savedVar\GPS_trkResults',"GPS_trkResults",'settings')

%% Bringing in GAL trkResults
clear
load savedVar\E5a_results.mat

GAL_trkResults = trkResults(4);

save('savedVar\E5a_trkResults',"GAL_trkResults")

%% Combining the constellations' trkResults
clear
load savedVar\E5a_trkResults
load savedVar\GPS_trkResults

% adding the constellation field to the GAL trkResults
GAL_trkResults.constell = "GAL";
for i = 1:3
    GPS_trkResults(i).constell = "GPS";
    GPS_trkResults(i).Pilot_I_P = NaN;
    GPS_trkResults(i).Pilot_Q_P = NaN;
end

comboTrkResults = [GPS_trkResults(1), GPS_trkResults(2), GPS_trkResults(3), GAL_trkResults];
save('savedVar\comboTrkResults', 'comboTrkResults','settings')