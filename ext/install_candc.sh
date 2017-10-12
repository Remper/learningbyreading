#!/bin/sh

cd candc
cat Makefile.unix | sed "s/^PROLOG = swipl/PROLOG = bin\/swipl/" > Makefile
BASEDIR=`pwd`

# install SOAP
cd ext
unzip gsoap_2.8.16.zip
cd gsoap-2.8
./configure --prefix=$BASEDIR/ext
make
make install

# install SWI-Prolog 6.6.6
cd ../../
wget http://www.swi-prolog.org/download/stable/src/pl-6.6.6.tar.gz
tar -xzvf pl-6.6.6.tar.gz
cd pl-6.6.6/
./configure --prefix=$BASEDIR
make
make install
cd ../

# compile the C&C tools with SOAP support
make
make soap

# compile tokenizer and Boxer
make bin/t
make bin/boxer

# unzip the models for the parser
tar -xjvf models-1.02.tbz2
