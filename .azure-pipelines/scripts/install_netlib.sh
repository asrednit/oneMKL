VERSION=$1

URL=https://codeload.github.com/Reference-LAPACK/lapack/zip/refs/tags/v${VERSION}
UNPACKED_DIR=lapack-${VERSION}

mkdir sandbox
cd sandbox
mkdir build

echo "curl --output netlib.zip --url ${URL} --retry 5 --retry-delay 5"
curl --output netlib.zip --url ${URL} --retry 5 --retry-delay 5
unzip -q netlib.zip
ls -l ${UNPACKED_DIR}
cd build

source /opt/intel/onapi/setvars.sh

echo "cmake -DBUILD_SHARED_LIBS=ON -DLAPACKE=ON -DCBLAS=ON ../${UNPACKED_DIR}"
cmake -DBUILD_SHARED_LIBS=ON -DLAPACKE=ON -DCBLAS=ON ../${UNPACKED_DIR}
cmake --build . -j 4
mkdir -p /usr/netlib/blas && cp -r lib include /usr/netlib/blas/


echo "cmake -DBUILD_SHARED_LIBS=ON -DLAPACKE=ON -DCBLAS=ON -DBUILD_INDEX64=ON ../${UNPACKED_DIR}"
cmake -DBUILD_SHARED_LIBS=ON -DLAPACKE=ON -DCBLAS=ON -DBUILD_INDEX64=ON -DCMAKE_Fortran_FLAGS=/integer-size:64 ../${UNPACKED_DIR}
cmake --build . -j 4
mkdir -p /usr/netlib/lapack && cp -r lib include /usr/netlib/lapack/