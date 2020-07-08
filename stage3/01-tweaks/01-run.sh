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
#mkdir pyserial
#python3 -m pip download pyserial -d "${DOWNLOAD_DIR}/pyserial"
#tar cvfz pyserial.tgz pyserial

# python can
mkdir python-can
python3 -m pip download python-can -d "${DOWNLOAD_DIR}/python-can"
tar cvfz python-can.tgz python-can

# pymodi git clone
mkdir pymodi
python3 -m pip download pymodi -d "${DOWNLOAD_DIR}/pymodi"
tar cvfz pymodi.tgz pymodi
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
echo "Pyserial source clone"
tar xzf "${DOWNLOAD_DIR}/python-can.tgz"
tar xzf "${DOWNLOAD_DIR}/python-can/python-can-3.3.3.tar.gz"
tar xzf "${DOWNLOAD_DIR}/python-can/wrapt-1.12.1.tar.gz"  
tar xzf "${DOWNLOAD_DIR}/pymodi.tgz"

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

