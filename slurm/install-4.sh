#!/bin/bash
set -e

trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

log_info() {
  printf "\n\e[0;35m $1\e[0m\n\n"
}

SLURM_VERSION=${SLURM_VERSION:-21.08.8-2}
WEBSOCKIFY_VERSION=${WEBSOCKIFY_VERSION:-0.11.0}
ARCHTYPE=`uname -m`


log_info "Installing Jupyter.."
python3 -m venv --without-pip --prompt jupyter/2.1.4 /usr/local/jupyter/2.1.4
source /usr/local/jupyter/2.1.4/bin/activate
curl https://bootstrap.pypa.io/get-pip.py | python

pip install jupyterlab==2.1.4 jupyter-console qtconsole ipywidgets plotly==4.8.2 pandas scikit-learn numpy
deactivate

dnf clean all
rm -rf /var/cache/dnf
