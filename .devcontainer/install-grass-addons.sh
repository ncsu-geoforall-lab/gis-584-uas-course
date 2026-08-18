#!/usr/bin/env bash
# GRASS addons the course assignments call. Everything else the assignments use
# is core GRASS 8.5. Failures are reported but do not stop container creation;
# any addon can be installed later with `g.extension extension=<name>`.
#
# g.extension warns that it cannot copy grassdocs.css and friends: the base image
# ships without the HTML manual, so addon manual pages are unstyled. Harmless.
set -uo pipefail

ADDONS=(
    i.segment.stats
    i.superpixels.slic
    r.confusionmatrix
    r.learn.ml2
    r.local.relief
    r.patch.smooth
    r.sample.category
    r.shaded.pca
    r.skyview
    v.profile.points
)

# g.extension needs a session, so run the whole list inside one temporary project.
grass --tmp-project XY --exec bash -c '
failed=""
for addon in "$@"; do
    echo "--> g.extension $addon"
    g.extension extension="$addon" || failed="$failed $addon"
done
if [ -n "$failed" ]; then
    echo "Addons that did not install:$failed"
    exit 1
fi
' _ "${ADDONS[@]}"
