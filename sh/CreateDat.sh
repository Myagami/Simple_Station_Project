#!/bin/sh
# Option
# -m マルチタイルアドオン作成 → プロジェクトデータ発行
# -s シングルタイルアドオン作成 → dat出力
NAME=$1

while getopts mt: opt 
do
    case $opt in
	#"m") sed -e "s/S_Name/$NAME/gi" ../common/Simple_Project.tcp > Simple_Station_$NAME.tcp ;;
	#"m") echo "multi\n" ;;
	#"s") sed -e "s/S_Name/$NAME/gi" ../common/Simple_Station_Base.dat > Simple_Station_$NAME.dat ;;
	#"s") echo "single\n" ;;
    esac
done

echo "-m マルチタイル\n-s シングルタイル\nどちらかのオプションを指定してください\n" ;




