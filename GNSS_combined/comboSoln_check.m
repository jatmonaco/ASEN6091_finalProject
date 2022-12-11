%% Validating and investigating the combination solution
clear
close all

%% Combo Solution
% GPS_PRNs = [1 14 24];
% GAL_PRNs = [36];
GPS_PRNs = [14     1     6    30    24];
GAL_PRNs = [25    11     2    36    24    14     3     8  ];
[trackResults_combo, navSolutions_combo, satPositions_combo, settings] = comboSoln(GPS_PRNs, GAL_PRNs);

plotNavigation(navSolutions_combo, settings, 1);

%% GPS Solution
GPS_PRNs = [14     1     6    30    24];
GAL_PRNs = [];
[trackResults_GPS, navSolutions_GPS, satPositions_GPS, settings] = comboSoln(GPS_PRNs, GAL_PRNs);

plotNavigation(navSolutions_GPS, settings, 2);

%% GAL Solution
GPS_PRNs = [];
GAL_PRNs = [25    11     2    36    24    14     3     8    12];
[trackResults_GAL, navSolutions_GAL, satPositions_GAL, settings] = comboSoln(GPS_PRNs, GAL_PRNs);

plotNavigation(navSolutions_GAL, settings, 3);


%% Time differences
GPS_idx = 1:5; 
GAL_idx = 6:14;

sampleStart_GPS = navSolutions_GPS.currMeasSample(1);
E5_match_idx = find(abs(navSolutions_GAL.currMeasSample - sampleStart_GPS) < mean(diff(navSolutions_GPS.currMeasSample))/2);
combo_match_idx = find(abs(navSolutions_combo.currMeasSample - sampleStart_GPS) < mean(diff(navSolutions_combo.currMeasSample))/2);

navSolutions_GPS.localTime(1)
navSolutions_GAL.localTime(E5_match_idx)
navSolutions_combo.localTime(combo_match_idx)

max(navSolutions_combo.localTime - navSolutions_GPS.localTime) * settings.c

% navSolutions_combo.transmitTime(GPS_idx,:) - navSolutions_GPS.transmitTime
% navSolutions_combo.transmitTime(GAL_idx,:) - navSolutions_GAL.transmitTime(:,E5_match_idx:end)

% satPositions_combo.Z(GAL_idx,:) - satPositions_GAL.Z(:,E5_match_idx:end)
% satPositions_combo.Y(GPS_idx,:) - satPositions_GPS.Y(:,:)