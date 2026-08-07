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

Some pages execute Python (jupyter engine). Use the repo venv:

```bash
python3 -m venv venv && source venv/bin/activate
pip3 install -r requirements.txt
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

The site is driven by Quarto conventions in `_quarto.yml`; file naming and frontmatter are load-bearing:

- **Topics** live in `course/topics/topic_N_<name>/`. A topic has an `index.qmd`, content pages named `part_*.qmd` (or subtopic dirs like `2A_photogrammetry_and_SfM/` with their own `index.qmd`), `lectures/lecture_*.qmd` (Reveal.js slides), `assignments/assignment_*.qmd`, and `images/`.
- **Sidebar** is auto-generated from the glob `course/topics/**/part_*.qmd` (numbered, depth 2). A page only appears in the Topics sidebar if it matches that pattern.
- **Schedule** (`course/schedule.qmd`) is a listing built from frontmatter of `part_*.qmd`, `assignments/assignment_*.qmd`, and `course/content/special_dates.yml`. Fields used: `date`, `topic`, `activity`, `title`, `assignment-due-date`. Set `hide-from-listing: true` to keep a page out of the schedule. One-off dates (holidays, project milestones, due-date overrides) go in `special_dates.yml`.
- **`_variables.yml`** holds all semester-specific values: term, syllabus/Moodle/Panopto links, software versions (GRASS, Agisoft, WebODM), and dataset URLs on Google Cloud Storage (`gis-course-data` bucket). Pages reference them via `{{< var ... >}}` shortcodes. For a new semester, update this file rather than editing links inline in qmd files.

## Conventions

- Dates in frontmatter are M/D/YYYY and control schedule ordering; keep them consistent when rolling the course to a new term.
- Data files are hosted on GCS, not in the repo; add new dataset URLs under `data:` in `_variables.yml`.
- Write "GRASS", never "GRASS GIS".
