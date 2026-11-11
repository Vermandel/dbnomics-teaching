#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "$0")" && pwd)"
build="$(mktemp -d /tmp/dbnomics-guide.XXXXXX)"
trap 'rm -rf "$build"' EXIT
# Explicit academic dependencies only; never copy volatile editor auxiliaries.
if [[ -f "$root/dbnomics.tex" ]]; then
  src="$root"; out="$root/dbnomics.pdf"
else
  src="$root/guide/source"; out="$root/guide/call_dbnomics-guide.pdf"
fi
cp "$src/dbnomics.tex" "$src/mystyle.tex" "$src/logo-upd.png" "$build/"
cp -r "$src/captures" "$build/captures"
cp -r "$root/examples" "$build/examples"
(cd "$build" && latexmk -pdf -shell-escape -interaction=nonstopmode -halt-on-error dbnomics.tex)
cp "$build/dbnomics.pdf" "$out"
pdfinfo "$out" | grep Pages
sha256sum "$out"
