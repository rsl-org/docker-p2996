#!/bin/bash
docker build --tag ghcr.io/rsl-org/fedora_devcontainer .
docker push ghcr.io/rsl-org/fedora_devcontainer