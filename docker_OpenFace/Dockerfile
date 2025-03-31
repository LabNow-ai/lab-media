ARG BASE_NAMESPACE
ARG BASE_IMG="opencv"

FROM ${BASE_NAMESPACE:+$BASE_NAMESPACE/}openface-src AS source
FROM ${BASE_NAMESPACE:+$BASE_NAMESPACE/}${BASE_IMG}  AS runtime

FROM runtime

LABEL maintainer="haobibo@gmail.com"

COPY --from=source /home /tmp
COPY work /opt/utils/

RUN set -eux && ls -alh /tmp \
 && source /opt/utils/script-utils.sh \
 && install_apt /opt/utils/install_list_OpenFace.apt \
 && ln -sf /dev/null /dev/raw1394 \
 ## Build dlib
 && cd /tmp/dlib && mkdir -p build && cd build \
 && cmake \
     -D BUILD_SHARED_LIBS=1 \
     -D CMAKE_INSTALL_PREFIX=/opt/dlib  .. \
 && cmake --build . --config Release -- -j8 \
 && make install && ldconfig \
 ## Build OpenFace
 && cd /tmp/openface \
 && sed  -i 's/3.3/4.1/g' CMakeLists.txt \
 && mkdir -pv build && cd build \
 && cmake -D CMAKE_BUILD_TYPE=RELEASE .. \
 && make -j8 \
 && mv /tmp/openface/build/bin /opt/OpenFace \
 && mkdir -pv /opt/OpenFace/model/ \
 && mv /tmp/openface_model_patch_experts /opt/OpenFace/model/patch_experts \
 ## Clean Up
 && install__clean

WORKDIR /opt/OpenFace
