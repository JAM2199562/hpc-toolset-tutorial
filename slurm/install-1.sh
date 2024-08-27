#!/bin/bash
set -e

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

log_info() {
  printf "\n\e[0;35m $1\e[0m\n\n"
}

SLURM_VERSION=${SLURM_VERSION:-21.08.8-2}
WEBSOCKIFY_VERSION=${WEBSOCKIFY_VERSION:-0.11.0}
ARCHTYPE=`uname -m`
curl -o /etc/yum.repos.d/turbovnc.repo https://raw.githubusercontent.com/TurboVNC/repo/main/TurboVNC.repo
dnf install -y turbovnc 

