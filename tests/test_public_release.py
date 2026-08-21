#!/usr/bin/env python3
"""Fast structural checks: no downloaded data or generated release artefacts."""

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
assert (ROOT / "guide/dbnomics-teaching.tex").is_file()
assert (ROOT / "guide/dbnomics-teaching.pdf").is_file()
assert (ROOT / "examples/python/download_series.py").is_file()
assert (ROOT / "examples/matlab/download_series.m").is_file()
assert not list(ROOT.rglob("*.log"))
assert not list(ROOT.rglob("*.aux"))
assert not list(ROOT.rglob("*.mat"))
print("PASS public teaching release structure")
