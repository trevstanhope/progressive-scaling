%% Quick Pass
% Single pass for a single field's data file.
close all; clc; clear all;

% Import
[EC, ~, ~, ~, ~, ~, FILENAME] = import_csv();
OFFSET = input('Offset: ');
PASS = input('Pass Length (-1 for all): ');
if PASS == -1
    PASS = length(EC)-OFFSET;   
end

% Run scaling
disp('Running Scaling Methods...');
[r1, g1, l1] = simple_scaling(EC,OFFSET,PASS);
[r2, g2, l2] = simple_quartile(EC,OFFSET,PASS);
[r3, g3, l3] = simple_normalization_adjusted(EC,OFFSET,PASS);
[r4, g4, l4] = simple_standardization_adjusted(EC,OFFSET,PASS);

% Display STD of global
disp('Simple Scaling:'); disp(std(g1));
disp('Simple Quartile:'); disp(std(g2));
disp('Simple Normalization Adjusted:'); disp(std(g3));
disp('Simple Standardization Adjusted:'); disp(std(g4));

% Display RMSE Change
disp('Creating X-Vector...');
P = 1:(PASS - OFFSET + 1);

% Plot Graph
disp('Rendering Graph...');
fig1 = figure;
plot(P, r1,'g', P,r2, 'b', P, r3, 'k', P, r4, 'm');

% Figure Settings
disp('Setting Plot Parameters');
xlabel('Point in Pass');
ylabel('RMSE of Local vs. Global')
ylim([0 1]);
legend({'Scaling', 'Quartile Scaling','Adj. Normalization','Adj. Standardization'});
title(strcat('Full Field Progressive Scaling [', FILENAME, ']'));

% Wait for close
waitforbuttonpress();
saveas(gcf, strcat('Progressive-', FILENAME, '-', '.tif'));
close;
