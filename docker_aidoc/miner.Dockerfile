# Distributed under the terms of the Modified BSD License.

# reference: https://github.com/opendatalab/MinerU/blob/master/docker/china/Dockerfile

ARG BASE_NAMESPACE
ARG BASE_IMG="py-nlp-cuda128"
FROM ${BASE_NAMESPACE:+$BASE_NAMESPACE/}${BASE_IMG}

LABEL maintainer="postmaster@labnow.ai"

RUN set -eux \
 # ----------
 && apt-get update \
 && mkdir -pv /usr/share/man/man1 \
 && apt-get -qq install -yq --no-install-recommends openjdk-21-jre-headless \
 && apt-get -qq install -yq --no-install-recommends \
     libgl1 libglib2.0-0 libxrender1 libsm6 libxext6 \
     fontconfig ttf-mscorefonts-installer \
     fonts-noto-cjk fonts-wqy-zenhei fonts-wqy-microhei \
     libreoffice poppler-utils \
 && pip install -U magic-pdf[full] modelscope \
 # ----------
 && echo "Try to uninstall nvidia python packages to reduce storage size..." \
 && pip freeze | grep -i '^nvidia-' | cut -d'=' -f1 | xargs -r pip uninstall -y \
 && apt-get -qq update --fix-missing && apt-get -qq install -y --no-install-recommends --allow-change-held-packages libcusparselt0 libnccl2 libnccl-dev \
 # ----------
 && rm -rf /var/lib/apt/lists/* \
 && source /opt/utils/script-setup.sh \
 && install__clean && list_installed_packages
