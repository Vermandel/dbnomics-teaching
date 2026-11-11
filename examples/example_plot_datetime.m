%% DBnomics with MATLAB -- Gauthier Vermandel, Universite Paris-Dauphine-PSL
% Run from any folder; locate the single call_dbnomics interface.
root = fileparts(fileparts(mfilename('fullpath')));
addpath(root);
if exist(fullfile(root, 'code'), 'dir'), addpath(fullfile(root, 'code')); end
[mat, tab, dates_nb] = call_dbnomics( ...
    'Eurostat/prc_hicp_manr/M.RCH_A.TOT_X_NRG.AT', ...
    'Eurostat/prc_hicp_manr/M.RCH_A.TOT_X_NRG.BE');
assert(size(mat,2) == 3 && height(tab) == size(mat,1));
assert(isequaln(tab{:,:}, mat(:,2:3)));
t = datetime(mat(:,1), 'ConvertFrom', 'datenum');
assert(numel(t) == size(mat,1) && all(diff(mat(:,1)) > 0));
figure
plot(t, mat(:,2), '-', t, mat(:,3), '--', 'LineWidth', 1.2)
grid on
legend('Austria', 'Belgium', 'Location', 'best')
title('HICP inflation excluding energy')
ylabel('Annual percentage change')
xlabel('Date')
