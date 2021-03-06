%% Simple Scaling
function [RMSE GLOBAL LOCAL] = simple_scaling(EC,OFFSET,PASS)

GLOBAL = (EC - min(EC))/(max(EC) - min(EC));
GLOBAL(GLOBAL > 1) = 1;
GLOBAL(GLOBAL < 0) = 0;

EC_A = min(EC(OFFSET:OFFSET+PASS));
EC_B = max(EC(OFFSET:OFFSET+PASS));
LOCAL = (EC - EC_A)/(EC_B - EC_A);
LOCAL(LOCAL > 1) = 1;
LOCAL(LOCAL < 0) = 0;
RMSE = sqrt(nanmean((LOCAL-GLOBAL).^2));

% UNCOMMENT TO DISPLAY RESULTS
% plot(RMSE);
% disp(min(GLOBAL));
% disp(max(GLOBAL));

end

