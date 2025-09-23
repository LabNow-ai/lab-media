# Distributed under the terms of the Modified BSD License.

ARG BASE_NAMESPACE
ARG BASE_IMG="torch-cuda128"
FROM ${BASE_NAMESPACE:+$BASE_NAMESPACE/}${BASE_IMG}

LABEL maintainer="postmaster@labnow.ai"

# https://docs.vllm.ai/en/latest/getting_started/installation/gpu.html
RUN set -eux && source /opt/utils/script-setup.sh \
 # -----------------------------
 && export CUDA_VER=$(echo ${CUDA_VERSION:-"999"} | cut -c1-4 | sed 's/\.//' ) \
 && export IDX=$( [ -x "$(command -v nvcc)" ] && echo "cu${CUDA_VER:-117}" || echo "cpu" ) \
 && echo "Detected CUDA version=${CUDA_VER} and IDX=${IDX}" \
 # -----------------------------
 && pip install vllm --index-url "https://download.pytorch.org/whl/${IDX}" --extra-index-url https://pypi.org/simple \
 && echo "Try to uninstall nvidia python packages to reduce storage size..." \
 && pip freeze | grep -i '^nvidia-' | cut -d'=' -f1 | xargs -r pip uninstall -y \
 && apt-get -qq update --fix-missing && apt-get -qq install -y --no-install-recommends --allow-change-held-packages libcusparselt0 libnccl2 libnccl-dev \
 # && cd /tmp/ \
 # && git clone https://github.com/vllm-project/vllm.git \
 # && cd /tmp/vllm \
 # && export export MAX_JOBS=8 \
 # && python use_existing_torch.py \
 # && pip install -r requirements/build.txt \
 # && pip install --no-build-isolation -e . \
 && install__clean && list_installed_packages
