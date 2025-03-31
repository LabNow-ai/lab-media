# Install `nvidia-container-toolkit` (nvidia-ctk) offline

[![Docker Pulls](https://img.shields.io/docker/pulls/qpod/nvidia-ctk.svg)](https://hub.docker.com/r/qpod/nvidia-ctk)
[![Docker Starts](https://img.shields.io/docker/stars/qpod/nvidia-ctk.svg)](https://hub.docker.com/r/qpod/nvidia-ctk)

This document and docker image helps you to install `nvidia-ctk` (NVIDIA Container Toolkit) offline, which is especially usefull when your machine is in a restricted / air-gapped network.

## Step 1. Install container engine

Make sure you have installed your container engine (e.g. docker-ce) properly.

## Step 2. Install NVIDIA driver

If you haven't, please install the NVIDIA driver for your device and machine fistly, or you can skip this step.

Please refert to [NVIDIA documentation](https://docs.nvidia.com/datacenter/tesla/tesla-installation-notes/index.html) for detailed instructions.

Before you install the driver, please change the following configurations and restart your machine.

```bash
sudo tee /etc/modprobe.d/blacklist-nouveau.conf <<< \
"blacklist nouveau
options nouveau modeset=0
"

sudo update-initramfs -u && sudo reboot
```

After the proper configuration above, download the proper installation (`.run`) file from [NVIDIA driver download page](https://www.nvidia.com/Download/index.aspx) and install NVIDIA driver (run file) for your hardware. 
Download the `.run` file, and `chmod +x *.run` to make it executbale, and then run the file `./NVIDIA-*.run`.

After that, you should be able to inspect your device status by using `nvidia-smi` command.

## Step 3. Install the `nvidia-ctk` Component

Originally, the component requires Internet connection or a mirror for the package manger, as specified in [nvidia-ctk documentation](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html).

This docker image helps you to get the installation package into a docker image and you can export the files to your local file system.

Please follow the instructions below to export install packages to your local file system and install them using your OS package manager (below is an example for Ubuntu).

```bash
# choose a folder to store tmp files
LOCAL_REPO="/tmp/nvidia-ctk"
LINUX_DIST="ubuntu24.04"

mkdir -pv ${LOCAL_REPO} && cd ${LOCAL_REPO}
docker run --rm -it -v $(pwd):/tmp qpod/nvidia-ctk

sudo tee /etc/apt/sources.list.d/nvidia-docker.list <<< \
"deb file://$LOCAL_REPO/libnvidia-container/${LINUX_DIST}/amd64 /
deb file://$LOCAL_REPO/nvidia-container-runtime/${LINUX_DIST}/amd64 /
deb file://$LOCAL_REPO/nvidia-docker/${LINUX_DIST}/amd64 /"

sudo apt-key add $LOCAL_REPO/nvidia-docker/gpgkey
sudo apt-get update
sudo apt-get install nvidia-ctk
```
