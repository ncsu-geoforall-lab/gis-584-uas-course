#!/usr/bin/env bash
# Downloads the Lake Wheeler GRASS project (~216 MB) into ~/grassdata. Assignments
# in Topics 3, 4 and 5 start from this project. Run it on demand; it is not part
# of container creation.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GRASSDATA="$HOME/grassdata"

# Single source of truth for dataset URLs is _variables.yml.
URL="$(awk '/^[[:space:]]*lake_wheeler_url:/ {print $2; exit}' "$REPO_ROOT/_variables.yml")"
if [ -z "$URL" ]; then
    echo "Could not read data.lake_wheeler_url from _variables.yml" >&2
    exit 1
fi

if [ -d "$GRASSDATA/Lake_Wheeler_NCspm" ]; then
    echo "$GRASSDATA/Lake_Wheeler_NCspm already exists, nothing to do."
    exit 0
fi

mkdir -p "$GRASSDATA"
echo "==> Downloading $URL"
curl -fL --progress-bar -o "$GRASSDATA/Lake_Wheeler_NCspm.zip" "$URL"

echo "==> Unpacking into $GRASSDATA"
unzip -q "$GRASSDATA/Lake_Wheeler_NCspm.zip" -d "$GRASSDATA"
rm "$GRASSDATA/Lake_Wheeler_NCspm.zip"

echo
echo "Start GRASS with:"
echo "  grass $GRASSDATA/Lake_Wheeler_NCspm/PERMANENT"
