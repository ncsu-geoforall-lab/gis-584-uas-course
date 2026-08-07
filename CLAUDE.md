# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Course website for GIS/MAE 584 "Mapping and Analytics Using UAS" (NC State, GeoForAll Lab). A Quarto website project (Quarto v1.7.32) rendered to `docs/` and published to GitHub Pages. Planner Organization: NCSU. Content is CC BY-SA 4.0.

## Commands

```bash
quarto preview          # dev server with live reload
quarto render           # full site render into docs/
quarto render course/topics/topic_2_sfm/assignments/assignment_2a.qmd   # single file
```

Some pages execute Python (jupyter engine). Dependencies are managed with uv:

```bash
uv venv && uv pip install -r requirements.txt
source .venv/bin/activate
```

Image optimization (all images should be webp):

```bash
mogrify -format webp -quality 80 *.{png,PNG,jpg,JPG}
```

`./update_lecture_images.sh <input_file> <input_image_dir> <output_dir>` converts image references in a Reveal.js lecture qmd and copies the webp versions in.

## Build and deploy model

- `execute: freeze: auto` in `_quarto.yml`: local renders reuse cached results in `_freeze/`. The production profile (`_quarto-production.yml`, activated with `QUARTO_PROFILE=production`) sets `freeze: false`, so CI re-executes all code cells.
- `docs/` and `_freeze/` are gitignored build artifacts; never commit or hand-edit them.
- CI: `.github/workflows/pr-check.yml` renders the site on PRs to `main`; `publish.yml` renders with the production profile and deploys to GitHub Pages on push to `main`.

## Content architecture

The site is driven by Quarto conventions in `_quarto.yml`; file naming and frontmatter are load-bearing. CONTRIBUTING.md is the authoritative reference for the layout and frontmatter schema.

- **Topics** live in `course/topics/topic_N_<name>/` with a uniform shape: `index.qmd` (landing page with `title`, `description`, `order`), content pages `part_<letter>_<slug>.qmd`, `lectures/lecture_N<letter>.qmd` (Reveal.js decks, always depth 4 so the hardcoded `../../../../theme.scss` resolves; every deck has a "Return Home" footer), `assignments/assignment_N<letter>.qmd`, optional `assignments/lab_*.qmd` sub-lab manuals, and `images/` (webp).
- **Sidebar** is an explicit per-topic tree in `_quarto.yml` (NOT a glob). New pages must be added there manually and linked from the topic's `index.qmd`.
- **Topics index** (`course/topics/index.qmd`) is a listing over `topic_*/index.qmd` sorted by the `order` frontmatter field; it needs no maintenance when topics change.
- **Schedule** (`course/schedule.qmd`) is a listing built from frontmatter of `part_*.qmd`, `assignments/assignment_*.qmd`, `course/topics/midterm/index.qmd`, and `course/content/special_dates.yml`. Fields used: `date`, `topic`, `activity`, `title`, `assignment-due-date`. The `topic:` string format is `"Topic <N><letter>: <Canonical Name>"` and `activity:` is a controlled enum (`Lecture | Lab | Lecture & Lab | Assignment Due | Exam | Field Trip | Guest Speaker | Project | No Class`); both are exact-match grouping keys. Pages whose filenames don't match the globs (labs, demos, references) stay off the schedule automatically.
- **`_variables.yml`** holds all semester-specific values: term, syllabus/Moodle/Panopto links, software versions (GRASS, Agisoft, WebODM), and dataset URLs on Google Cloud Storage (`gis-course-data` bucket). Pages reference them via `{{< var ... >}}` shortcodes. For a new semester, update this file rather than editing links inline in qmd files. The nested `lake_wheeler:`/`wake_waste_transfer_center:` data tree is not yet referenced by pages; it is kept for future use (candidate for a STAC catalog).

## Conventions

- Dates in frontmatter are M/D/YYYY and control schedule ordering; keep them consistent when rolling the course to a new term.
- Data files are hosted on GCS, not in the repo; add new dataset URLs under `data:` in `_variables.yml`.
- Write "GRASS", never "GRASS GIS".
