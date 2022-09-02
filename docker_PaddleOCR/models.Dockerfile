# Distributed under the terms of the Modified BSD License.

ARG BASE_NAMESPACE
ARG BASE_IMG="paddle-cuda116"
FROM ${BASE_NAMESPACE:+$BASE_NAMESPACE/}${BASE_IMG}

LABEL maintainer="haobibo@gmail.com"

COPY work /opt/utils/

FROM busybox
COPY --from=builder /opt/.paddle /home/
LABEL MODEL_NAME="paddleocr"
LABEL maintainer="haobibo@gmail.com"
LABEL usage="docker run --rm -it -v $(pwd):/tmp `docker-image-name`"
CMD ["sh", "-c", "ls -alh /home && cp -r /home/* /tmp/"]
