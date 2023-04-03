# Download HuggingFace Models as docker images

```bash
# for model names, refer to dockerhub: https://hub.docker.com/r/qpod/huggingface-model/tags
MODEL_NAME="bert-base-chinese"

# choose a folder to store model files
LOCAL_REPO="/tmp/models"

mkdir -pv ${LOCAL_REPO} && cd ${LOCAL_REPO}
docker run --rm -it -v $(pwd):/tmp "qpod/huggingface-model:${MODEL_NAME}"
```
