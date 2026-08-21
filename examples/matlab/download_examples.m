% Download monthly, quarterly and annual examples. No data file is versioned:
% this script creates reproducible local files in ../output.
root = fileparts(fileparts(mfilename('fullpath')));
out = fullfile(root, 'output');

monthly = download_series('ECB', 'EXR', 'M.USD.EUR.SP00.A', fullfile(out, 'eurusd-monthly.csv'));
monthly.date = parse_dbnomics_period(monthly.period);
quarterly = download_series('IMF', 'IFS', 'Q.FR.NGDP_R_SA_XDC', fullfile(out, 'france-real-gdp-quarterly.csv'));
quarterly.date = parse_dbnomics_period(quarterly.period);
annual = download_series('WB', 'WDI', 'A-NY.GDP.MKTP.KD-FRA', fullfile(out, 'france-real-gdp-annual.csv'));
annual.date = parse_dbnomics_period(annual.period);

% A simple missing-data rule: keep the missing value as NaN; never silently
% interpolate it. Choose and document any later treatment for the model.
annual.growthPercent = [NaN; 100 * diff(annual.value) ./ annual.value(1:end-1)];

% For a Dynare pre-processing workflow, select a common frequency and write
% the numerical matrix only after documenting its column order and date range.
writetable(quarterly(:, {'date', 'value'}), fullfile(out, 'dynare-input-example.csv'));
