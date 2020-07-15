#!/bin/bash

SUB_STAGE_DIR=${PWD}

echo "${SUB_STAGE_DIR}"

#
# Download sources
#
export DOWNLOAD_DIR="${BASE_DIR}/src"
echo "${DOWNLOAD_DIR}"
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

tar xzf "${DOWNLOAD_DIR}/wrapt.tar.gz"
mv wrapt-* wrapt
echo "Wrapt src downloaded"

tar xzf "${DOWNLOAD_DIR}/aenum.tar.gz"
mv stoneleaf-aenum-* aenum
echo "aenum src downloaded"

tar xzf "${DOWNLOAD_DIR}/enum34.tar.gz"
mv stoneleaf-enum34-* enum34 
echo "aenum src downloaded"

tar xzf "${DOWNLOAD_DIR}/python-can.tar.gz"
mv python-can-* python-can
echo "python can src downloaded"

tar xf "${DOWNLOAD_DIR}/pymodi.tar.gz"
echo "pymodi src downloaded"

tar xf "${DOWNLOAD_DIR}/tensorflow.tar.gz"
echo "tensorflow src downloaded"

# pyserial
on_chroot << EOF
pip3 install setuptools
pushd /usr/src/pyserial
python3 setup.py install
popd
EOF

echo "pyserial installation done!"

# wrapt 
on_chroot << EOF
pushd /usr/src/wrapt
python3 setup.py install
popd
EOF

echo "wrapt installation done!"

# aenum
on_chroot << EOF
pushd /usr/src/aenum
python3 setup.py install
popd
EOF

echo "aenum installation done!"

# enum34

on_chroot << EOF
pushd /usr/src/enum34
python3 setup.py install
popd
EOF

echo "enum installation done!"

# python-can
on_chroot << EOF
pushd /usr/src/python-can
python3 setup.py install
popd
EOF

echo "python-can installation done!"

# pymodi
on_chroot << EOF
pushd /usr/src/pymodi
python3 -m pip install *.whl 
popd 
EOF
echo "pymodi installed"


# tensorflow

on_chroot << EOF
pushd /usr/src/tensorflow
python3 -m pip install *.whl
popd 
EOF
echo "tensorflow installed"
