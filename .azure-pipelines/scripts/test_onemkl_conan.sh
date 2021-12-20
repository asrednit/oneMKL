#/bin/bash

DOMAIN=$1

export COMPILER_PREFIX="/opt/intel/oneapi/compiler/latest/linux"
ls -l /opt/intel/oneapi
ls -l /opt/intel/oneapi/compiler/latest/linux/bin/

wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB
rm GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB

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