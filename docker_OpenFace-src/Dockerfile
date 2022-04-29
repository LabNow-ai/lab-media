FROM alpine as builder
ENV DIR_DATA="/tmp/data/"
WORKDIR ${DIR_DATA}
RUN mkdir opencv dlib openface \
 && wget https://github.com/opencv/opencv/archive/refs/tags/4.5.5.tar.gz             -O - | tar -zx --strip-components=1 -C ./opencv   \
 && wget https://github.com/davisking/dlib/archive/refs/tags/v19.23.tar.gz           -O - | tar -zx --strip-components=1 -C ./dlib     \
 && wget https://github.com/TadasBaltrusaitis/OpenFace/archive/OpenFace_2.2.0.tar.gz -O - | tar -zx --strip-components=1 -C ./openface \
 && pwd && ls -alh && du -h -d1

FROM busybox
CMD ["sh", "-c", "ls -alh /home && cp -r /home/* /tmp/"]
COPY --from=builder /tmp/data /home/
