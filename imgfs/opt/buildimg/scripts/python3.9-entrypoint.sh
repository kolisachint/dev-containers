#!/usr/bin/env bash

# User-provided configuration must always be respected.

if [ ! -e "/root/.ssh" ]; then
    mkdir /root/.ssh
fi

ssh-keyscan `echo ${GIT_SRC} | cut -d ':' -f1|cut -d '@' -f2 ` >> ~/.ssh/known_hosts

mkdir /appl
cd /appl
git clone ${GIT_SRC} --config core.sshCommand="ssh -i /my-secrets/my-private-ssh-key"

cd `echo ${GIT_SRC} | cut   -d ':' -f2 |cut -d '/' -f2 |cut -d '.' -f1`

if [ -e "requirements.txt" ]; then
    pip3 --disable-pip-version-check --no-cache-dir \
      install -r requirements.txt
fi

if [ -e "main.py" ]; then
    python3 main.py
fi

tail -f /dev/null

