#!/bin/sh
NAME=$1
sed -e "s/S_Name/$NAME/gi" Simple_Station_Sample.dat > Simple_Station_$NAME.dat

