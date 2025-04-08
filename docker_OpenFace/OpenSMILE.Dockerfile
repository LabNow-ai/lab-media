# Distributed under the terms of the Modified BSD License.

ARG BASE_NAMESPACE
ARG BASE_IMG="qpod/opencv"
FROM ${BASE_NAMESPACE:+$BASE_NAMESPACE/}${BASE_IMG}

LABEL maintainer="haobibo@gmail.com"

RUN set -eux && source /opt/utils/script-utils.sh \
 ## Download and build OpenSMILE
 && install_zip https://github.com/audeering/opensmile/archive/refs/heads/master.zip \
 && mv /opt/opensmile-* /tmp/openSMILE \
 && cd /tmp/openSMILE \
 # && sed -i '117s/(char)/(unsigned char)/g' src/include/core/vectorTransform.hpp \
 # && ./buildWithPortAudio.sh -p /opt/openSMILE && ./buildStandalone.sh -p /opt/openSMILE \
 && ./build.sh \
 && mv build/* config scripts /opt/openSMILE \
 ## Clean Up
 && cd /opt/openSMILE && install__clean

WORKDIR /opt/openSMILE
