%% Simple Standardization
function [RMSE GLOBAL LOCAL] = simple_standardization(EC,OFFSET,PASS)

GLOBAL = (EC - mean(EC))/std(EC);
GLOBAL(GLOBAL > 1) = 1;
GLOBAL(GLOBAL < 0) = 0;

EC_M = mean(EC(OFFSET:OFFSET+PASS));
EC_S = std(EC(OFFSET:OFFSET+PASS));
LOCAL = (EC - EC_M)/(EC_S);
LOCAL(LOCAL > 1) = 1;
LOCAL(LOCAL < 0) = 0;
RMSE = sqrt(nanmean((LOCAL-GLOBAL).^2));

% UNCOMMENT TO DISPLAY RESULTS
% plot(RMSE);
% disp(min(GLOBAL));
% disp(max(GLOBAL));

end
