FROM ubuntu:20.04
SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y python3 python3-pip libopencv-dev wget sudo curl && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash --user-group --groups adm,sudo,audio,video,dialout user && \
    echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "user:user" | chpasswd

RUN mkdir /.jupyter && chmod 777 /.jupyter && \
    mkdir /.cache && chmod 777 /.cache && \
    mkdir /.config && chmod 777 /.config

RUN python3 -m pip install -U pip
ARG PYTORCH_VERSION=1.12.1
ARG TORCHVISION_VERSION=0.13.1
RUN python3 -m pip install torch==${PYTORCH_VERSION} torchvision==${TORCHVISION_VERSION} torchaudio --extra-index-url https://download.pytorch.org/whl/cpu

# workaround: https://github.com/jupyter-widgets/ipywidgets/issues/1721#issuecomment-330759036
RUN python3 -m pip install ipython jupyterlab ipywidgets scikit-image matplotlib opencv-python pandas seaborn pyyaml tqdm protobuf && \
    jupyter nbextension enable --py --sys-prefix widgetsnbextension

#    jupyter nbextension enable --py --sys-prefix ipywidgets && \

# Additional packages

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
RUN cd /tmp && git clone https://github.com/luxonis/depthai.git && \
    cd depthai && python3 -m pip install -r requirements.txt && \
    python3 -m pip install -r requirements-optional.txt && \
    python3 -m pip install blobconverter && \
    rm -rf /tmp/depthai

CMD [ "bash", "-c", "source /etc/bash.bashrc && /usr/local/bin/jupyter lab --notebook-dir=/workspace --ip 0.0.0.0 --no-browser --allow-root" ]

