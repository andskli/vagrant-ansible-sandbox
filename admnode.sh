#!/usr/bin/env bash

set -e

echo "Installing ansible" && \
    yum -y install gcc python-devel vim-enhanced && \
    easy_install pip && \
    pip install ansible
