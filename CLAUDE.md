# CLAUDE.md: References

Project "References": Paul Burch's master BibTeX/BibLaTeX database for SESSF
reports (`SESSF.bib`). See `README.md` for how reports use it. Use Australian
English.

## Hard rules

1. **This repository is public** (GitHub `paulburch/SESSF_references`).
   Citation details only: authors, titles, years, publishers, DOIs, URLs of
   public copies. No abstracts, notes, local file links, unreleased reports,
   RAG papers before release, or anything with AFMA data. This file is public
   too: keep machine-specific or private details out of it.
2. **One master copy.** Do not copy `SESSF.bib` into other projects; reports
   point to it through the `SESSF_BIB` environment variable. References used
   by only one report go in that report's own `.bib`.
3. **Check after every edit:** `Rscript check_bib.R` (base R; R 4.4.1). It
   must report no duplicate keys or unbalanced braces.
4. **Git:** commits use the personal identity already in this repo's local
   git config; never the work GitHub account. Do not push unless Paul asks.

## Editing references

- Format is BibLaTeX, maintained with JabRef; keep JabRef's layout when
  editing by hand (CRLF line endings, set in `.gitattributes`).
- Before adding an entry, search for an existing one (by DOI, title and
  first author/year) so no duplicates or near-duplicate keys appear.
- Keep existing citation keys: reports already cite them. Fix a key only
  when Paul asks, and list the reports that may cite it.
- Details for SESSF reports can be checked against Paul's public reports
  library (read only, through the `reportlibrary` R package); cite by its
  catalogue details, never by its local file paths.
- A DOI must be checked against the document's own title before it is added.

## Status (13 Nov 2026)

496 entries; `check_bib.R` clean (6 duplicate entries removed or merged,
1 Nov 2026; 25 Tiger Flathead 2022 references added 11 Nov 2026).

- 13 Nov 2026 (Paul asked): 149 entries merged in from the SESSF catch history
  report's `SESSF_Catch_History.bib` and `SESSF_Catch_History_claude.bib`
  (notes stripped). Four existing entries took the catch history version
  (Day2007whiting, Pease1995nsw, Thomson2020school author list,
  Burch2024catch-jan without Robin Thomson). Left out as unreleased or
  unpublished: Althaus2026catch, Thomson2026dwsharks, Burch2026discards,
  SESSFRAG2026chairs, SERAG2026oct, SlopeRAG2011minutes (draft),
  Hall2024whiting (draft FRDC report), Liggins2020advice, Klaer2013catchhist;
  Lynch2003GAB left out (wrong authors; Lynch2003gab-afma replaces it).
- Many merged entries still need their details checked (they carried "check
  details" notes in the catch history bibs). Morison2013 has no year. The same
  documents appear under two keys in a few places (e.g. Haddon2011sawele and
  Haddon2011sawshark), kept because the chapters cite both.
- 14 Nov 2026 (Paul asked): checked Geoff Tuck's merge of `SESSF.bib` with his
  `SESSF_v1.bib`. Added Punt2026mortality, Hamel2022mortality (DOIs checked on
  Crossref) and Methot2026ss; 499 entries, `check_bib.R` clean. Left out
  Tuck2026flathead-oct and Sporcic2026sessfcpue-draft (SERAG October 2026
  papers, not yet released) and Smith2000sef_v1 (same document as
  Rowling1999redfish, with wrong authors).
- 20 Nov 2026 (Paul asked): 51 entries added for the Tier 4 code and history
  review (`Assessments_Tier_4/Haddon_code_review/review`): Tier 4 reports
  (Haddon 2013 draft, 2015, 2016 and 2017 Blue-eye; Little et al. 2008, 2010;
  Wayte and Fuller 2008; Sporcic and Haddon 2018 deepwater CPUE), Tuck (ed.)
  volumes 2014--2022 as @Collection, AFMA TAC recommendations, HSF 2021,
  interim harvest strategy 2025, and ShelfRAG, SlopeRAG, SharkRAG, SERAG,
  SESSFRAG and GABRAG minutes 2009--2025. 550 entries; `check_bib.R` clean.
  Where a report is already here as a stand-alone paper (e.g. Haddon2013tier4,
  Sporcic2020tier4-dec) the review reuses that key, although its page numbers
  come from the Tuck chapter version.
