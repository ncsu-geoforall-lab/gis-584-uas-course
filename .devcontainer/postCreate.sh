#!/usr/bin/env bash
# Builds the course Python environment inside the devcontainer. Runs once, when
# the container is created (or rebuilt).
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

VENV="$REPO_ROOT/.venv"
PY="$VENV/bin/python"

echo "==> Creating .venv (system site packages expose the image's GDAL bindings and numpy)"
uv venv --python /usr/bin/python3 --system-site-packages "$VENV"

# ultralytics and segment-geospatial both depend on torch. The default PyPI
# wheels drag in several GB of CUDA libraries that a Codespace cannot use, so
# pin the CPU build first and let the rest of the requirements resolve against it.
echo "==> Installing CPU-only PyTorch"
uv pip install --python "$PY" --index-url https://download.pytorch.org/whl/cpu torch torchvision

echo "==> Installing course requirements"
uv pip install --python "$PY" -r requirements.txt

echo "==> Installing GRASS addons used by the course"
bash "$REPO_ROOT/.devcontainer/install-grass-addons.sh" || \
    echo "WARNING: addon install reported problems, see the log above"

mkdir -p "$HOME/grassdata"

echo
echo "==> Environment"
# sed instead of head: head closes the pipe early, which trips SIGPIPE under
# `set -o pipefail`.
grass --version | sed -n '1p'
gdalinfo --version
pdal --version | sed -n '/pdal/p'
echo "Quarto $(quarto --version)"
"$PY" --version
echo
echo "GRASS database directory: $HOME/grassdata (empty)"
echo "Course data: bash .devcontainer/get-course-data.sh"
