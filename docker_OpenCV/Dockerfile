# Distributed under the terms of the Modified BSD License.

ARG BASE_NAMESPACE
ARG BASE_IMG="base"
FROM ${BASE_NAMESPACE:+$BASE_NAMESPACE/}${BASE_IMG}

LABEL maintainer="haobibo@gmail.com"

COPY work /opt/utils/

RUN set -eux && source /opt/utils/script-utils.sh \
 && install_apt        /opt/utils/install_list_OpenCV.apt \
 && ln -sf /dev/null /dev/raw1394 \
 ## Download and build OpenCV
 && install_tar_gz https://github.com/opencv/opencv/archive/refs/tags/4.11.0.tar.gz \
 && mv /opt/opencv-* /tmp/opencv \
 && cd /tmp/opencv && mkdir -p build && cd build \
 && cmake \
     -D CMAKE_BUILD_TYPE=RELEASE \
     -D CMAKE_INSTALL_PREFIX=/opt/opencv \
     -D WITH_TBB=ON \
     -D WITH_EIGEN=ON \
     -D WITH_CUDA=OFF \
     -D PYTHON_DEFAULT_EXECUTABLE=`which python` \
     -D BUILD_SHARED_LIBS=ON  .. \
 && make -j8 && make install \
 ## Clean Up
 && install__clean

WORKDIR /opt/opencv
