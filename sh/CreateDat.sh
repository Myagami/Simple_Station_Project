#!/bin/sh
# Option
# -m マルチタイルアドオン作成 → プロジェクトデータ発行
#


NAME=$1
sed -e "s/S_Name/$NAME/gi" ../common/Simple_Station_Base.dat > Simple_Station_$NAME.dat

