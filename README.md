# DBnomics avec MATLAB

Ce dépôt fournit une prise en main immédiatement utilisable de DBnomics dans
MATLAB. Toute récupération de données passe par une seule interface :
[`call_dbnomics.m`](code/call_dbnomics.m). Il ne contient ni client Python ni
fonction MATLAB concurrente.

## Démarrage rapide

1. Téléchargez ce dépôt et ajoutez `code/` au chemin MATLAB.
2. Exécutez un script du dossier `examples/`, par exemple
   `examples/example_single_series.m`.
3. Remplacez le *slug* par celui copié depuis DBnomics :
   `provider/dataset/series`.

```matlab
addpath('code')
[output_mat, output_table, dates_nb] = call_dbnomics( ...
    'Eurostat/prc_hicp_manr/M.RCH_A.TOT_X_NRG.AT');
```

Le guide étudiant est disponible ici :
[guide/call_dbnomics-guide.pdf](guide/call_dbnomics-guide.pdf).

## Contenu

- `code/call_dbnomics.m` — interface unique de téléchargement ;
- `examples/` — séries simple, plusieurs pays, plusieurs séries et graphique ;
- `tests/test_call_dbnomics.m` — test MATLAB exécutable ;
- `guide/call_dbnomics-guide.pdf` — documentation pédagogique compilée ;
- `RELEASE_NOTE.md` — inventaire du remplacement et validations.

Les données sont téléchargées au moment de l'exécution et ne sont pas
versionnées. Vérifiez toujours définition, unité, fréquence, ajustement
saisonnier, couverture et licence sur la page du fournisseur. Citez le
fournisseur original, ainsi que DBnomics lorsque c'est pertinent.
