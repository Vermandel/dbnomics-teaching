function T = download_series(provider, dataset, seriesCode, outputCsv)
%DOWNLOAD_SERIES Download one DBnomics series and optionally write a tidy CSV.
%   T = DOWNLOAD_SERIES('ECB','EXR','M.USD.EUR.SP00.A','eurusd.csv')
%   returns a table with DBnomics period strings and numeric values. Missing
%   observations are represented by NaN. Keep the original period strings until
%   the frequency is known; parse_dbnomics_period converts the examples here.

arguments
    provider (1,:) char
    dataset (1,:) char
    seriesCode (1,:) char
    outputCsv (1,:) char = ''
end

url = sprintf(['https://api.db.nomics.world/v22/series/%s/%s/%s' ...
    '?observations=1'], provider, dataset, seriesCode);
raw = webread(url);
doc = raw.series.docs(1);
period = string(doc.period(:));
value = double(doc.value(:));
value(~isfinite(value)) = NaN;
T = table(period, value, 'VariableNames', {'period', 'value'});

if ~isempty(outputCsv)
    folder = fileparts(outputCsv);
    if ~isempty(folder) && ~isfolder(folder)
        mkdir(folder);
    end
    writetable(T, outputCsv);
end
end
