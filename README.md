## Docker for Mac 用RoboCup 2D Simulator 运行

REFERENCE: https://hub.docker.com/r/ymiyoshi/rcsoccersim

REFERENCE: 实现Mac主机上的Docker容器中的图形界面显示 https://www.cnblogs.com/noluye/p/11405358.html

Homebrew (https://brew.sh/)

Docker 安装
~~~console
(host)$ brew cask install docker kitematic
~~~

安装xquartz和socat。
~~~console
(host)$ brew cask install xquartz
(host)$ brew install socat
~~~

先启动socat，再启动xquartz。socat流量转发至xquartz
~~~console
(host)$ socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &
(host)$ open -a XQuartz
~~~


~~~console
ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
docker run --rm -d --name rcsoccersim -v /Users/zhenwang/code/git/game/rcsoccersim/teams:/home/rcsoccersim/teams -e DISPLAY=$ip:0 moliqingwa/rcsoccersim
~~~

后台运行soccerwindow2， 启动rcssmonitor。
~~~console
(container)$ soccerwindow2 --field-grass-type=lines --hide-team-grahip --show-player-number --hide-player-type --hide-view-area --hide-pointto --hide-attentionto --hide-stamina --hide-stamina-capacity --show-card --ball-size=1.0 &
~~~

https://archive.robocup.info/Soccer/Simulation/2D/binaries/RoboCup/ 下载team文件夹下的文件，并放在本项目teams文件夹下（首次需要创建该文件夹）。

如下启动两个队伍的demo
~~~console
(container)$ pwd
/home/rcsoccersim/teams
(container)$ cd 2017/alice/
(container)$ ./s &
(container)$ cd ../cyrus/
(container)$ ./startAll &
~~~

生成好的docker image: https://cloud.docker.com/repository/docker/moliqingwa/rcsoccersim
