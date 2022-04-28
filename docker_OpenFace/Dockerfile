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
 && install_zip http://dlib.net/files/dlib-19.23.zip \
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
 && mkdir -p build && cd build \
 && cmake -D CMAKE_BUILD_TYPE=RELEASE .. \
 && make -j8 \
 && mv /tmp/OpenFace/build/bin /opt/OpenFace \
 && cd /opt/OpenFace/model/patch_experts \
 && wget -nv https://www.dropbox.com/s/7na5qsjzz8yfoer/cen_patches_0.25_of.dat?dl=1 -O cen_patches_0.25_of.dat \
 && wget -nv https://www.dropbox.com/s/k7bj804cyiu474t/cen_patches_0.35_of.dat?dl=1 -O cen_patches_0.35_of.dat \
 && wget -nv https://www.dropbox.com/s/ixt4vkbmxgab1iu/cen_patches_0.50_of.dat?dl=1 -O cen_patches_0.50_of.dat \
 && wget -nv https://www.dropbox.com/s/2t5t1sdpshzfhpj/cen_patches_1.00_of.dat?dl=1 -O cen_patches_1.00_of.dat \
 ## Clean Up
 && cd /opt/OpenFace && install__clean

WORKDIR /opt/OpenFace
