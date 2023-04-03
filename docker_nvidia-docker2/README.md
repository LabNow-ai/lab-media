# Install `nvidia-docker2` offline

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


## Install NVIDIA driver
```bash
sudo tee /etc/modprobe.d/blacklist-nouveau.conf <<< \
"blacklist nouveau
options nouveau modeset=0
"
```

sudo update-initramfs -u && sudo reboot
