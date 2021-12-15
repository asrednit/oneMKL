#/bin/bash

DOMAIN=$1

export COMPILER_PREFIX="/opt/intel/oneapi/compiler/latest/linux"

sudo -E conan config install conan/

mkdir build-${DOMAIN}
cd build-${DOMAIN}

whoami

sudo -E conan install .. --profile inteldpcpp_lnx.jinja --build missing -o enable_mklgpu_backend=False -o target_domains=${DOMAIN}
sudo -E conan build ..