#!/bin/bash

gettext=gettext-0.21

wget https://ftp.gnu.org/pub/gnu/gettext/$gettext.tar.gz
tar -xf $gettext.tar.gz
cd $gettext/

./configure
make
make DESTDIR=$PWD install
 
ln -s $PWD/usr/local/bin/envsubst ~/bin/envsubst

