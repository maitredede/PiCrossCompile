#!/usr/bin/env bash

if [ -z ${QEMU_VERSION:-} ]
then
    QEMU_VERSION=
fi

if [ "${QEMU_VERSION}" = "COMPILED" ]
then
    echo "Compiling latest qemu"
    source build-qemu-compile.sh
else
    if [ "${QEMU_VERSION}" = "SYSTEM" ]
    then
        echo "Using system qemu"
        source build-qemu-system.sh
    else
        echo "WARNING : unspecified or invalid value for QEMU_VERSION. Valid values are COMPILED,SYSTEM. Found '${QEMU_VERSION}'"
        echo "Assuming default: SYSTEM"
        source build-qemu-system.sh
    fi
fi
echo -en 'travis_fold:start:script.qemu-version\\r\\n'
echo qemu informations
${QEMU} --version
${QEMU} -M help
echo Supported cpu for ${QEMU_MACHINE} :
${QEMU} -M ${QEMU_MACHINE} -cpu help
echo -en 'travis_fold:end:script.qemu-version\\r\\n'