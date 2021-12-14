#/bin/bash

INSTALLER_URL=$1
REQUIRED_COMPONENTS=$2

curl --output installer.sh --url "${INSTALLER_URL}" --retry 5 --retry-delay 5

chmod +x installer.sh
./installer.sh -x -f webimage_extracted --log extract.log
rm -rf installer.sh

WEBIMAGE_NAME=$(ls -1 webimage_extracted/)

webimage_extracted/${WEBIMAGE_NAME}/bootstrapper -s --action install --components="${REQUIRED_COMPONENTS}" --eula=accept --log-dir=. --install-dir=/opt/intel/oneapi
ls -l /opt/intel/oneapi
exit_code=$?

rm -rf webimage_extracted

exit ${exit_code}