FROM osrf/ros:melodic-desktop-full

# 設定工作目錄
WORKDIR /root/catkin_ws

# 複製本地 catkin_ws_local 內容到映像檔中的 catkin_ws
COPY catkin_ws_local/src/. /root/catkin_ws/src

# 安裝 VIM 編輯器
RUN apt-get update && apt-get install -y vim

# 使用 catkin_make 編譯 ROS 套件
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash && catkin_make"

# 重新使用 source 設定 ROS 環境變數
RUN echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc

# 清理不必要的檔案
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# 將本地 catkin_ws/src 資料夾作為 volume 掛載到容器中
VOLUME /root/catkin_ws/src

# 指定 entrypoint，以便容器啟動時執行相應指令
CMD ["/bin/bash", "-c", "source /root/catkin_ws/devel/setup.bash && roscore"]
