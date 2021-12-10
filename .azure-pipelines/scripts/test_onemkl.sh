DOMAIN=$1

mkdir build-${DOMAIN}

ls -l
cd build-${DOMAIN}

source /opt/intel/oneapi/setvars.sh

DOMAIN_SPECIFIC_OPTIONS=

if [ "${DOMAIN}" == "blas" ]; then 
    DOMAIN_SPECIFIC_OPTIONS=-DREF_BLAS_ROOT=/opt/netlib/blas
fi

if [ "${DOMAIN}" == "lapack" ]; then 
    DOMAIN_SPECIFIC_OPTIONS=-DREF_LAPACK_ROOT=/opt/netlib/lapack
fi

export CXX=dpcpp
export CC=clang

echo "Configuring..."
echo "cmake -DBUILD_SHARED_LIBS=True -DENABLE_MKLCPU_BACKEND=True -DENABLE_MKLGPU_BACKEND=False -DENABLE_NETLIB_BACKEND=False -DENABLE_CUBLAS_BACKEND=False -DENABLE_CURAND_BACKEND=False -DCMAKE_VERBOSE_MAKEFILE=True -DBUILD_FUNCTIONAL_TESTS=True -DTARGET_DOMAINS=${DOMAIN} ${DOMAIN_SPECIFIC_OPTIONS} .."
cmake -DBUILD_SHARED_LIBS=True -DENABLE_MKLCPU_BACKEND=True -DENABLE_MKLGPU_BACKEND=False -DENABLE_NETLIB_BACKEND=False -DENABLE_CUBLAS_BACKEND=False -DENABLE_CURAND_BACKEND=False -DCMAKE_VERBOSE_MAKEFILE=True -DBUILD_FUNCTIONAL_TESTS=True -DTARGET_DOMAINS=${DOMAIN} ${DOMAIN_SPECIFIC_OPTIONS} ..
echo "Building..."
cmake --build . --parallel 4 --target all
echo "Testing..."
ctest -j1 --output-on-failure