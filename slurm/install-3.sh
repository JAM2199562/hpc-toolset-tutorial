#!/bin/bash
set -e

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

log_info() {
  printf "\n\e[0;35m $1\e[0m\n\n"
}

SLURM_VERSION=${SLURM_VERSION:-21.08.8-2}
WEBSOCKIFY_VERSION=${WEBSOCKIFY_VERSION:-0.11.0}
ARCHTYPE=`uname -m`

rm -rf /etc/yum.repos.d/turbovnc.repo 


log_info "Compiling python-websockify version ${WEBSOCKIFY_VERSION}.."
wget -O /tmp/websockify-${WEBSOCKIFY_VERSION}.tar.gz https://github.com/novnc/websockify/archive/refs/tags/v${WEBSOCKIFY_VERSION}.tar.gz
pushd /tmp
tar xzf websockify-${WEBSOCKIFY_VERSION}.tar.gz
pushd websockify-${WEBSOCKIFY_VERSION}
export PIP_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple
sed -i 's/numpy/numpy==1.26/' setup.py
python3 -m pip install .
#python3 setup.py install
popd
rm -rf /tmp/websockify*

