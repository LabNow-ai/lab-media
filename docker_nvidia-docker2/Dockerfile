FROM alpine as builder
ENV DIR_DATA="/tmp/data/"
WORKDIR ${DIR_DATA}
RUN mkdir -pv libnvidia-container nvidia-container-runtime nvidia-docker \
 && wget https://api.github.com/repos/nvidia/libnvidia-container/tarball/gh-pages -O - | tar -zx --strip-components=1 -C ./libnvidia-container \
 && wget https://api.github.com/repos/nvidia/nvidia-container-runtime/tarball/gh-pages -O - | tar -zx --strip-components=1 -C ./nvidia-container-runtime \
 && wget https://api.github.com/repos/nvidia/libnvidia-container/tarball/gh-pages -O - | tar -zx --strip-components=1 -C ./nvidia-docker \
 && pwd && ls -alh && du -h -d1

FROM busybox
LABEL maintainer="haobibo@gmail.com"
LABEL usage="docker run --rm -it -v $(pwd):/tmp `docker-image-name`"
CMD ["sh", "-c", "ls -alh /home && cp -r /home/* /tmp/"]
COPY --from=builder /tmp/data /home/
