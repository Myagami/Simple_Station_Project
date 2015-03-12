#!/bin/sh
# Option
# -m マルチタイルアドオン作成 → プロジェクトデータ発行
# -s シングルタイルアドオン作成 → dat出力

while getopts mt: opt 
do
    case $opt in
	

    esac
done


NAME=$1
sed -e "s/S_Name/$NAME/gi" ../common/Simple_Station_Base.dat > Simple_Station_$NAME.dat

