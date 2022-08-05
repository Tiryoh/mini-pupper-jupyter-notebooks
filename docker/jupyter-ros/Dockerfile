FROM ubuntu:20.04 AS ros-noetic
SHELL ["/bin/bash", "-c"]

RUN apt-get update -q && \
    apt-get upgrade -yq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends keyboard-configuration language-pack-en && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends wget curl git build-essential ca-certificates tzdata tmux gnupg2 \
        vim sudo lsb-release locales bash-completion zsh iproute2 iputils-ping net-tools dnsutils terminator && \
    rm -rf /var/lib/apt/lists/*
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8
RUN locale-gen en_US.UTF-8
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu focal main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -k https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | sudo apt-key add -
RUN apt-get update -q && \
    apt-get install -y --no-install-recommends ros-noetic-ros-core python3-rosdep ros-noetic-rospy ros-noetic-rosbridge-suite ros-noetic-rosbag ros-noetic-rosauth ros-noetic-tf2-web-republisher &&\
    apt-get install -y --no-install-recommends python3-rosinstall python3-rosinstall-generator python3-wstool python3-catkin-tools python3-osrf-pycommon python3-vcstool &&\
    apt-get install -y --no-install-recommends ros-noetic-teleop-twist-keyboard &&\
    rm -rf /var/lib/apt/lists/*

RUN rosdep init && rosdep update


FROM ros-noetic
SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y python3 python3-pip libopencv-dev wget sudo curl && \
    curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash --user-group --groups adm,sudo,audio,video,dialout user && \
    echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "user:user" | chpasswd

RUN mkdir /.jupyter && chmod 777 /.jupyter && \
    mkdir /.cache && chmod 777 /.cache && \
    mkdir /.config && chmod 777 /.config

ENV PYTHONPATH=/opt/ros/noetic/lib/python3/dist-packages:${PYTHONPATH}

RUN python3 -m pip install -U pip

ENV JUPYROS_VERSION=0.6.0

RUN python3 -m pip install ipython jupyterlab ipywidgets scikit-image matplotlib opencv-python pandas seaborn pyyaml tqdm protobuf bqplot ipycanvas ipympl sidecar jupyros==${JUPYROS_VERSION} ipyvuetify voila

RUN python3 -m pip install jupyter-packaging cookiecutter

RUN mkdir -p /usr/share/jupyter/nbextensions/@robostack && \
    mkdir -p /usr/local/src/ && \
    cd /usr/local/src/ && \
    git clone https://github.com/robostack/jupyter-amphion.git && \
    cd jupyter-amphion && \
    pip install -e . && \
    jupyter nbextension install --py --symlink --sys-prefix jupyter_amphion

RUN jupyter nbextension enable --py --sys-prefix jupyter_amphion

#RUN mkdir -p /usr/share/jupyter/nbextensions/ && \
#    mkdir -p /usr/local/src/ && \
#    cd /usr/local/src/ && \
#    git clone https://github.com/RoboStack/jupyter-ros.git -b $JUPYROS_VERSION && \
#    cd jupyter-ros && \
#    pip install -e . && \
#    mkdir -p /usr/share/jupyter/nbextensions/@robostack && \
#    jupyter nbextension install --py --symlink --sys-prefix jupyros && \
#    jupyter nbextension enable --py --sys-prefix jupyros

# required if jupyterlab<3
#RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
#    jupyter labextension install @jupyter-widgets/jupyterlab-sidecar


## Additional packages
#RUN apt-get update && \
#    DEBIAN_FRONTEND=noninteractive apt-get install -y git && \
#    apt-get clean && rm -rf /var/lib/apt/lists/*
#RUN cd /tmp && git clone https://github.com/luxonis/depthai.git && \
#    cd depthai && python3 -m pip install -r requirements.txt && \
#    python3 -m pip install -r requirements-optional.txt && \
#    python3 -m pip install blobconverter && \
#    rm -rf /tmp/depthai

COPY ./rootfs/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

CMD [ "bash", "-c", "source /etc/bash.bashrc && /usr/local/bin/jupyter lab --notebook-dir=/workspace --ip 0.0.0.0 --no-browser --allow-root" ]

