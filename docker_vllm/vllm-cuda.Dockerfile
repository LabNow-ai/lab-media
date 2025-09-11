# Distributed under the terms of the Modified BSD License.

ARG BASE_NAMESPACE
ARG BASE_IMG="torch-cuda128"
FROM ${BASE_NAMESPACE:+$BASE_NAMESPACE/}${BASE_IMG}

LABEL maintainer="postmaster@labnow.ai"

# https://docs.vllm.ai/en/latest/getting_started/installation/gpu.html
RUN set -eux && source /opt/utils/script-setup.sh \
 && pip install vllm \
 # && cd /tmp/ \
 # && git clone https://github.com/vllm-project/vllm.git \
 # && cd /tmp/vllm \
 # && export export MAX_JOBS=8 \
 # && python use_existing_torch.py \
 # && pip install -r requirements/build.txt \
 # && pip install --no-build-isolation -e . \
 && install__clean && list_installed_packages
