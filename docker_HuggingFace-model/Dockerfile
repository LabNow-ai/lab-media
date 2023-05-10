ARG HF_MODEL_NAME="distilbert-base-uncased"

FROM alpine as builder
ARG HF_MODEL_NAME
WORKDIR /tmp/data/
RUN apk add git git-lfs && git lfs install
RUN GIT_REPO_URL="https://huggingface.co/${HF_MODEL_NAME}" \
 && GIT_REPO_HEAD=$(git ls-remote $GIT_REPO_URL | grep HEAD | cut -f1) \
 && echo $GIT_REPO_URL $GIT_REPO_HEAD \
 && git clone --progress --verbose --depth 1 $GIT_REPO_URL $HF_MODEL_NAME \
 && rm -rf ./*/.git && pwd && ls -alh && tree && du -h -d1

FROM busybox
COPY --from=builder /tmp/data /home/
ARG HF_MODEL_NAME
LABEL HF_MODEL_NAME="${HF_MODEL_NAME}"
LABEL maintainer="haobibo@gmail.com"
LABEL usage="docker run --rm -it -v $(pwd):/tmp `docker-image-name`"
CMD ["sh", "-c", "ls -alh /home && cp -rf /home/* /tmp/"]
