# DBnomics for Macroeconomic Data

A small, reusable teaching repository for downloading macroeconomic data from
[DBnomics](https://db.nomics.world/). It is deliberately not tied to one
course: the guide and examples can be cited from any class using MATLAB,
Dynare, or Python.

## Start here

Read the [canonical guide (PDF)](guide/dbnomics-teaching.pdf), then run one of
the examples below. No downloaded dataset is committed to this repository.

    git clone https://github.com/Vermandel/dbnomics-teaching.git
    cd dbnomics-teaching
    python3 examples/python/validate_examples.py
    python3 examples/python/download_series.py ECB/EXR/M.USD.EUR.SP00.A --output /tmp/eurusd.csv

The command writes a tidy CSV with series, period, and value columns. It can
be read by MATLAB, or transformed further for a Dynare workflow.

## Verified examples

All identifiers below were called through the DBnomics API on **21 August
2026**. DBnomics provider codes matter: the World Bank provider is `WB`, not
`WorldBank`.

| Frequency | Provider / dataset | Series | Illustration |
| --- | --- | --- | --- |
| Monthly | ECB / EXR | M.USD.EUR.SP00.A | USD per euro spot exchange rate |
| Monthly, two series | ECB / EXR | M.USD.EUR.SP00.A, M.GBP.EUR.SP00.A | aligned exchange-rate download |
| Quarterly | IMF / IFS | Q.FR.NGDP_R_SA_XDC | French real GDP, seasonally adjusted |
| Annual | WB / WDI | A-NY.GDP.MKTP.KD-FRA | French GDP in constant 2015 US dollars |

The original requested spelling WorldBank/WDI/... returns HTTP 404; the
working, tested identifier is WB/WDI/A-NY.GDP.MKTP.KD-FRA.

## Layout

* guide/ — LaTeX source and compiled reference PDF.
* examples/python/ — standard-library downloader, validation and transformation examples.
* examples/matlab/ — MATLAB webread examples, including date parsing and CSV export.
* tests/ — a no-network structural test for the public release.

## Reproducibility and citation

Record the provider, dataset, series code, API URL, access date, frequency,
transformations, and any missing-value rule alongside an empirical result.
DBnomics aggregates data supplied by providers; cite the original provider as
well as DBnomics where appropriate. Consult each series' metadata and licence
before redistribution.

## Requirements

* Python 3.9+ for the Python examples (standard library only).
* MATLAB with webread, jsondecode, readtable, and writetable for the MATLAB examples.
* A LaTeX installation only to rebuild the guide PDF.

## Regenerating the guide

    cd guide
    pdflatex dbnomics-teaching.tex
    pdflatex dbnomics-teaching.tex

The PDF is versioned intentionally; aux, log, and other build products are
ignored.
