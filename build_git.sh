#!/bin/bash
version=${1:-"2.20.1"}
apt-get -qq update
apt-get -qq install software-properties-common
apt-get -qq install dh-autoreconf libcurl4-openssl-dev libexpat1-dev gettext \
  libz-dev libssl-dev python python-pip wget gcc make
apt-get -y -q install autoconf
pip install -q awscli
mkdir -p /u/downloads
version=${1:-"2.20.1"}
cd /u/downloads
filename="/u/downloads/git-${version}.tgz"
printf "downloading source bundle\n"
wget -q "https://www.kernel.org/pub/software/scm/git/git-${version}.tar.gz" -O "${filename}" ;
build_dir=/u/git-${version}
mkdir -p ${build_dir} && cd ${build_dir}
tar xzf $filename --strip-components=1
printf "\e[32mbuilding!\e[0m\n"
make configure
./configure --prefix=/usr
make all
