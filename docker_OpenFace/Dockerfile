# Distributed under the terms of the Modified BSD License.

ARG BASE_NAMESPACE
ARG BASE_IMG="opencv"
FROM ${BASE_NAMESPACE:+$BASE_NAMESPACE/}${BASE_IMG}

LABEL maintainer="haobibo@gmail.com"

COPY work /opt/utils/

RUN cd /tmp && source /opt/utils/script-utils.sh \
 && install_apt       /opt/utils/install_list_OpenFace.apt \
 && ln /dev/null /dev/raw1394 \
 ## Download and build dlib
 && install_tar_gz https://github.com/davisking/dlib/archive/refs/tags/v19.24.tar.gz \
 && mv /opt/dlib-* /tmp/dlib \
 && cd /tmp/dlib && mkdir -p build && cd build \
 && cmake \
     -D BUILD_SHARED_LIBS=1 \
     -D CMAKE_INSTALL_PREFIX=/opt/dlib  .. \
 && cmake --build . --config Release -- -j8 \
 && make install && ldconfig \
 ## Download and build OpenFace
 && cd /tmp \
 && install_tar_gz https://github.com/TadasBaltrusaitis/OpenFace/archive/OpenFace_2.2.0.tar.gz \
 && mv /opt/OpenFace-* /tmp/OpenFace \
 && cd /tmp/OpenFace \
 && sed  -i 's/3.3/4.1/g' CMakeLists.txt \
 && mkdir -pv build && cd build \
 && cmake -D CMAKE_BUILD_TYPE=RELEASE .. \
 && make -j8 \
 && mv /tmp/OpenFace/build/bin /opt/OpenFace \
 && cd /opt/OpenFace/model/patch_experts \
 # model download URLs: https://github.com/TadasBaltrusaitis/OpenFace/wiki/Model-download#manual-download
 # && wget -nv 'https://onedrive.live.com/download?cid=2E2ADA578BFF6E6E&resid=2E2ADA578BFF6E6E%2153072&authkey=AKqoZtcN0PSIZH4' -O cen_patches_0.25_of.dat \
 # && wget -nv 'https://onedrive.live.com/download?cid=2E2ADA578BFF6E6E&resid=2E2ADA578BFF6E6E%2153079&authkey=ANpDR1n3ckL_0gs' -O cen_patches_0.35_of.dat \
 # && wget -nv 'https://onedrive.live.com/download?cid=2E2ADA578BFF6E6E&resid=2E2ADA578BFF6E6E%2153074&authkey=AGi-e30AfRc_zvs' -O cen_patches_0.50_of.dat \
 # && wget -nv 'https://onedrive.live.com/download?cid=2E2ADA578BFF6E6E&resid=2E2ADA578BFF6E6E%2153070&authkey=AD6KjtYipphwBPc' -O cen_patches_1.00_of.dat \
 ## Clean Up
 && install__clean

WORKDIR /opt/OpenFace
