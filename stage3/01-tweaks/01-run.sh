#!/bin/bash

SUB_STAGE_DIR=${PWD}

#
# Download sources
#
DOWNLOAD_DIR=${STAGE_WORK_DIR}/download
mkdir -p ${DOWNLOAD_DIR}
pushd ${DOWNLOAD_DIR}

# pyserial
wget -nc -nv -O pyserial.tar.gz \
    https://github.com/pyserial/pyserial/releases/download/v3.2.1/pyserial-3.2.1.tar.gz

# python can
wget -nc -nv -O python-can.tar.gz \
    https://github.com/hardbyte/python-can/archive/3.3.3.tar.gz

# pymodi git clone
wget -nc -nv -O pymodi.tar.gz \
    https://github.com/LUXROBO/pymodi/archive/v0.9.0.tar.gz

# Jupyter notebook
wget -nc -nv -O notebook.tar.gz \
    https://github.com/jupyter/notebook/archive/6.1.0rc1.tar.gz

popd

#
# Extract and patch sources
#
EXTRACT_DIR=${ROOTFS_DIR}/usr/src
# Making extract directory
install -v -d ${EXTRACT_DIR}
pushd ${EXTRACT_DIR}

tar xzf "${DOWNLOAD_DIR}/pyserial.tar.gz"  
mv pyserial-* pyserial
echo "Pyserial src downloaded"

tar xzf "${DOWNLOAD_DIR}/python-can.tar.gz"
mv python-can-* python-can
echo "python can src downloaded"

tar xzf "${DOWNLOAD_DIR}/pymodi.tar.gz"
mv pymodi-* pymodi
echo "pymodi src downloaded"

tar xzf "${DOWNLOAD_DIR}/notebook.tar.gz"
mv notebook-* notebook
echo "jupyter notebook src downloaded"

# pyserial
on_chroot << EOF
pushd /usr/src/pyserial
python3 setup.py install
popd
EOF

echo "pyserial installation done!"

# python-can
on_chroot << EOF
pushd /usr/src/python-can
python3 -m pip install aenum-2.2.3-py3-none-any.whl -f ./ --no-index
popd
pushd /usr/src/python-can/python-can-3.3.3
python3 setup.py install
popd
pushd /usr/src/python-can/wrapt-1.12.1
python3 setup.py install
popd
EOF

# pymodi
on_chroot << EOF
pushd /usr/src/pymodi
python3 setup.py install
popd 
EOF
echo "pymodi installed"

# jupyter notebook
on_chroot << EOF
pushd /usr/src/notebook
python3 setup.py install
popd
EOF
echo "jupyter notebook installed"
