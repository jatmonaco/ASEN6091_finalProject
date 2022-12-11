function combineResults(GPS_PRNs,GAL_PRNs)% The purpose of this file is to take saved runs of E5a and L5 and combine
% them into a saved workspace of trkRestuls and settings that may be
% compatable with a new postNavigation file. 

%% Bringing in GPS trkResults
clearvars -except GAL_PRNs GPS_PRNs
load savedVar\L5_results.mat
trk_idx = NaN(size(GPS_PRNs));
for i = 1:length(GPS_PRNs)
    trk_idx(i) = find([trkResults.PRN] == GPS_PRNs(i));
end


GPS_trkResults = trkResults(trk_idx);

save('savedVar\GPS_trkResults',"GPS_trkResults",'settings')

%% Bringing in GAL trkResults
clearvars -except GAL_PRNs GPS_PRNs
load savedVar\E5a_results.mat
trk_idx = NaN(size(GAL_PRNs));
for i = 1:length(GAL_PRNs)
    trk_idx(i) = find([trkResults.PRN] == GAL_PRNs(i));
end

GAL_trkResults = trkResults(trk_idx);

save('savedVar\E5a_trkResults',"GAL_trkResults")

%% Combining the constellations' trkResults
clear
load savedVar\E5a_trkResults
load savedVar\GPS_trkResults

[GAL_trkResults(:).constell] = deal(0);
[GPS_trkResults(:).constell] = deal(0);

[GPS_trkResults(:).Pilot_I_P] = deal(0);
[GPS_trkResults(:).Pilot_Q_P] = deal(0);

% adding the constellation field to the GAL trkResults
for i = 1:length([GAL_trkResults.PRN])
    GAL_trkResults(i).constell = "GAL";
end

for i = 1:length([GPS_trkResults.PRN])
    GPS_trkResults(i).constell = "GPS";
    GPS_trkResults(i).Pilot_I_P = NaN;
    GPS_trkResults(i).Pilot_Q_P = NaN;
end

settings.numberOfChannels = length([GPS_trkResults.PRN]) + length([GAL_trkResults.PRN]);

comboTrkResults = [GPS_trkResults, GAL_trkResults];
save('savedVar\comboTrkResults', 'comboTrkResults','settings')