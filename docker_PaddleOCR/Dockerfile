# Distributed under the terms of the Modified BSD License.

ARG BASE_NAMESPACE
ARG BASE_IMG="paddle-cuda116"
FROM ${BASE_NAMESPACE:+$BASE_NAMESPACE/}${BASE_IMG}

LABEL maintainer="haobibo@gmail.com"

COPY work /opt/utils/

RUN source /opt/utils/script-setup.sh \
 # Step 1. install/update paddlepaddle
 && PADDLE=$( [ -x "$(command -v nvcc)" ] && echo "paddlepaddle-gpu" || echo "paddlepaddle") \
 && PADDLE_VER=$(pip index versions ${PADDLE} | grep '(' | cut -d "(" -f 2  | tr -d ')[:space:]') \
 && CUDA_VER=$(echo "${CUDA_VERSION:0:4}" | sed 's/\.//' ) \
 && V=$($(grep -q "11" <<< "${CUDA_VER}") && echo ".post${CUDA_VER}" || echo "" ) \
 && V=$(echo ${PADDLE}==${PADDLE_VER}${V}) && echo "to install paddle: ${V}" \
 && pip install ${V} -f "https://www.paddlepaddle.org.cn/whl/linux/mkl/avx/stable.html" \
 # Step 2. install required OS libs for PaddleOCR, mainly for images processing
 && apt-get -qq update -yq --fix-missing && apt-get -qq install -yq --no-install-recommends libgl1 libglib2.0-0 \
 # Step 3. install PaddleOCR
 && pip install -U --no-cache-dir paddleocr \
 # Step 4. install PaddleOCR fixes for Python>=3.10 compatibility
 && pip uninstall -y attrdict && pip install -UI --no-cache-dir attrdict3 \
 # Step 5. cleanup
 && install__clean && list_installed_packages
