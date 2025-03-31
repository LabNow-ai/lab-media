ARG BASE_NAMESPACE
ARG BASE_IMG="busybox"
FROM ${BASE_NAMESPACE:+$BASE_NAMESPACE/}${BASE_IMG}

LABEL maintainer="haobibo@gmail.com"
LABEL usage="docker run --rm -it -v $(pwd):/tmp `docker-image-name`"
ENV DIR_DATA="/home/"
WORKDIR ${DIR_DATA}
CMD ["sh", "-c", "ls -alh /home && cp -r /home/* /tmp/"]

RUN mkdir -pv libnvidia-container nvidia-container-runtime nvidia-docker \
 && wget https://api.github.com/repos/nvidia/libnvidia-container/tarball/gh-pages      -O - | tar -zx --strip-components=1 -C ./libnvidia-container \
 && wget https://api.github.com/repos/nvidia/nvidia-container-runtime/tarball/gh-pages -O - | tar -zx --strip-components=1 -C ./nvidia-container-runtime \
 && wget https://api.github.com/repos/nvidia/libnvidia-container/tarball/gh-pages      -O - | tar -zx --strip-components=1 -C ./nvidia-docker \
 && pwd && ls -alh && du -h -d1
