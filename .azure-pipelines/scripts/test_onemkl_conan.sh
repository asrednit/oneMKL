#/bin/bash

DOMAIN=$1

export COMPILER_PREFIX="/opt/intel/oneapi/compiler/latest/linux"

sudo -E conan config install conan/

mkdir build-${DOMAIN}
cd build-${DOMAIN}

DOMAIN_SPECIFIC_OPTIONS=

if [ "${DOMAIN}" == "blas" ]; then 
    DOMAIN_SPECIFIC_OPTIONS="-o ref_blas_root=/opt/netlib/blas"
fi

if [ "${DOMAIN}" == "lapack" ]; then 
    DOMAIN_SPECIFIC_OPTIONS="-o ref_lapack_root=/opt/netlib/lapack"
fi

sudo -E conan install .. --profile inteldpcpp_lnx.jinja --build missing -o enable_mklgpu_backend=False -o target_domains=${DOMAIN} ${DOMAIN_SPECIFIC_OPTIONS}
sudo -E conan build ..