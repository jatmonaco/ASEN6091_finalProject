function plotCEP(navResults, figNum)
%% Plotting 90% CEP 
truth = [mean(navResults.E), mean(navResults.N), mean(navResults.U)];


num_points = length(navResults.N);
thresh = 0.9;   % CEP threshold
step = 0.001;     % CEP circle stepsize
CEP_thresh = 0; 
CEP_test = sum((navResults.E - truth(1)).^2 + (navResults.N - truth(2)).^2 < CEP_thresh.^2);
while(CEP_test < num_points * thresh)
    CEP_thresh = CEP_thresh + step;
    CEP_test = sum((navResults.E - truth(1)).^2 + (navResults.N - truth(2)).^2 < CEP_thresh.^2);
end    

figure(figNum);
clf;
hold on;
scatter(navResults.E - truth(1), navResults.N - truth(2), 'x' );
viscircles([0,0],CEP_thresh);
hold off
grid on
axis equal
xlabel("East Soln Deviation from mean (m)")
ylabel("North Soln Deviation from mean (m)")
title("2D scatter of horizontal position solutions",...
    ["90% CEP ring added (r = " + num2str(CEP_thresh) + "m).",...
    " Centered at: [" + num2str(truth(1)) + "," + num2str(truth(2)) + "]"])