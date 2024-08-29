#!/bin/bash
set -e

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

log_info() {
  printf "\n\e[0;35m $1\e[0m\n\n"
}

SLURM_VERSION=${SLURM_VERSION:-21.08.8-2}
WEBSOCKIFY_VERSION=${WEBSOCKIFY_VERSION:-0.11.0}
ARCHTYPE=`uname -m`

log_info "Installing required packages for building slurm.."
dnf -y install dnf-plugins-core
dnf -y config-manager --set-enabled powertools
dnf -y module enable ruby:3.0 nodejs:14
dnf install -y \
    @Development \
    munge \
    munge-devel \
    libcgroup \
    curl \
    bzip2 \
    readline-devel \
    numactl-devel \
    pam-devel \
    glib2-devel \
    hwloc-devel \
    openssl-devel \
    curl-devel \
    mariadb \
    mariadb-devel \
    python39 \
    python39-devel \
    python2-numpy \
    kitty-terminfo \
    python3-pip \
    stress

log_info "Installing compute packages .."

alternatives --set python3 /usr/bin/python3.9

dnf groupinstall -y "Xfce"
