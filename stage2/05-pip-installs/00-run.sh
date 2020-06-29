#!/bin/bash -e

#BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export IMG_DATE="${IMG_DATE:-"$(date +%Y-%m-%d)"}"
export IMG_NAME="modi-ai"
export TARGET_DIR="/home/raspbian_build/pi-gen/work/${IMG_DATE}-${IMG_NAME}/stage2/rootfs/usr/lib/python3/dist-packages"
export CONDA_BASE_DIR="/home/raspbian_build/anaconda3/envs/build/lib/python3.8/site-packages"
export DIST_INFO="jupyter-1.0.0.dist-info"
export JUP_CLIENT="jupyter_client"
export JUP_CLIENT_DIST_INFO="jupyter_client-6.1.3.dist-info"
export JUP_CONSOLE="jupyter_console"
export JUP_CONSOLE_DIST_INFO="jupyter_console-6.1.0.dist-info"
export JUP_CORE="jupyter_core"
export JUP_CORE_DIST_INFO="jupyter_core-4.6.3.dist-info"
export JUP_PY="jupyter.py"


echo "${CONDA_BASE_DIR}"
echo "${TARGET_DIR}"
echo "$PWD"
cp -r "${CONDA_BASE_DIR}/${DIST_INFO}" "${TARGET_DIR}/"
cp -r "${CONDA_BASE_DIR}/${JUP_CLIENT}" "${TARGET_DIR}/"
cp -r "${CONDA_BASE_DIR}/${JUP_CLIENT_DIST_INFO}" "${TARGET_DIR}/"
cp -r "${CONDA_BASE_DIR}/${JUP_CONSOLE}" "${TARGET_DIR}/"
cp -r "${CONDA_BASE_DIR}/${JUP_CONSOLE_DIST_INFO}" "${TARGET_DIR}/"
cp -r "${CONDA_BASE_DIR}/${JUP_CORE}" "${TARGET_DIR}/"
cp -r "${CONDA_BASE_DIR}/${JUP_CORE_DIST_INFO}" "${TARGET_DIR}/"
cp -r "${CONDA_BASE_DIR}/${JUP_PY}" "${TARGET_DIR}/"


