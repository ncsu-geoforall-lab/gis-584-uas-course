# Devcontainer

A ready-to-use environment for the course assignments and for editing the site.
It runs in [GitHub Codespaces](https://github.com/features/codespaces) or locally
in VS Code with the Dev Containers extension.

## Start a Codespace

From the repository page: **Code > Codespaces > Create codespace on main**.
The first build takes roughly 10 minutes; after that the Codespace starts in
seconds. Locally: **Dev Containers: Reopen in Container** from the VS Code
command palette.

## What is in it

| Component | Version | Notes |
|---|---|---|
| GRASS | 8.5.0 | `osgeo/grass-gis:8.5.0-ubuntu`, built with GDAL and PDAL |
| GDAL | 3.12.3 | CLI and Python bindings |
| PDAL | CLI | used by `pdal info` in the point cloud lab |
| Python | 3.12 | Ubuntu 24.04 system interpreter |
| Quarto | 1.9.38 | matches the version in README.md |
| uv | 0.9.6 | creates and manages `.venv` |

`requirements.txt` is installed into `.venv` at container creation, together
with a CPU-only build of PyTorch (the default wheels pull in several GB of CUDA
libraries that a Codespace cannot use).

These GRASS addons are installed as well, because the assignments call them:
`i.segment.stats`, `i.superpixels.slic`, `r.confusionmatrix`, `r.learn.ml2`,
`r.local.relief`, `r.patch.smooth`, `r.sample.category`, `r.shaded.pca`,
`r.skyview`, `v.profile.points`. Anything else the assignments use is core
GRASS 8.5. Install more with `g.extension extension=<name>`.

`PYTHONPATH` points at the GRASS Python packages, so `import grass.script` and
`import grass.jupyter` work in any notebook or terminal without the
`grass --config python_path` step the Colab notebooks need.

## Course data

The GRASS project used from Topic 3 onward is not in the repository. Download it
into `~/grassdata` with:

```bash
bash .devcontainer/get-course-data.sh
```

Then start GRASS:

```bash
grass ~/grassdata/Lake_Wheeler_NCspm/PERMANENT
```

Individual rasters, orthophotos and point clouds are pulled straight from their
URLs in `_variables.yml` by the assignments, mostly through `r.import` and
`r.in.pdal`.

## Working on the site

```bash
quarto preview --port 4200
```

Port 4200 is forwarded and opens in the VS Code preview pane. `quarto preview`
otherwise picks a random port, which the forwarding rules do not cover, so pass
`--port` explicitly. A full render goes to `docs/`:

```bash
quarto render
```

## Notebooks

Jupyter is in `.venv` and the Python and Jupyter extensions are preinstalled, so
notebooks run directly in the editor. Port 8888 is forwarded for a standalone
server:

```bash
jupyter lab --ip 0.0.0.0 --no-browser
```

## Not covered

- **Topic 7 (WebODM)** needs Docker and enough RAM and disk for photogrammetry.
  Keep running it locally per `assignment_7a.qmd`.
- **Agisoft Metashape** (Topic 2) is licensed desktop software and is not in the
  container.
- **The wxGUI** is not usable here; this image has no display server. Work from
  the command line, from notebooks with `grass.jupyter`, or run the GUI in a
  local GRASS install.
