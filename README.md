# SESSF_references

Shared bibliography for reports on the Southern and Eastern Scalefish and Shark Fishery (SESSF): stock assessments, discard estimates, CPUE standardisations and related work.

`SESSF.bib` is the single master copy. Reports point to it rather than keeping their own copies, so a reference corrected here is corrected everywhere.

## Contents

| File | Purpose |
|---|---|
| `SESSF.bib` | Master bibliography (BibLaTeX format, maintained with JabRef) |
| `check_bib.R` | Checks for duplicate keys, missing fields and unbalanced braces |
| `fisheries-research.csl` | Citation style used by SESSF reports (Fisheries Research, author-date) |

## Using it in an R Markdown report

1. Clone this repo once, anywhere you like.
2. Tell R where the file is by adding this line to your `.Renviron` (run `usethis::edit_r_environ()` or open `~/.Renviron`), then restart R:

   ```
   SESSF_BIB=C:/path/to/SESSF_references/SESSF.bib
   ```

3. In the report's YAML header:

   ```yaml
   bibliography:
     - "`r Sys.getenv('SESSF_BIB')`"
     - Report_specific.bib    # optional: references used only in this report
   ```

Each person sets their own path in `.Renviron`, so the report itself needs no changes between machines.

To use the citation style from this repo as well, add:

```yaml
csl: "`r file.path(dirname(Sys.getenv('SESSF_BIB')), 'fisheries-research.csl')`"
```

`fisheries-research.csl` is a dependent style: it names Elsevier Harvard as its parent, which pandoc downloads when the report is knitted.

## Adding or fixing references

1. `git pull` to get the latest version.
2. Edit `SESSF.bib` (JabRef or a text editor).
3. Run the check:

   ```
   Rscript check_bib.R
   ```

4. Commit and push.

Keep references that are only used in one report in that report's own `.bib` file.

## Note

This repository is public. It holds citation details only (authors, titles, years, publishers), the same information that appears in the reference lists of published reports. Do not add abstracts, notes, local file links or anything that is not already public.
