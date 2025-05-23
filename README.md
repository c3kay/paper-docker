# PaperMC Server Docker Image

A simple docker image for a Minecraft PaperMC Server running on Amazon Corretto.

The image is built and updated weekly with the latest stable version of PaperMC.

## Installation

```sh
docker pull ghcr.io/c3kay/paper-docker:<mc-version>
```

Check the [Packages page](https://github.com/c3kay/paper-docker/pkgs/container/paper-docker) for available versions.
Also see the example `compose.yml` file.

## Configuration & Usage

All data and configs are located in the `/opt/minecraft/data` folder.
You can map a docker volume or local directory to persist this folder.

The following environment variables can be set:

- `PUID`: The UID of the user running the server (default: `1000`).
- `MEM_SIZE`: Allocated memory for the server.
- `PAPERMC_FLAGS`: Additional flags for PaperMC.
- `JAVA_FLAGS`: JVM specific flags.

For PaperMC specific configs refer to the [official documentation](https://docs.papermc.io/paper/reference/configuration).
