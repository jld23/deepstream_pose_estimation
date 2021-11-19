FROM nvcr.io/nvidia/deepstream:6.0-triton

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y &&\
    apt-get install -y \
    gstreamer-1.0 \
    gstreamer1.0-dev \
    git \
    autoconf \ 
    automake \ 
    libtool \
    python3-gi \
    python3.8-dev \
    # python-gst-1.0 \
    libgirepository1.0-dev \
    libcairo2-dev \
    gir1.2-gstreamer-1.0\
    cmake \
    g++ \
    build-essential \
    libglib2.0-dev \ 
    libglib2.0-dev-bin \
    python-gi-dev \
    libtool \
    m4 \
    vim

RUN python -m pip install --upgrade wheel pip setuptools
# RUN python -m pycairo PyGObject

WORKDIR /opt/nvidia/deepstream/deepstream-6.0/sources/apps/sample_apps/deepstream-pose_estimation
COPY . .
RUN make -j$(nproc)

# # Python bindings
# WORKDIR /opt/nvidia/deepstream/deepstream-6.0
# RUN git clone https://github.com/NVIDIA-AI-IOT/deepstream_python_apps.git

# WORKDIR /opt/nvidia/deepstream/deepstream-6.0/deepstream_python_apps
# RUN git submodule update --init
# RUN cd 3rdparty/gst-python/ &&\
#     ./autogen.sh && \
#     make -j$(nproc) && \
#     make install

# WORKDIR /opt/nvidia/deepstream/deepstream-6.0/deepstream_python_apps/bindings/
# RUN mkdir build &&\
#     cd build/ &&\
#     cmake ..  -DPYTHON_MAJOR_VERSION=3 -DPYTHON_MINOR_VERSION=8 &&\
#     make -j$(nproc)

# WORKDIR /opt/nvidia/deepstream/deepstream-6.0/deepstream_python_apps/bindings/build
# RUN python -m pip install pyds-1.1.0-py3-none-linux_x86_64.whl

# docker run -it -P --gpus all deeps:latest

# dpkg -l | grep TensorRT

# xhost +

# docker run --gpus all -it --rm -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -w /opt/nvidia/deepstream/deepstream-6.0 nvcr.io/nvidia/deepstream:6.0-devel
# docker run --gpus all -it --rm -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -w /opt/nvidia/deepstream/deepstream-6.0 nvcr.io/nvidia/deepstream:6.0-triton
# docker run --gpus all --rm -it  -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -w /opt/nvidia/deepstream/deepstream-6.0 deeps:latest

# https://github.com/deep28vish/DeepStream
