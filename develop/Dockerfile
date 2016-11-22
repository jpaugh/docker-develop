FROM ubuntu:xenial
MAINTAINER 'Jonathan Paugh <jpaugh@gmx.com>'
EXPOSE 22

RUN apt-get update

# Cache packages to avoid unnecessary redownloading when the Dockerfile
# changes
#RUN apt-get install --assume-yes curl
#ADD download-packages.sh /tmp
#RUN chmod +x /tmp/download-packages.sh
#RUN apt-get install -qq --print-uris --assume-yes \
        #apt-utils \
        #dialog \
        #exuberant-ctags \
        #git subversion bzr \ 
        #git-bzr git-cvs git-svn \
        #git-doc git-extras \
        #gitk git-gui \
        #mercurial mercurial-git \
        #openssh-blacklist \
        #openssh-blacklist-extra \
        #openssh-client \
        #openssh-server \
        #tmux \
        #tree \
        #vim-nox \
        #wget \
  #> /tmp/apt-package-uris

#RUN /tmp/download-packages.sh /tmp/apt-package-uris

# Preset interactive config options for various packages
ADD debconf-package-selections /tmp
RUN debconf-set-selections /tmp/debconf-package-selections

# System essential
RUN apt-get install --assume-yes \
	sudo \
        apt-utils \
        dialog \
        man

# SSH
RUN apt-get install --assume-yes \
        openssh-client \
        openssh-server \
        openssh-blacklist \
        openssh-blacklist-extra

# Utilities
RUN apt-get install --assume-yes \
        exuberant-ctags \
        patch \
        tmux \
        tree \
        vim-nox

# Source Control
RUN apt-get install --assume-yes \
        git git-doc git-extras \
        git-bzr git-cvs git-svn

RUN apt-get install --assume-yes \
        subversion bzr \ 
        mercurial mercurial-git 

# Minimal C environment
RUN apt-get install --assume-yes \
        gcc make manpages manpages-dev

RUN adduser devel --disabled-password --gecos 'devel user'
USER devel
WORKDIR /home/devel

VOLUME /home/devel/work/ /home/devel/.ssh
