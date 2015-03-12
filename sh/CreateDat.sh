#!/bin/sh
# Option
# -m マルチタイルアドオン作成 → プロジェクトデータ発行
# -s シングルタイルアドオン作成 → dat出力
while getopts ms: opt 
do
    case $opt in
	"m")echo "multi\n"; sed -e "s/S_Name/$OPTARG/gi" ../common/Simple_Project.tcp > Simple_Station_$OPTARG.tcp ;;
	#"m") echo "multi\n" ;;
	"s") echo "single\n" ;sed -e "s/S_Name/$OPTARG/gi" ../common/Simple_Station_Base.dat > Simple_Station_$OPTARG.dat ;;
	#"s") echo "single\n" ;;
    esac
done




