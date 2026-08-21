#!/usr/bin/env python3
"""Download one or more DBnomics series to a tidy CSV, without third-party packages."""

from __future__ import annotations

import argparse
import csv
import json
from pathlib import Path
from urllib.parse import quote
from urllib.request import urlopen

API_ROOT = "https://api.db.nomics.world/v22/series"


def split_identifier(identifier: str) -> tuple[str, str, str]:
    """Return provider, dataset and series code from PROVIDER/DATASET/SERIES."""
    pieces = identifier.split("/", 2)
    if len(pieces) != 3 or not all(pieces):
        raise ValueError("identifier must be PROVIDER/DATASET/SERIES")
    return pieces[0], pieces[1], pieces[2]


def api_url(identifier: str) -> str:
    provider, dataset, series = split_identifier(identifier)
    return "{}/{}/{}/{}?observations=1".format(
        API_ROOT, quote(provider), quote(dataset), quote(series, safe=".")
    )


def download(identifier: str) -> tuple[dict, list[tuple[str, float | None]]]:
    """Fetch one series and retain DBnomics' original period strings."""
    with urlopen(api_url(identifier), timeout=30) as response:  # nosec B310: fixed HTTPS API
        payload = json.load(response)
    docs = payload.get("series", {}).get("docs", [])
    if len(docs) != 1:
        raise RuntimeError("DBnomics returned no unique series for {}".format(identifier))
    document = docs[0]
    periods = document.get("period", [])
    values = document.get("value", [])
    if len(periods) != len(values):
        raise RuntimeError("inconsistent observation arrays for {}".format(identifier))
    return document, list(zip(periods, values))


def write_tidy_csv(rows: list[tuple[str, str, float | None]], output: Path) -> None:
    output.parent.mkdir(parents=True, exist_ok=True)
    with output.open("w", newline="", encoding="utf-8") as stream:
        writer = csv.writer(stream)
        writer.writerow(["series", "period", "value"])
        writer.writerows(rows)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("identifiers", nargs="+", help="PROVIDER/DATASET/SERIES")
    parser.add_argument("--output", required=True, type=Path, help="output CSV path")
    parser.add_argument("--start", help="first period to retain (lexical DBnomics period order)")
    parser.add_argument("--end", help="last period to retain (lexical DBnomics period order)")
    args = parser.parse_args()

    rows: list[tuple[str, str, float | None]] = []
    for identifier in args.identifiers:
        document, observations = download(identifier)
        canonical = "/".join(
            (document["provider_code"], document["dataset_code"], document["series_code"])
        )
        if canonical != identifier:
            raise RuntimeError("API returned {}, not requested {}".format(canonical, identifier))
        selected = [
            (period, value)
            for period, value in observations
            if (args.start is None or period >= args.start)
            and (args.end is None or period <= args.end)
        ]
        rows.extend((canonical, period, value) for period, value in selected)
        print("{}: {} observations; {}".format(canonical, len(selected), api_url(identifier)))
    write_tidy_csv(rows, args.output)
    print("wrote {} rows to {}".format(len(rows), args.output))


if __name__ == "__main__":
    main()
