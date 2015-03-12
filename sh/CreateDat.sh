#!/bin/sh
# Option
# -m マルチタイルアドオン作成 → プロジェクトデータ発行
# -s シングルタイルアドオン作成 → dat出力
NAME=$2
while getopts ms: opt
do
    case $opt in
	"m")echo "multi\n"; sed -e "s/S_Name/$NAME/gi" ../common/Sample_Project.tcp > Simple_Station_$NAME.tcp ;;
	#"m") echo "$NAME\n" ;;
	"s") echo "single\n" ;sed -e "s/S_Name/$NAME/gi" ../common/Simple_Station_Base.dat > Simple_Station_$NAME.dat ;;
	#"s") echo "single\n" ;;
    esac
done




