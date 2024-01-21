#!/bin/bash

CONTAINER_NAME="ros1"
IMAGE_NAME="agx_ros1_3dlidar:latest"

# 檢查容器是否存在
if docker ps -a -f "name=$CONTAINER_NAME" --format "{{.Names}}" | grep -q $CONTAINER_NAME; then
    # 如果容器正在運行，則連接到容器終端機
    if docker ps -f "name=$CONTAINER_NAME" --format "{{.Names}}" | grep -q $CONTAINER_NAME; then
        echo "Container $CONTAINER_NAME is running."
        docker exec -it $CONTAINER_NAME /bin/bash
    else
        # 如果容器存在但是停止，則重新啟動容器
        echo "Container $CONTAINER_NAME exists but is not running. Restarting..."
        docker start $CONTAINER_NAME
        docker exec -it $CONTAINER_NAME /bin/bash
    fi
else
    # 如果容器不存在，則創建並啟動
    echo "Container $CONTAINER_NAME does not exist. Creating and starting..."
    docker run -it --name $CONTAINER_NAME -v $(pwd)/catkin_ws_local/src:/root/catkin_ws/src $IMAGE_NAME
fi
