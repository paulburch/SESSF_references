# check_bib.R
# Basic checks on a BibTeX/BibLaTeX file before committing.
# Base R only, so it runs anywhere.
#
# Usage (from this folder):
#   Rscript check_bib.R            # checks SESSF.bib
#   Rscript check_bib.R other.bib
#
# Reports:
#   - duplicate citation keys (pandoc/citeproc uses the first one silently)
#   - entries missing author/editor, title or year/date
#   - entries with unbalanced braces
# Exits with status 1 if any duplicate keys or unbalanced braces are found.

args <- commandArgs(trailingOnly = TRUE)
bib_file <- if (length(args) > 0) args[1] else "SESSF.bib"

if (!file.exists(bib_file)) stop("File not found: ", bib_file)

lines <- readLines(bib_file, warn = FALSE, encoding = "UTF-8")

# Locate entry starts, skipping @comment/@string/@preamble
start_re <- "^\\s*@([A-Za-z]+)\\s*\\{\\s*([^,\\s]*)\\s*,?"
starts <- grep(start_re, lines, perl = TRUE)
parts <- regmatches(lines[starts], regexec(start_re, lines[starts], perl = TRUE))
types <- tolower(vapply(parts, `[`, character(1), 2))
keep <- !types %in% c("comment", "string", "preamble")
starts <- starts[keep]
keys <- vapply(parts[keep], `[`, character(1), 3)
ends <- c(starts[-1] - 1, length(lines))

entries <- Map(function(s, e) paste(lines[s:e], collapse = "\n"), starts, ends)

has_field <- function(txt, field) {
  grepl(paste0("(^|\\n)\\s*", field, "\\s*="), txt, ignore.case = TRUE, perl = TRUE)
}

brace_balance <- function(txt) {
  chars <- strsplit(gsub("\\\\[{}]", "", txt), "")[[1]]
  sum(chars == "{") - sum(chars == "}")
}

# Checks
dup_keys <- names(which(table(keys) > 1))

missing <- data.frame(
  line   = starts,
  key    = keys,
  author = vapply(entries, function(x) has_field(x, "author") | has_field(x, "editor"), logical(1)),
  title  = vapply(entries, has_field, logical(1), field = "title"),
  year   = vapply(entries, function(x) has_field(x, "year") | has_field(x, "date"), logical(1))
)
missing <- missing[!(missing$author & missing$title & missing$year), ]

unbalanced <- data.frame(line = starts, key = keys,
                         balance = vapply(entries, brace_balance, numeric(1)))
unbalanced <- unbalanced[unbalanced$balance != 0, ]

# Report
cat(sprintf("%s: %d entries\n\n", bib_file, length(keys)))

cat(sprintf("Duplicate keys: %d\n", length(dup_keys)))
for (k in dup_keys) {
  cat(sprintf("  %-40s lines %s\n", k, paste(starts[keys == k], collapse = ", ")))
}

cat(sprintf("\nEntries missing author/editor, title or year/date: %d\n", nrow(missing)))
for (i in seq_len(nrow(missing))) {
  m <- missing[i, ]
  gaps <- c("author", "title", "year")[!unlist(m[c("author", "title", "year")])]
  cat(sprintf("  line %-5d %-40s missing: %s\n", m$line, m$key, paste(gaps, collapse = ", ")))
}

cat(sprintf("\nEntries with unbalanced braces: %d\n", nrow(unbalanced)))
for (i in seq_len(nrow(unbalanced))) {
  cat(sprintf("  line %-5d %s\n", unbalanced$line[i], unbalanced$key[i]))
}

if (length(dup_keys) > 0 || nrow(unbalanced) > 0) quit(status = 1)
