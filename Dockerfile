FROM ubuntu:latest

# Suppress time zone questions during build
ENV TZ=America/New_York

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
  && echo $TZ > /etc/timezone \
  && apt update \
  && apt upgrade -y \
  && apt install -y \
# Packages sorted alphabetically
    asciidoc \
    astyle \
    autoconf \
    bc \
    bison \
    build-essential \
    ccache \
    cmake \
    cmake-curses-gui \
    cpio \
    cryptsetup-bin \
    curl \
    dblatex \
    default-jre \
    doxygen \
    file \
    flex \
    gdisk \
    genext2fs \
    gettext-base \
    git \
    graphviz \
    gzip \
    help2man \
    iproute2 \
    iputils-ping \
    libacl1-dev \
    libelf-dev \
    libglade2-0 \
    libgtk2.0-0 \
    libjson-c-dev \
    libmpc-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libpcap-dev \
    libssl-dev \
    libtool \
    locales \
    m4 \
    mtd-utils \
    parted \
    patchelf \
    python3 \
    python3-pip \
    rsync \
    ruby-full \
    ruby-jira \
    ruby-parslet \
    squashfs-tools \
    sudo \
    texinfo \
    tree \
    u-boot-tools \
    udev \
    util-linux \
    vim \
    w3m \
    wget \
    xz-utils \
    zlib1g-dev \
# Cleanup
  && rm -rf /var/lib/apt/lists/*
# Generate en_US.UTF-8 locale
RUN locale-gen en_US.UTF-8 \
# Update locate to en_US.UTF-8
  && update-locale LANG=en_US.UTF-8 LANGUAGE=en
# git needs a user
RUN git config --system user.email "br@statropy.com" && git config --system user.name "Build Root"

RUN gem install nokogiri asciidoctor

# Set locale
ENV LANG='en_US.UTF-8' LC_ALL='en_US.UTF-8'

RUN mkdir -p /opt/mscc
RUN wget -O- http://mscc-ent-open-source.s3-eu-west-1.amazonaws.com/public_root/bsp/mscc-brsdk-arm64-2024.06.tar.gz | tar -xz -C /opt/mscc/
RUN wget -O- http://mscc-ent-open-source.s3-eu-west-1.amazonaws.com/public_root/toolchain/mscc-toolchain-bin-2024.02-105.tar.gz | tar -xz -C /opt/mscc/
RUN wget -O- http://mscc-ent-open-source.s3-eu-west-1.amazonaws.com/public_root/toolchain/mscc-toolchain-bin-2024.02.6-108.tar.gz | tar -xz -C /opt/mscc/ 

WORKDIR /home/ubuntu
USER ubuntu
