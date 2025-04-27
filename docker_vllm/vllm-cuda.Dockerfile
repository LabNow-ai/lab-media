# Distributed under the terms of the Modified BSD License.

ARG BASE_NAMESPACE
ARG BASE_IMG="torch"
FROM ${BASE_NAMESPACE:+$BASE_NAMESPACE/}${BASE_IMG}

LABEL maintainer="haobibo@gmail.com"

RUN set -eux && source /opt/utils/script-setup.sh \
 && cd /tmp/ \
 # https://docs.vllm.ai/en/latest/getting_started/installation/gpu.html
 && git clone https://github.com/vllm-project/vllm.git \
 && cd /tmp/vllm \
 && export export MAX_JOBS=8 && pip install -e . \
 && install__clean && list_installed_packages
