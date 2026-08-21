#!/usr/bin/env python3
"""Live validation for every identifier advertised in this repository."""

from __future__ import annotations

from download_series import api_url, download

EXAMPLES = (
    "ECB/EXR/M.USD.EUR.SP00.A",
    "ECB/EXR/M.GBP.EUR.SP00.A",
    "IMF/IFS/Q.FR.NGDP_R_SA_XDC",
    "WB/WDI/A-NY.GDP.MKTP.KD-FRA",
)


def frequency_from_period(period: str) -> str:
    if "-Q" in period:
        return "quarterly"
    if len(period) == 7 and period[4] == "-":
        return "monthly"
    if len(period) == 4:
        return "annual"
    return "unclassified"


def main() -> None:
    for identifier in EXAMPLES:
        document, observations = download(identifier)
        canonical = "/".join(
            (document["provider_code"], document["dataset_code"], document["series_code"])
        )
        if canonical != identifier or not observations:
            raise RuntimeError("validation failed for {}".format(identifier))
        print(
            "PASS {} | {} | {}..{} | {} obs".format(
                canonical,
                frequency_from_period(observations[0][0]),
                observations[0][0],
                observations[-1][0],
                len(observations),
            )
        )
        print("  {}".format(api_url(identifier)))


if __name__ == "__main__":
    main()
