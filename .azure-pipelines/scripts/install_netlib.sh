#/bin/bash

VERSION=$1

URL=https://codeload.github.com/Reference-LAPACK/lapack/zip/refs/tags/v${VERSION}
UNPACKED_DIR=lapack-${VERSION}

mkdir sandbox
cd sandbox

echo "curl --output netlib.zip --url ${URL} --retry 5 --retry-delay 5"
curl --output netlib.zip --url ${URL} --retry 5 --retry-delay 5
unzip -q netlib.zip
ls -l ${UNPACKED_DIR}

source /opt/intel/onapi/setvars.sh

mkdir build-blas
cd build-blas
echo "cmake -DBUILD_SHARED_LIBS=ON -DLAPACKE=ON -DCBLAS=ON ../${UNPACKED_DIR}"
cmake -DBUILD_SHARED_LIBS=ON -DLAPACKE=ON -DCBLAS=ON ../${UNPACKED_DIR}
cmake --build . -j 4
mkdir -p /opt/netlib/blas && cp -r lib include /opt/netlib/blas/

cd ..
mkdir build-lapack
cd build-lapack
echo "cmake -DBUILD_SHARED_LIBS=ON -DLAPACKE=ON -DCBLAS=ON -DBUILD_INDEX64=ON ../${UNPACKED_DIR}"
cmake -DBUILD_SHARED_LIBS=ON -DLAPACKE=ON -DCBLAS=ON -DBUILD_INDEX64=ON ../${UNPACKED_DIR}
cmake --build . -j 4
mkdir -p /opt/netlib/lapack && cp -r lib include /opt/netlib/lapack/