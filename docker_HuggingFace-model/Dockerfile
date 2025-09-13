ARG BASE_NAMESPACE
ARG BASE_IMG="busybox"
FROM ${BASE_NAMESPACE:+$BASE_NAMESPACE/}${BASE_IMG}

ARG HF_MODEL_NAME="answerdotai/ModernBERT-base"

LABEL HF_MODEL_NAME="${HF_MODEL_NAME}"
LABEL maintainer="postmaster@labnow.ai"
LABEL usage="docker run --rm -it -v $(pwd):/tmp `docker-image-name`"
CMD ["sh", "-c", "ls -alh /home && cp -rf /home/* /tmp/"]

COPY ${HF_MODEL_NAME} /home/${HF_MODEL_NAME}

# WORKDIR /tmp/data/
# RUN apk add git git-lfs && git lfs install
# RUN GIT_REPO_URL="https://huggingface.co/${HF_MODEL_NAME}" \
#  && GIT_REPO_HEAD=$(git ls-remote $GIT_REPO_URL | grep HEAD | cut -f1) \
#  && echo $GIT_REPO_URL $GIT_REPO_HEAD \
#  && git clone --progress --verbose --depth 1 $GIT_REPO_URL $HF_MODEL_NAME \
#  && rm -rf ./*/.git && pwd && ls -alh && tree && du -h -d1
# COPY --from=builder /tmp/data /home/
