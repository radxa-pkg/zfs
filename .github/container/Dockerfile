# Some dependencies conflict with the compilation tools of amd64 architecture. Use arm64 directly. container image
FROM --platform=linux/arm64 debian:bullseye

RUN apt-get update && \
    apt-get full-upgrade --no-install-recommends -y \
        build-essential crossbuild-essential-arm64 git \
        debhelper devscripts lintian abigail-tools debhelper-compat \
        dh-python dh-sequence-dkms libaio-dev libblkid-dev \
        libcurl4-openssl-dev libelf-dev libpam0g-dev \
        libssl-dev libtirpc-dev libtool libudev-dev \
        lsb-release po-debconf python3-all-dev python3-cffi \
        python3-setuptools python3-sphinx uuid-dev zlib1g-dev \
        dkms linux-headers-arm64 && \
    adduser --gecos runner --disabled-password runner && \
    rm -rf /var/lib/apt/lists/*
