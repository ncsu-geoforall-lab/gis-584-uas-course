# GRASS 8.5 matches software.grass.version in _variables.yml. The osgeo image
# ships GRASS built against GDAL and PDAL, which is what Topics 3-5 need
# (r.in.pdal, v.in.pdal, the pdal CLI).
FROM osgeo/grass-gis:8.5.0-ubuntu

ENV DEBIAN_FRONTEND=noninteractive

# Devcontainer basics, the toolchain g.extension needs to build addons, and the
# runtime libraries OpenCV pulls in through ultralytics and segment-geospatial.
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        git \
        less \
        libgl1 \
        libglib2.0-0t64 \
        nano \
        openssh-client \
        procps \
        python3-dev \
        unzip \
        vim \
        wget \
        zip \
    && rm -rf /var/lib/apt/lists/*

# uv manages the course virtual environment, same as CONTRIBUTING.md describes
# for a local checkout.
COPY --from=ghcr.io/astral-sh/uv:0.9.6 /uv /uvx /usr/local/bin/

# Makes `import grass.script` work from any interpreter, including the .venv,
# without the `grass --config python_path` dance the notebooks use on Colab.
ENV PYTHONPATH=/usr/local/grass85/etc/python \
    UV_LINK_MODE=copy

WORKDIR /workspaces/gis-584-uas-course

CMD ["/bin/bash"]
