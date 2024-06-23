# PaperMC Server Docker Image

![Build Status](https://img.shields.io/github/actions/workflow/status/c3kay/paper-docker/build.yml)
![MC Version](https://img.shields.io/badge/dynamic/yaml?url=https%3A%2F%2Fraw.githubusercontent.com%2Fc3kay%2Fpaper-docker%2Fmaster%2F.github%2Fworkflows%2Fbuild.yml&query=%24.jobs.build.env.MC_VERSION&label=minecraft)

This is a simple docker image for a Minecraft PaperMC Server running on Amazon Corretto.
The image is build daily with the latest stable build of PaperMC.
If a stable build is available for the latest Minecraft version, this image will also be updated to it.

## Installation

```sh
docker pull ghcr.io/c3kay/paper-docker
```

## Configuration & Usage

All configs and data are located in the `/data` folder. An unnamed docker volume is created by default to persist this data.
This can be customized by mapping your own docker volumes or local folders to the `/data` folder.

For PaperMC specific configs refer to the [official documentation](https://docs.papermc.io/paper/reference/configuration).
