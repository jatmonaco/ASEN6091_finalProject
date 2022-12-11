%% Comparing GPS and GAL results
load savedVar\L5_results.mat;
L5_navResults = navResults;
clearvars -except L5_navResults


load savedVar\E5a_results.mat
E5a_navResults = navResults;
clearvars -except E5a_navResults L5_navResults

%% doing combo soln
GPS_PRNs = [6 14 24];
GAL_PRNs = [12 ];
[trackResults_combo, navSolutions_combo, satPositions_combo, settings] = comboSoln(GPS_PRNs, GAL_PRNs);

%% Comparison position solutions
pos_meanDiff = [mean(L5_navResults.X) - mean(E5a_navResults.X), mean(L5_navResults.Y) - mean(E5a_navResults.Y), mean(L5_navResults.Z) - mean(E5a_navResults.Z)]
% localTime_meanDiff = mean(L5_navResults.localTime - E5a_navResults.localTime(1:length(L5_navResults.localTime)))

L5_sampleStart = L5_navResults.currMeasSample(1);
E5_match = find(abs(E5a_navResults.currMeasSample - L5_sampleStart) < mean(diff(E5a_navResults.currMeasSample))/2);
combo_match = find(abs(navSolutions_combo.currMeasSample - L5_sampleStart) < mean(diff(navSolutions_combo.currMeasSample))/2);


L5_navResults.localTime(1)
E5a_navResults.localTime(E5_match)
navSolutions_combo.localTime(combo_match)