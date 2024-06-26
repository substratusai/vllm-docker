FROM nvidia/cuda:12.1.1-devel-ubuntu22.04 AS flash-attn-builder
ARG FLASH_ATTN_VERSION=v2.5.8
ENV FLASH_ATTN_VERSION=${FLASH_ATTN_VERSION}

RUN apt-get update -y && apt-get install -y python3-pip git

WORKDIR /usr/src/flash-attention-v2

# Download the wheel or build it if a pre-compiled release doesn't exist
RUN python3 -m pip install --no-cache-dir --upgrade pip wheel packaging ninja torch==2.3.0
RUN pip --verbose wheel flash-attn==${FLASH_ATTN_VERSION} \
    --no-build-isolation --no-deps --no-cache-dir

# TODO switch back to using runtime once vllm no longer need NVCC
# https://github.com/vllm-project/vllm/issues/4666
FROM nvidia/cuda:12.1.1-devel-ubuntu22.04
ARG VERSION=0.5.0.post1
ENV PORT 8080

RUN apt-get update && \
    apt-get -y --no-install-recommends install \
      build-essential python3-dev python3-pip curl && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir --upgrade pip wheel

RUN python3 -m pip install --no-cache-dir vllm==${VERSION}
RUN --mount=type=bind,from=flash-attn-builder,src=/usr/src/flash-attention-v2,target=/usr/src/flash-attention-v2 \
    --mount=type=cache,target=/root/.cache/pip \
    pip install /usr/src/flash-attention-v2/*.whl --no-cache-dir

# TODO Remove once upstream removes this
# Workaround for https://github.com/openai/triton/issues/2507 and
# https://github.com/pytorch/pytorch/issues/107960 -- hopefully
# this won't be needed for future versions of this docker image
# or future versions of triton.
RUN ldconfig /usr/local/cuda-12.1/compat/

COPY chat-templates /chat-templates

COPY entrypoint.sh /usr/local/bin/
CMD [ "entrypoint.sh" ]
