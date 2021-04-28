#!/bin/bash

wget https://ftp.gnu.org/pub/gnu/gettext/gettext-0.21.tar.gz
tar -xf gettext-0.21.tar.gz
cd gettext-0.21/

./configure
make
make DESTDIR=$PWD install
 
ln -s $PWD/usr/local/bin/envsubst ~/bin/envsubst

