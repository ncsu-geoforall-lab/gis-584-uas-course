# Contributing

Conventions for maintaining the GIS/MAE 584 course site. File naming and
frontmatter are load-bearing: the sidebar, the schedule, and the topics index
are all generated from them.

## Topic layout

Every topic lives in `course/topics/topic_N_<name>/` with this shape
(`topic_2_sfm` is the canonical example):

```
topic_N_<name>/
  index.qmd                  # topic landing page (title, description, order)
  part_a_<slug>.qmd          # content pages, one per class session
  part_b_<slug>.qmd
  lectures/lecture_Na.qmd    # Reveal.js decks
  lectures/lecture_Nb.qmd
  assignments/assignment_Na.qmd
  assignments/lab_<slug>.qmd # sub-lab manuals linked from an assignment
  images/                    # webp only
  references.bib             # optional
```

- `part_*.qmd` and `assignments/assignment_*.qmd` appear on the schedule.
  Anything else (labs, demos, reference docs) uses a different prefix and stays
  off it; `hide-from-listing: true` is not needed if the filename does not
  match those globs.
- Reference docs get descriptive names (`faa_part_107_guide.qmd`).
- Lecture decks always sit at `course/topics/topic_N_x/lectures/` (depth 4) so
  `theme: [simple, ../../../../theme.scss]` works, and every deck carries
  `footer: "[Return Home](../part_<x>_<slug>.qmd)"` because Reveal output has
  no site navigation.

## Frontmatter schema

Dates are `M/D/YYYY` (no 2-digit years, no zero padding).

| Page type | Required fields |
|---|---|
| `part_*.qmd` | `topic`, `title`, `subtitle`, `date`, `activity` |
| `assignments/assignment_*.qmd` | `topic`, `title`, `date`, `activity: Lab`, `assignment-due-date` |
| topic `index.qmd` | `title` (`Topic N: <Name>`), `description`, `order` |
| labs, demos, references | `title` only |

- `topic:` is `"Topic <N><letter>: <Canonical Name>"`. Canonical names:
  1 UAS Basics, 2 Structure from Motion, 3 UAS Flight Planning,
  4 GIS Analytics, 5 Advanced Analytics, 6 Machine Learning & AI,
  7 OpenDroneMap. The schedule groups by this string; a typo creates a new
  category chip.
- `activity:` is one of: `Lecture`, `Lab`, `Lecture & Lab`, `Assignment Due`,
  `Exam`, `Field Trip`, `Guest Speaker`, `Project`, `No Class`.
- One-off dates (holidays, project milestones, due-date rows) go in
  `course/content/special_dates.yml` with the same fields.

## Notebook assignments and Colab badges

Assignments meant to run as notebooks publish a runnable `.ipynb` with the
site, generated at render time:

- qmd-based assignments add a second output format:
  `format: {html: ..., ipynb: default}`
- ipynb-based assignments (embedded via `notebook-view`) also list the
  notebook under `resources:` so it is copied into the output

The "Open in Colab" badge always points at the rendered copy on the
`gh-pages` branch, never at a Google Drive notebook:

```markdown
[![Open in Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/ncsu-geoforall-lab/gis-584-uas-course/blob/gh-pages/<path-to>.ipynb)
```

## Adding a page

1. Create the file following the layout and schema above.
2. Add it to the explicit sidebar tree in `_quarto.yml` (the sidebar is not
   generated from a glob).
3. Link it from the topic's `index.qmd`.
4. `quarto render` and check the schedule and sidebar.

## New semester checklist

1. Update `_variables.yml`: term, syllabus/Moodle/Panopto links, software
   versions, any new dataset URLs (GCS `gis-course-data` bucket).
2. Roll `date` and `assignment-due-date` in `part_*.qmd`,
   `assignments/assignment_*.qmd`, `course/topics/midterm/index.qmd`, and
   `course/content/special_dates.yml`.
3. Update recording links per topic page as new Panopto sessions post.

## Build

```bash
uv venv && uv pip install -r requirements.txt   # once
source .venv/bin/activate
quarto preview        # dev server
quarto render         # full render into docs/ (gitignored, never commit)
```

Images are webp: `mogrify -format webp -quality 80 *.{png,PNG,jpg,JPG}`.

Write "GRASS", never "GRASS GIS".
