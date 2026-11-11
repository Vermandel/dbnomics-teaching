# DBnomics with MATLAB

One generic guide for every course, by Gauthier Vermandel (Université Paris-Dauphine–PSL).

- [Canonical guide PDF](https://raw.githubusercontent.com/Vermandel/dbnomics-teaching/main/guide/call_dbnomics-guide.pdf)
- [Repository](https://github.com/Vermandel/dbnomics-teaching)

Download the repository. In MATLAB, run `run('examples/example_plot_datetime.m')` or `run('examples/example_plot_numeric.m')`. Each downloads and plots **two** series, Austrian and Belgian HICP annual inflation excluding energy. The scripts locate `code/call_dbnomics.m` themselves. In the standalone academic source folder the same interface is at the root.

The public series token is the entire `provider/dataset/series` path, not a secret API key. Example:

`OECD/DSD_KEI@DF_KEI/ARG.A.CA_GDP.PT_B1GQ._T.Y._Z`

[Open the example](https://db.nomics.world/OECD/DSD_KEI@DF_KEI/ARG.A.CA_GDP.PT_B1GQ._T.Y._Z): annual Argentine current-account balance as a percentage of GDP, not GDP growth.

## Interface and alignment

`[mat, tab, dates_nb] = call_dbnomics(token1, token2, ...)`

All series must have the same frequency. Dates are sorted and aligned on their union; missing observations remain NaN. Matrix column 1 contains MATLAB serial dates, columns 2 onward contain series in argument order. Convert column 1 with `datetime(mat(:,1),'ConvertFrom','datenum')`. For monthly observations `dates_nb` is year + (month-1)/12; it must not be passed to datetick.

## Rebuild and test

Linux dependencies: TeX Live, latexmk, minted and Pygments. Run `bash build-guide.sh`. It compiles with shell escape in a native Linux temporary directory and returns only the final PDF. The public source is `guide/source/dbnomics.tex`; the master has `dbnomics.tex` at its root. There is no BTM-specific version.

MATLAB integration test: `run('tests/test_call_dbnomics.m')`. Internet access is required. Tested with MATLAB R2025a Update 1, Windows 64-bit, on 11 November 2026. No additional toolbox is needed. Downloaded observations and private validation logs are not distributed.

The current website screenshots were captured on 11 November 2026. Always recheck source definitions, units, coverage and revision policy. Cite the original provider and DBnomics as appropriate.
