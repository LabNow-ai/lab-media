# Distributed under the terms of the Modified BSD License.

ARG BASE_NAMESPACE
ARG BASE_IMG="paddle-cuda116"
FROM ${BASE_NAMESPACE:+$BASE_NAMESPACE/}${BASE_IMG} AS builder
RUN set -eux \
 && python /opt/utils/download_paddleocr_models.py \
 && mv ~/.paddleocr /opt/ && tree /opt/.paddleocr

ARG BASE_NAMESPACE_SRC
FROM ${BASE_NAMESPACE_SRC:+$BASE_NAMESPACE_SRC/}busybox
COPY --from=builder /opt/.paddleocr /home/
LABEL MODEL_NAME="paddleocr"
LABEL maintainer="postmaster@labnow.ai"
LABEL usage="docker run --rm -it -v $(pwd):/tmp `docker-image-name`"
CMD ["sh", "-c", "ls -alh /home && cp -r /home/* /tmp/"]
