%% Validating and investigating the combination solution
clear
close all

%% Combo Solution
% GPS_PRNs = [1 14 24];
% GAL_PRNs = [36];
GPS_PRNs = [14     1     6    30    24];
GAL_PRNs = [25    11     2    36    24    14     3     8  ];
[trackResults_combo, navSolutions_combo, satPositions_combo, settings] = comboSoln(GPS_PRNs, GAL_PRNs);


%% GPS Solution
GPS_PRNs = [14     1     6    30    24];
GAL_PRNs = [];
[trackResults_GPS, navSolutions_GPS, satPositions_GPS, settings] = comboSoln(GPS_PRNs, GAL_PRNs);


%% GAL Solution
GPS_PRNs = [];
GAL_PRNs = [25    11     2    36    24    14     3     8    12];
[trackResults_GAL, navSolutions_GAL, satPositions_GAL, settings] = comboSoln(GPS_PRNs, GAL_PRNs);



%% Comparison
GPS_idx = 1:5; 
GAL_idx = 6:14;

% Nav results
plotNavigation(navSolutions_combo, settings, 1);

plotNavigation(navSolutions_GPS, settings, 2);

plotNavigation(navSolutions_GAL, settings, 3);

%%

% comparing average DOP
avg_GDOP_combo = mean(navSolutions_combo.DOP(1,:))
avg_GDOP_GPS = mean(navSolutions_GPS.DOP(1,:))
avg_GDOP_GAL = mean(navSolutions_GAL.DOP(1,:))

% CEP plots
plotCEP(navSolutions_combo,4);
plotCEP(navSolutions_GPS,5);
plotCEP(navSolutions_GAL,6);

figure(7)
t = navSolutions_combo.localTime(2:end) - navSolutions_combo.localTime(2);
dtsys = navSolutions_combo.dtsys(2:end)/settings.c;
plot(t,dtsys*1e3)
grid on
ylabel("Time difference (ms)")
xlabel("Local time from start")
title("GGTO Over Time")