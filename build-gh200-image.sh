#!/usr/bin/env bash

VERSION=0.6.6.post1

git clone https://github.com/vllm-project/vllm.git
cd vllm
git checkout v${VERSION}

# Construct --tag arguments from line of strings which is passed as
# environment variable TAGS.
TAGS_ARG=""
for tag in ${TAGS}; do
  TAGS_ARG="${TAGS_ARG} --tag ${tag}"
done

# Construct --label arguments from line of strings which is passed as
# environment variable LABELS.
LABELS_ARG=""
for label in ${LABELS}; do
  LABELS_ARG="${LABELS_ARG} --label ${label}"
done

python3 use_existing_torch.py
DOCKER_BUILDKIT=1 docker build . \
  --target vllm-openai \
  --platform "linux/arm64" \
  ${TAGS_ARG} \
  ${LABELS_ARG} \
  --build-arg max_jobs=66 \
  --build-arg nvcc_threads=2 \
  --build-arg torch_cuda_arch_list="9.0+PTX" \
  --build-arg vllm_fa_cmake_gpu_arches="90-real"