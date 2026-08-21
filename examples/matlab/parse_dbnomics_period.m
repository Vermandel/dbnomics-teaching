function dates = parse_dbnomics_period(period)
%PARSE_DBNOMICS_PERIOD Parse annual, monthly, or quarterly DBnomics period labels.
%   The returned date is the first day of the period. This routine intentionally
%   rejects unknown conventions: check a series' metadata before extending it.

period = string(period(:));
dates = NaT(size(period));
for i = 1:numel(period)
    token = char(period(i));
    if ~isempty(regexp(token, '^\d{4}$', 'once'))
        dates(i) = datetime(str2double(token), 1, 1);
    elseif ~isempty(regexp(token, '^\d{4}-\d{2}$', 'once'))
        dates(i) = datetime(token, 'InputFormat', 'yyyy-MM');
    else
        match = regexp(token, '^(\d{4})-Q([1-4])$', 'tokens', 'once');
        if ~isempty(match)
            dates(i) = datetime(str2double(match{1}), 3 * str2double(match{2}) - 2, 1);
        else
            error('Unsupported DBnomics period: %s', token);
        end
    end
end
end
