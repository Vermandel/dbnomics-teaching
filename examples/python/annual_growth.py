#!/usr/bin/env python3
"""Download annual French GDP and write a simple percent-change transformation."""

from __future__ import annotations

import csv
from pathlib import Path

from download_series import download

IDENTIFIER = "WB/WDI/A-NY.GDP.MKTP.KD-FRA"
OUTPUT = Path("examples/output/french-annual-gdp-growth.csv")


def main() -> None:
    _, observations = download(IDENTIFIER)
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    with OUTPUT.open("w", newline="", encoding="utf-8") as stream:
        writer = csv.writer(stream)
        writer.writerow(["period", "gdp_constant_2015_usd", "growth_percent"])
        previous = None
        for period, value in observations:
            growth = None if value is None or previous in (None, 0) else 100 * (value / previous - 1)
            writer.writerow([period, value if value is not None else "", growth if growth is not None else ""])
            previous = value
    print("wrote {}; blank growth means missing value or no previous observation".format(OUTPUT))


if __name__ == "__main__":
    main()
