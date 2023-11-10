FROM nvidia/cuda:11.8.0-runtime-ubuntu22.04
ARG VERSION=0.2.1.post1
ENV PORT 8080

RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    apt-get update && \
    apt-get -y --no-install-recommends install \
      python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir --upgrade pip wheel
RUN python3 -m pip install --no-cache-dir vllm==${VERSION}

COPY entrypoint.sh /usr/local/bin/
COPY gpu-count.py /usr/local/bin/
CMD [ "entrypoint.sh" ]
