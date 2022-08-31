# Distributed under the terms of the Modified BSD License.

ARG BASE_NAMESPACE
ARG BASE_IMG="paddle-cuda116"
FROM ${BASE_NAMESPACE:+$BASE_NAMESPACE/}${BASE_IMG}

LABEL maintainer="haobibo@gmail.com"

RUN apt-get -qq update -yq --fix-missing && apt-get -qq install -yq --no-install-recommends libgl1 libglib2.0-0 \
 && pip install -U opencv-python opencv-contrib-python scikit-image imgaug \
    shapely pyclipper attrdict3 lxml lmdb \
 && pip install -U --no-deps paddleocr \
 && install__clean
