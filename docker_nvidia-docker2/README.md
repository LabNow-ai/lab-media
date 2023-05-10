# Install `nvidia-docker2` offline

[![Docker Pulls](https://img.shields.io/docker/pulls/qpod/nvidia-docker2.svg)](https://hub.docker.com/r/qpod/nvidia-docker2)
[![Docker Starts](https://img.shields.io/docker/stars/qpod/nvidia-docker2.svg)](https://hub.docker.com/r/qpod/nvidia-docker2)

This document and docker image helps you to install `nvidia-docker2` offline, which is especially usefull when your machine is in a restricted network.

## Install NVIDIA driver
Firstly, make sure you have installed NVIDIA driver.
You can download the run file and install it:
- Download page: https://www.nvidia.com/Download/index.aspx
- Document: https://docs.nvidia.com/datacenter/tesla/tesla-installation-notes/index.html

Before you install the driver, please change the following configurations and restart your machine.
```bash
sudo tee /etc/modprobe.d/blacklist-nouveau.conf <<< \
"blacklist nouveau
options nouveau modeset=0
"

sudo update-initramfs -u && sudo reboot
```

## Install the `nvidia-docker2` Component

Originally, the component requires Internet connection or a mirror for the package manger.

This docker image helps you to get the installation package into a docker image and you can export the files to your local file system.

Please follow the instructions below to export install packages to your local file system and install them using your OS package mange (below is an example for Ubuntu).

```bash
# choose a folder to store tmp files
LOCAL_REPO="/tmp/nvidia-docker2"
LINUX_DIST="ubuntu20.04"

mkdir -pv ${LOCAL_REPO} && cd ${LOCAL_REPO}
docker run --rm -it -v $(pwd):/tmp qpod/nvidia-docker2

sudo tee /etc/apt/sources.list.d/nvidia-docker.list <<< \
"deb file://$LOCAL_REPO/libnvidia-container/${LINUX_DIST}/amd64 /
deb file://$LOCAL_REPO/nvidia-container-runtime/${LINUX_DIST}/amd64 /
deb file://$LOCAL_REPO/nvidia-docker/${LINUX_DIST}/amd64 /"

sudo apt-key add $LOCAL_REPO/nvidia-docker/gpgkey
sudo apt-get update
sudo apt-get install nvidia-docker2
```
