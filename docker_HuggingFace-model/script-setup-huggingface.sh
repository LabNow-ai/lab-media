download_hf_model() {
       HF_MODEL_NAME=$1 && DIR_CAHCE=$(pwd)/docker_HuggingFace-model \
    && GIT_REPO_URL="https://huggingface.co/${HF_MODEL_NAME}" && GIT_REPO_HEAD=$(git ls-remote $GIT_REPO_URL | grep HEAD | cut -f1) \
    && echo $GIT_REPO_URL $GIT_REPO_HEAD \
    && git clone --progress --verbose --depth 1 $GIT_REPO_URL ${DIR_CAHCE}/${HF_MODEL_NAME} \
    && rm -rf ${DIR_CAHCE}/${HF_MODEL_NAME}/.git && tree ${DIR_CAHCE}/${HF_MODEL_NAME} && du -h -d1 ${DIR_CAHCE}/${HF_MODEL_NAME}
}

build_image_hf_model() {
       HF_MODEL_NAME=$1 && HF_MODEL_TAG=$(echo ${HF_MODEL_NAME} | sed 's/\//./g' | tr '[:upper:]' '[:lower:]') \
    && echo "HF model to pull and build image: ${HF_MODEL_NAME}..." \
    && build_image_no_tag huggingface-model ${HF_MODEL_TAG} docker_HuggingFace-model/Dockerfile --build-arg "HF_MODEL_NAME=${HF_MODEL_NAME}" \
    && push_image
}
