FROM ubuntu:20.04
SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y python3 python3-pip wget sudo curl git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash --user-group --groups adm,sudo,audio,video,dialout user && \
    echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "user:user" | chpasswd

RUN mkdir /.jupyter && chmod 777 /.jupyter && \
    mkdir /.cache && chmod 777 /.cache && \
    mkdir /.config && chmod 777 /.config

ENV PATH=/opt/miniconda3/bin:${PATH}

# Install Conda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-aarch64.sh -O /tmp/miniconda-install.sh && \
    bash /tmp/miniconda-install.sh -b -p /opt/miniconda3 && \
    rm /tmp/miniconda-install.sh && \
    conda install mamba -c conda-forge && \
    rm -rf /var/lib/apt/lists/*

# Create Conda env
RUN mamba create -n robostackenv python=3.8 -y && \
    conda init

RUN . /opt/miniconda3/bin/activate && \
    conda activate robostackenv && \
    conda config --env --add channels conda-forge && \
    conda config --env --add channels robostack-experimental && \
    conda config --env --add channels robostack && \
    mamba install -y ros-noetic-ros-base && \
    mamba install -y ros-noetic-rosbridge-server ros-noetic-tf2-web-republisher && \
    mamba install -y compilers cmake pkg-config make ninja catkin_tools && \
    mamba install -y rosdep && rosdep init && rosdep update

RUN sudo apt-get update && \
    sudo apt-get install --no-install-recommends -y libgl1-mesa-dev && \
    rm -rf /var/lib/apt/lists/* && \
    . /opt/miniconda3/bin/activate && \
    conda activate robostackenv && \
    mamba install -y ros-noetic-cv-bridge

# jupyros==0.5.0
RUN . /opt/miniconda3/bin/activate && \
    conda activate robostackenv && \
    mamba install -y nodejs=14 jupyter-ros \
          jupyter-amphion ipyvuetify ipympl bqplot ipywidgets "voila>=0.3.5" sidecar pillow opencv
# requires voila>=0.3.5
# https://github.com/voila-dashboards/voila/issues/1138

## jupyros==0.6.0
#RUN . /opt/miniconda3/bin/activate && \
#    conda activate robostackenv && \
#    mamba install -y nodejs=14 jupyros \
#          jupyter-amphion ipyvuetify ipympl bqplot ipywidgets "voila>=0.3.5" sidecar pillow

RUN sed -i -e 's%"python",%"python",\n "env": {"LD_PRELOAD":"/opt/miniconda3/envs/robostackenv/lib/libgomp.so.1"},%g' /opt/miniconda3/envs/robostackenv/share/jupyter/kernels/python3/kernel.json

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y python3 python3-pip wget sudo curl git \
    swig libjpeg-dev zlib1g-dev python3-dev unzip python3-pip cmake make && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo ". /opt/miniconda3/bin/activate" >> /etc/bash.bashrc && \
    echo "conda activate robostackenv" >> /etc/bash.bashrc

## TensorFlow Lite
#ENV TFVER=2.8.0
#ENV PYVER=38
#ENV ARCH=aarch64
#
#RUN python3 -m pip install --no-cache-dir \
#    https://github.com/PINTO0309/TensorflowLite-bin/releases/download/v${TFVER}/tflite_runtime-${TFVER/-/}-cp${PYVER}-none-linux_${ARCH}.whl

RUN . /opt/miniconda3/bin/activate && \
    conda activate robostackenv && \
    python3 -m pip install --no-cache-dir \
    https://github.com/google-coral/pycoral/releases/download/v1.0.1/tflite_runtime-2.5.0-cp38-cp38-linux_aarch64.whl

## Additional packages
#RUN cd /tmp && git clone https://github.com/luxonis/depthai.git && \
#    cd depthai && python3 -m pip install -r requirements.txt && \
#    python3 -m pip install -r requirements-optional.txt && \
#    python3 -m pip install blobconverter && \
#    rm -rf /tmp/depthai
#
COPY ./rootfs/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

COPY ./rootfs/jupyter_entrypoint.sh /
CMD [ "bash", "-c", "/jupyter_entrypoint.sh" ]

