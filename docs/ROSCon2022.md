# ROSCon2022 commands

## Let's login

```
ssh ubuntu@IPADDRESS
```

## Let's launch

```
roslaunch mini_pupper_bringup bringup.launch
```

```
roslaunch champ_teleop teleop.launch
```

## Update Jupyter Notebook

```
cd ~/dev/mini-pupper-jupyter-notebooks
git pull
```

## Update ROS config

```
cd ~/dev/mini-pupper-jupyter-notebooks
./update_ros_ip.sh
```

## Launch Jupyter Server

```
cd ~/dev/mini-pupper-jupyter-notebooks
./run.sh
```

## Launch camera node

```
cd ~/dev/mini-pupper-jupyter-notebooks && roslaunch ROS/camera.launch
```

## Links

[Object Detection Targes](../notebook/images/README.md)
