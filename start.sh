#!/usr/bin/env bash

# REFERENCE: https://hub.docker.com/r/ymiyoshi/rcsoccersim
# REFERENCE: 实现Mac主机上的Docker容器中的图形界面显示 https://www.cnblogs.com/noluye/p/11405358.html

############## INSTALLION STEPS ##############
# (host)$ brew cask install xquartz
# (host)$ brew install socat

############## OPERATION STEPS ##############
# STEP 1: start docker
ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
#xhost + $ip
docker run --rm -d --name rcsoccersim -v /Users/zhenwang/code/git/game/rcsoccersim/teams:/home/rcsoccersim/teams -e DISPLAY=$ip:0   moliqingwa/rcsoccersim

# STEP 2: open socat
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"

# STEP3: open xquartz
open -a XQuartz

# STEP4: open soccerwindow2 && run players. players can be download from: https://archive.robocup.info/Soccer/Simulation/2D/binaries/RoboCup/2019/MainRound/
docker exec -it rcsoccersim bash
# (container)$ soccerwindow2 &
# (container)$ pwd
# /home/rcsoccersim/teams
# (container)$ cd 2017/alice/
# (container)$ ./s &
# (container)$ cd ../cyrus/
# (container)$ ./startAll &

# STOP
docker stop rcsoccersim
