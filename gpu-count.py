#!/usr/bin/env python3
import os

gpus = os.environ.get("NVIDIA_VISIBLE_DEVICES", "")
gpu_count = len(gpus.split(",")) if gpus else 0

print(gpu_count)