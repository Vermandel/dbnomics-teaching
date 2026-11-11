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

set(groot, 'defaultFigureVisible', 'off');
for mode = {'datetime', 'numeric'}
    run(fullfile(root, 'examples', ['example_plot_' mode{1} '.m']));
    assert(numel(findobj(gca, 'Type', 'line')) == 2);
    assert(isequaln(tab{:,:}, mat(:,2:3)));
    if strcmp(mode{1}, 'datetime'), assert(isdatetime(t)); else, assert(isnumeric(t)); end
    close(gcf);
end
[o,~,~] = call_dbnomics('OECD/DSD_KEI@DF_KEI/ARG.A.CA_GDP.PT_B1GQ._T.Y._Z');
assert(size(o,2) == 2 && size(o,1) > 0);
disp('PASS plots and OECD public token');
