# GIS/MAE 584 Mapping and Analytics Using UAS

[![Quarto Publish](https://github.com/ncsu-geoforall-lab/gis-584-uas-course/actions/workflows/publish.yml/badge.svg?branch=main)](https://github.com/ncsu-geoforall-lab/gis-584-uas-course/actions/workflows/publish.yml)
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/ncsu-geoforall-lab/gis-584-uas-course)

Course website for GIS/MAE 584 Mapping and Analytics Using UAS

## Requirements

[Quarto: v1.9.38](https://quarto.org/docs/get-started/)

## Configuration

Install Quarto following the directions at [https://quarto.org/docs/get-started/](https://quarto.org/docs/get-started/)

## GitHub Codespaces

A Codespace gives you the course stack in the browser with nothing to install
locally: GRASS 8.5 built with GDAL and PDAL, Python 3.12 with the packages in
`requirements.txt`, Jupyter, Quarto, and the GRASS addons the assignments use.

Start one from **Code > Codespaces > Create codespace on main**, or with the
badge above. The first build takes about 10 minutes.

The Lake Wheeler GRASS project is not in the repository. Download it inside the
Codespace with:

```bash
bash .devcontainer/get-course-data.sh
grass ~/grassdata/Lake_Wheeler_NCspm/PERMANENT
```

See [.devcontainer/README.md](.devcontainer/README.md) for what the environment
contains and what it does not cover (WebODM, Agisoft Metashape, the wxGUI).

## Development

To start the development server, run:

```bash
quarto preview
```

## Structure

The course is organized into topics, each containing lectures and labs. The main sections are:

### Topics

- course/topics/topic_1_uas_basics
- course/topics/topic_2_sfm
- course/topics/topic_3_flight_planning
- course/topics/topic_4_GIS_analytics
- course/topics/topic_5_advanced_analytics
- course/topics/topic_6_change_detection
- course/topics/topic_7_odm

#### Custom Headers

The schedule listing is generated from the front matter of each topic's `part_*.qmd` and `assignments/assignment_*.qmd` files, plus `course/content/special_dates.yml`. The following fields are used to populate the schedule:

- date
- topic
- activity
- title
- assignment-due-date

### Special Files

- **_variables.yml**: Contains global variables used throughout the course.
- **_quarto.yml**: Quarto project configuration, including the explicit sidebar tree.
- **course/content/special_dates.yml**: Contains important dates for the course.
- **CONTRIBUTING.md**: Topic layout convention, frontmatter schema, and the new-semester checklist.

### Optimize Images

Convert images to webp format using the following commands:

```bash
mogrify -format webp -quality 80 *.{png,PNG,jpg,JPG}
```

### Converting Reveal.js slides to Quarto

To convert Reveal.js slides to Quarto, use the following command:

```bash
./update_lecture_images.sh <input_file> <input_image_dir> <output_dir> 
```

For example, this code converts the images found in the lecture_2b.qmd file to webp format and saves them to the course/topics/topic_2_sfm/images directory:

```bash
./update_lecture_images.sh "course/topics/topic_2_sfm/lectures/lecture_2b.qmd" "../uav-lidar-analytics-course/lectures/" "course/topics/topic_2_sfm/images
```

## Deployment

The site is deployed to GitHub Pages by the `Quarto Publish` workflow (`.github/workflows/publish.yml`) on every push to `main`. The workflow renders the site with the production profile (`QUARTO_PROFILE=production`, which disables freeze and re-executes all code cells) and pushes `docs/` to the `gh-pages` branch (Pages is set to deploy from that branch). The rendered `gh-pages` content is also what the "Open in Colab" badges reference for generated notebooks. Pull requests to `main` are render-checked by `.github/workflows/pr-check.yml`.

## Install Python Dependencies

Dependencies are managed with [uv](https://docs.astral.sh/uv/):

```bash
uv venv
uv pip install -r requirements.txt
source .venv/bin/activate
```

## Authors

Copyright 2025

- Corey T. White, NCSU GeoForAll Lab
- Helena Mitasova, NCSU GeoForAll Lab
- Justyna Jeziorska

Course developed by GeoForAll Lab at The Center for Geospatial Analytics at North Carolina State University

## License and use

The course material is under CC BY-SA 4.0 license.

[https://creativecommons.org/licenses/by-sa/4.0/](https://creativecommons.org/licenses/by-sa/4.0/)
