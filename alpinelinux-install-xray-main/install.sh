#!/usr/bin/env bash

set -euxo pipefail

chmod u+x start.sh

# Identify architecture
case "$(arch -s)" in
    'i386' | 'i686')
        MACHINE='32'
        ;;
    'amd64' | 'x86_64')
        MACHINE='64'
        ;;
    'armv5tel')
        MACHINE='arm32-v5'
        ;;
    'armv6l')
        MACHINE='arm32-v6'
        grep Features /proc/cpuinfo | grep -qw 'vfp' || MACHINE='arm32-v5'
        ;;
    'armv7' | 'armv7l')
        MACHINE='arm32-v7a'
        grep Features /proc/cpuinfo | grep -qw 'vfp' || MACHINE='arm32-v5'
        ;;
    'armv8' | 'aarch64')
        MACHINE='arm64-v8a'
        ;;
    'mips')
        MACHINE='mips32'
        ;;
    'mipsle')
        MACHINE='mips32le'
        ;;
    'mips64')
        MACHINE='mips64'
        ;;
    'mips64le')
        MACHINE='mips64le'
        ;;
    'ppc64')
        MACHINE='ppc64'
        ;;
    'ppc64le')
        MACHINE='ppc64le'
        ;;
    'riscv64')
        MACHINE='riscv64'
        ;;
    's390x')
        MACHINE='s390x'
        ;;
    *)
        echo "error: The architecture is not supported."
        exit 1
        ;;
esac

echo $MACHINE

DOWNLOAD_LINK="https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-$MACHINE.zip"

install_software() {
    if [[ -n "$(command -v curl)" ]]; then
        return
    fi
    if [[ -n "$(command -v unzip)" ]]; then
        return
    fi
    if [ "$(command -v apk)" ]; then
        apk add curl unzip
    else
        echo "error: The script does not support the package manager in this operating system."
        exit 1
    fi
}

download_xray() {
    curl -L -H 'Cache-Control: no-cache' -o "xray.zip" "$DOWNLOAD_LINK" -#
    if [ "$?" -ne '0' ]; then
        echo 'error: Download failed! Please check your network or try again.'
        exit 1
    fi
}

decompression() {
    unzip -q "xray.zip" -d "xray"
}


main() {
    install_software
    download_xray
    decompression
}

main
