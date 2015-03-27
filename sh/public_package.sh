#!/bin/zsh

#package_name
PACK_N=$1

#Action
mkdir $1 ;#create dir
cd $1 ;
mkdir source
`cp ../../pak/*.pak ./`
`cp ../../source/*.dat source/`
`cp ../../source/png/* source
`



