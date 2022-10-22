FROM nvidia/cudagl:11.3.0-devel-ubuntu20.04
ENV PATH="/opt/conda/bin:${PATH}"
ARG PATH="/opt/conda/bin:${PATH}"

RUN apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    git \
    libglew-dev \
    libosmesa6-dev \
    software-properties-common \
    net-tools \
    build-essential \
    wget \
    python3.8 \
    python3-pip \
    patchelf \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-py38_4.12.0-Linux-x86_64.sh \
    && bash Miniconda3-py38_4.12.0-Linux-x86_64.sh -b -p /opt/conda \
    && rm -f Miniconda3-py38_4.12.0-Linux-x86_64.sh

RUN mkdir -p /workspace/.mujoco \
    && wget https://mujoco.org/download/mujoco210-linux-x86_64.tar.gz -O mujoco.tar.gz \
    && tar -xf mujoco.tar.gz -C /workspace/.mujoco \
    && rm mujoco.tar.gz

ENV LD_LIBRARY_PATH /workspace/.mujoco/mujoco210/bin:/opt/conda/nvidia/lib64:/usr/lib/x86_64-linux-gnu:/opt/conda/nvidia/lib:${LD_LIBRARY_PATH}
ENV MUJOCO_PY_MUJOCO_PATH /workspace/.mujoco/mujoco210
RUN pip install -U --no-cache-dir "git+https://github.com/drMJ/mujoco-py.git"
RUN chmod -R 777 /opt/conda/lib/python3.8/site-packages/mujoco_py
RUN pip install torch torchvision --extra-index-url https://download.pytorch.org/whl/cu113

