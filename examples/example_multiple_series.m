% DBnomics with MATLAB -- Gauthier Vermandel, Universite Paris-Dauphine-PSL
%% Two series with the same frequency, aligned on their date union
root = fileparts(fileparts(mfilename('fullpath')));
addpath(root);
if exist(fullfile(root, 'code'), 'dir'), addpath(fullfile(root, 'code')); end

[data_matrix, data_table, dates_nb] = call_dbnomics( ...
    'Eurostat/prc_hicp_manr/M.RCH_A.TOT_X_NRG.AT+DE', ...
    'Eurostat/prc_hicp_manr/M.RCH_A.TOT_X_TBC.AT+DE');

% A period absent from one series is NaN: do not interpolate without an
% explicit economic and statistical justification.
complete_rows = all(~isnan(data_matrix(:, 2:end)), 2);
sample = data_table(complete_rows, :);
fprintf('%d common dates out of %d downloaded dates.\n', ...
    height(sample), numel(dates_nb));
