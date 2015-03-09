#!/bin/sh
#PAK=$1
## png / datをモニターする
inotifywait -m -e modify,create,delete,attrib --format %w%f "./" |
#inotifywait -m -e modify,create,delete --format %w%f $DAT|
while read files;do

    cp * ~/simutrans/addons/pak.nippon.test/
    #/home/hayate/simutrans/simutrans.start.112-3-Dev.sh

    echo "--------------------------------"
    date +"%y/%m/%d %T";
    echo "--------------------------------"
done

