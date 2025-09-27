# Bambu Studio CLI Wrapper using Docker

This is a Dockerfile for building a Docker image that runs **[BambuStudio](https://github.com/bambulab/BambuStudio)** in CLI mode.  
It allows you to slice and export models directly from the command line inside a container.  
The image is based on **Ubuntu 22.04** and bundles all dependencies required for the AppImage.

## Build

Clone this repository and build the image:

```bash
git clone https://github.com/yourusername/bambu-studio-cli-docker.git
cd bambu-studio-cli-docker
docker build -t bambu-cli .
```

## Usage

Run the container and mount your working directory (e.g. current folder):

```bash
docker run --rm -v ./:/data bambu-cli [options] [file]
```

To run on Windows, you might have to change the volume mount to use an absolute path. In PowerShell, this can be achieved using `-v  "${PWD}:/data"`:

```PowerShell
docker run --rm -v "${PWD}:/data" bambu-cli [options] [file]
```

## Example Commands

Slice an STL file and export to `.3mf`:

```bash
docker run --rm -v ./:/data bambu-cli \
  --slice 1 \
  --arrange 1 \
  --export-3mf /data/sliced.3mf \
  /data/model.stl
```

Slice `3mf` from a `.3mf` project, to then send to the printers SD-Card:

```bash
docker run --rm -v "${PWD}:/data" bambu-cli \
  --export-3mf /data/output.3mf \
  /data/project.3mf
```

- `/data/input.stl` -> your input model
- `/data/output.3mf` -> sliced/exported output
- CLI arguments after `bambu-cli` are passed directly to the Bambu Studio executable. (See `--help`)

## Notes

- The AppImage version used is **Bambu Studio v02.02.02.56 (PR-8184)**.
  You can update the Dockerfile to use a newer release if needed (See Comments in `Dockerfile`).
- Since the AppImage is extracted, **FUSE is not required** at runtime.
- Designed for **CLI mode only** (no GUI/X11 support).

## License

This repository only provides a Docker wrapper build script.
Bambu Studio itself is released under [AGPLv3](https://github.com/bambulab/BambuStudio/blob/master/LICENSE).
Please check the official [Bambu Studio repository](https://github.com/bambulab/BambuStudio) for licensing details.
