%% Minimal network test: run in MATLAB from the repository root.
root = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(root, 'code'));
[matrix, tab, readable_dates] = call_dbnomics( ...
    'Eurostat/prc_hicp_manr/M.RCH_A.TOT_X_NRG.AT+BE');

assert(size(matrix, 2) == 3, 'Deux pays doivent produire deux colonnes de valeurs.');
assert(height(tab) == size(matrix, 1), 'Table and matrix must be aligned.');
assert(numel(readable_dates) == size(matrix, 1), 'Date vector must be aligned.');
assert(all(diff(matrix(:, 1)) > 0), 'Dates must be strictly increasing.');
assert(ismember('AT', tab.Properties.VariableNames), 'AT column is missing.');
assert(ismember('BE', tab.Properties.VariableNames), 'BE column is missing.');
disp('PASS test_call_dbnomics');
