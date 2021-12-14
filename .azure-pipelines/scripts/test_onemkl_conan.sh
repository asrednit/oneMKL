#/bin/bash

DOMAIN=$1

export COMPILER_PREFIX="/opt/intel/oneapi/compiler/latest/linux"

conan config install conan/

mkdir build-${DOMAIN}
cd build-${DOMAIN}

conan install .. --profile inteldpcpp_lnx --build missing -o enable_mklgpu_backend=False -o target_domains=${DOMAIN}
conan build ..