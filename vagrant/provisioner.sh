#!/usr/bin/env bash

install_and_configure_git() {
    apk add git git-doc nano
    git config --system core.editor nano
#    su vagrant -c "git config --global user.name \"<your_fullname_or_github_nickname\""
#    su vagrant -c 'git config --global user.email <your_email@domain.test>'
}

install_and_configure_docker() {
    apk add docker
    adduser vagrant docker
    sed -i 's/DOCKER_OPTS=""/DOCKER_OPTS="-H unix:\/\/\/var\/run\/docker.sock -H tcp:\/\/0.0.0.0:2375"/g' /etc/conf.d/docker
    rc-update add docker boot
    rc-service docker start
}

install_and_configure_docker-compose() {
    apk add py-pip python-dev libffi-dev openssl-dev gcc libc-dev make
    pip install --upgrade pip
    pip install docker-compose
}

install_and_configure_git
install_and_configure_docker
install_and_configure_docker-compose
