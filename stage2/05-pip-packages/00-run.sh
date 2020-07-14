#!/bin/bash

SUB_STAGE_DIR=${PWD}

echo "${SUB_STAGE_DIR}"

#
# Download sources
#
DOWNLOAD_DIR=${STAGE_WORK_DIR}/download
mkdir -p ${DOWNLOAD_DIR}
pushd ${DOWNLOAD_DIR}

# pyserial
wget -nc -nv -O pyserial.tar.gz \
    https://github.com/pyserial/pyserial/releases/download/v3.2.1/pyserial-3.2.1.tar.gz

# wrapt
wget -nc -nv -O wrapt.tar.gz \
    https://github.com/GrahamDumpleton/wrapt/archive/1.12.1.tar.gz

# aenum
wget -nc -nv -O aenum.tar.gz \
    https://bitbucket.org/stoneleaf/aenum/get/2.1.3.tar.gz

# python can
wget -nc -nv -O python-can.tar.gz \
    https://github.com/hardbyte/python-can/archive/3.3.3.tar.gz

# pymodi git clone
wget -nc -nv -O pymodi.tar.gz \
    https://github.com/LUXROBO/pymodi/archive/v0.9.0.tar.gz

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

tar xzf "${DOWNLOAD_DIR}/wrapt.tar.gz"
mv wrapt-* wrapt
echo "Wrapt src downloaded"

tar xzf "{DOWNLOAD_DIR}/aenum.tar.gz"
mv stoneleaf-* aenum
echo "aenum src downloaded"

tar xzf "${DOWNLOAD_DIR}/python-can.tar.gz"
mv python-can-* python-can
echo "python can src downloaded"

tar xzf "${DOWNLOAD_DIR}/pymodi.tar.gz"
mv pymodi-* pymodi
echo "pymodi src downloaded"


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
python3 setup.py install
popd 
EOF
echo "pymodi installed"
