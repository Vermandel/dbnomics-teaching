# Note de remplacement — 26 août 2026

## Remplacé

Le commit initial `1e013ef` d'Athéna apportait un guide générique, un client
Python, des fonctions MATLAB `download_series`/`parse_dbnomics_period` et des
exemples associés. Ces interfaces concurrentes ont été retirées. Le nouveau
matériel reprend la fonction proposée par Gauthier dans
`Dropbox/Teaching/dbnomics/call_dbnomics.m` et les cas du PDF source.

## Livrables

- une seule interface publique : `code/call_dbnomics.m` ;
- quatre scripts MATLAB commentés, inspirés du PDF source ;
- le guide PDF `guide/call_dbnomics-guide.pdf` ;
- un test MATLAB réseau `tests/test_call_dbnomics.m`.

## Validation

- `latexmk -pdf -interaction=nonstopmode -halt-on-error
  call_dbnomics-guide.tex` : PASS, PDF A4 de 2 pages ;
- `tests/test_call_dbnomics.m` et les quatre exemples ont été exécutés avec
  MATLAB R2025a et DBnomics : PASS ;
- audit Git public : aucun `.tex`, `.sty`, `.cls`, `.bib` ou artefact LaTeX
  n'est suivi ; aucun identifiant ou secret n'est requis.
