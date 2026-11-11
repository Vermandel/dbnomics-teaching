# Canonical guide revision — 11 November 2026

This is the single generic DBnomics guide, not a BTM variant. English language and the original Dauphine design are preserved. The duplicate BTM PDF is replaced by a link to the canonical guide.

- Removed section 7; retained essential error, source and missing-data advice where it is needed.
- Added current home/series screenshots and the exact OECD page URL and complete public series token. It is not an API credential.
- Two runnable MATLAB plotting examples, two actual series each: datetime dates versus fractional numeric years. Source listings are included directly in the PDF with minted's matlab lexer.
- Preserved the real call_dbnomics signature and date-union/NaN alignment. No alternative API interface or TLS workaround was introduced.
- Published academic source dependencies and a native-Linux temporary build script; logs, synthetic fixtures and downloaded observations remain private.

## Validation

MATLAB R2025a Update 1 (25.1.0.2973910), Windows PCWIN64, invoked from WSL using the absolute Windows executable and a Windows-local working directory:

- Live Austria/Belgium download: 313 aligned rows, two plotted lines per example; datetime and numeric type/length checks passed.
- All requests in the guide passed, including four-country expansion, two measures/two countries and duplicate table headers.
- OECD public token: live request passed, annual Argentina current-account balance (% GDP), 2006–2025.
- Separate synthetic offline fixture: unsorted periods, unequal date coverage and missing values aligned exactly as expected. This is not a live-data test.
- Real LaTeX compilation with shell escape on the native Linux filesystem, including a rebuild from the public layout. Seven PDF pages visually inspected; no overfull boxes. Existing style font-substitution/bookmark warnings are non-blocking.

The manifest records the release's immutable content commit separately from the manifest commit, avoiding impossible self-reference. Remote publication and website changes are performed separately after final review.
