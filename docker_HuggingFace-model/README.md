# Store and Download Huggingface Models via docker images

[![Docker Pulls](https://img.shields.io/docker/pulls/qpod/huggingface-model.svg)](https://hub.docker.com/r/qpod/huggingface-model)
[![Docker Starts](https://img.shields.io/docker/stars/qpod/huggingface-model.svg)](https://hub.docker.com/r/qpod/huggingface-model)

These docker images help you to store and download Huggingface Models via docker images.

This is especially useful when you are:

 - Deploy huggingface models in a restricted network where you can only access your local docker images registry (but cannot access the huggingface website/repo via Internet).
 - You want to seperte your code with large model files so that you can use tricks like "init images" to deploy your models on K8S.

## Download HuggingFace Models as docker images

You can download the model files simply using `docker pull qpod/huggingface-model:bert-base-cased`, in which the tag name is the HuggingFace model repo name.

The models files are stored at the `/home` directory in the docker images by default.

Note that the slashes in HF model name should be replaced by dots, and all tag name should be in lowercase.

For example, given a HuggingFace model `HF_MODEL_NAME='microsoft/DialoGPT-small'`, becomes `HF_MODEL_TAG=microsoft.dialoggpt-small`:
1. change the slashes in the name to dots
2. change all the ltters to lowercase in tag name

The shell code to do this conversion is: `HF_MODEL_TAG=$(echo ${HF_MODEL_NAME} | sed 's/\//./g' | tr '[:upper:]' '[:lower:]')`.

We have alrady pre-built several popular models, you can find a list of models here:
https://hub.docker.com/r/qpod/huggingface-model/tags


## Export the model files to local file system 

You can use the following commnad to export the model files stored in the docker images to your local file system.

```bash
# for model names, refer to dockerhub: https://hub.docker.com/r/qpod/huggingface-model/tags
MODEL_NAME="bert-base-chinese"

# choose a folder to store model files
LOCAL_REPO="/tmp/models"

mkdir -pv ${LOCAL_REPO} && cd ${LOCAL_REPO}
docker run --rm -it -v $(pwd):/tmp "qpod/huggingface-model:${MODEL_NAME}"
```


## Build your own docker image which stores a customized HF model

refer to: https://github.com/QPod/media-lab/tree/main/docker_HuggingFace-model

```bash
source tool.sh && source docker_HuggingFace-model/script-setup-huggingface.sh
export -f download_hf_model build_image_hf_model build_image_no_tag push_image
HF_MODEL_NAME='microsoft/biogpt' && download_hf_model ${HF_MODEL_NAME} && build_image_hf_model ${HF_MODEL_NAME}
```

# Dev Notes

To quickly create a docker image for a HF model, you can use GitHub codespace to run the command above.

The following configuration for `/etc/docker/daemon.json` might be useful. Restart the codespace to let the configuration to take effect.

```json
{"experimental": true, "data-root": "/workspaces/docker"}
```

```bash
LIST_MODELS=("LTP/tiny")
cat docker_HuggingFace-model/list_hf_models.txt | read -rd '' -a LIST_MODELS_BAK
echo ${LIST_MODELS[@]}  | xargs -n1 -I {} bash -c 'build_image_hf_model "$@"' _ {} ;
```
