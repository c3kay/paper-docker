# PaperMC Server Docker Image

![Build Status](https://img.shields.io/github/actions/workflow/status/c3kay/paper-docker/build.yml)

This is a simple docker image for a Minecraft PaperMC Server running on Amazon Corretto.

## Installation

Pull the image via:

```sh
docker pull ghcr.io/c3kay/paper-docker
```

...or see the example `compose.yml` file.

## Configuration & Usage

All data and configs are located in the `/data` folder. You can map a docker volume or local directory to persist this folder.

The following environment variables can be set:
- `PUID`: The UID of the user running the server (default: `1000`).
- `MEM_SIZE`: Allocated memory for the server.
- `PAPERMC_FLAGS`: Additional flags for PaperMC.
- `JAVA_FLAGS`: JVM specific flags.

For PaperMC specific configs refer to the [official documentation](https://docs.papermc.io/paper/reference/configuration).
