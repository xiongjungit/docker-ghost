# 1 ubuntu
# Ubuntu Dockerfile
#
# https://github.com/xiongjungit/ubuntu
#

# Pull base image.
FROM       daocloud.io/library/ubuntu:14.04
MAINTAINER xiongjun,dockerxman <fenyunxx@163.com>

ADD sources.list /etc/apt/sources.list

# Install.
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts

# Set environment variables.
ENV HOME /root
ENV TZ "Asia/Shanghai"
ENV TERM xterm

# 2 python
# Python Dockerfile
#
# https://github.com/xiongjungit/python
#

# Install Python.
RUN \
  apt-get update && \
  apt-get install -y python python-dev python-pip python-virtualenv && \
  rm -rf /var/lib/apt/lists/*

# 3 nodejs
# Node.js Dockerfile
#
# https://github.com/xiongjungit/nodejs
#

# Install Node.js
# Need Node.js v4.2.0
RUN \
  cd /tmp && \
  wget https://nodejs.org/dist/v4.2.0/node-v4.2.0-linux-x64.tar.gz && \
  tar zxvf node-v4.2.0-linux-x64.tar.gz && \
  rm -f node-v4.2.0-linux-x64.tar.gz && \
  mv node-v4.2.0-linux-x64 /opt/node && \
  ln -s /opt/node/bin/node /usr/local/bin/node && \
  ln -s /opt/node/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm && \ 
  npm config set registry https://registry.npm.taobao.org && \
  npm install -g npm && \
  printf '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc

# 4 ghost
# Ghost Dockerfile
#
# https://github.com/xiongjungit/ghost
#

# Install Ghost
RUN \
  cd /tmp && \
  wget http://dl.ghostchina.com/Ghost-0.7.4-zh-full.zip && \
  unzip Ghost-0.7.4-zh-full.zip -d /ghost && \
  rm -f Ghost-0.7.4-zh-full.zip && \
  cd /ghost && \
  npm install --production && \
  useradd ghost --home /ghost

# Add files.
ADD start.bash /ghost-start

ADD js/config.js /ghost/config.js
ADD js/post.js /ghost/core/server/models/post.js
ADD js/ghost.min.js /ghost/core/built/assets/ghost.min.js
ADD js/vendor.min.js /ghost/core/built/assets/vendor.min.js

# Set environment variables.
ENV NODE_ENV production
ENV TERM xterm

# Define mountable directories.
VOLUME /ghost

# Define working directory.
WORKDIR /ghost

# Define default command.
CMD ["bash", "/ghost-start"]

# Expose ports.
EXPOSE 2368
