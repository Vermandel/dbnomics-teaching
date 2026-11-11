% DBnomics with MATLAB -- Gauthier Vermandel, Universite Paris-Dauphine-PSL
%% Several countries in one slug
root = fileparts(fileparts(mfilename('fullpath')));
addpath(root);
if exist(fullfile(root, 'code'), 'dir'), addpath(fullfile(root, 'code')); end

% The + sign expands the country dimension: one table column per country.
[output_mat, inflation, dates_nb] = call_dbnomics( ...
    'Eurostat/prc_hicp_manr/M.RCH_A.TOT_X_NRG.AT+BE+DE+FR');

% Dates are in output_mat(:,1). Missing observations remain NaN.
disp(inflation(end-min(4, height(inflation)-1):end, :));
fprintf('Final period: %.2f\n', dates_nb(end));
