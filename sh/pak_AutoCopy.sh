#!/bin/sh
#PAK=$1
## png / datをモニターする
#inotifywait -m -e close_nowrite,create,delete --format %w%f "./" |
inotifywait -m -e modify,create,delete --format %w%f "./"
while read files;do
    cp ./*.pak ~/simutrans/addons/pak.nippon.test/
    
    echo "--------------------------------"
    date +"%y/%m/%d %T";
    echo "--------------------------------"
done

