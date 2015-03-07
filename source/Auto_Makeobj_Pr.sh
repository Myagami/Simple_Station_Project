#!/bin/sh
PAK=$1
DAT=$2
PNG=$3
## png / datをモニターする
inotifywait -m -e modify,create,delete --format %w%f $PNG $DAT|
#inotifywait -m -e modify,create,delete --format %w%f $DAT|
while read files;do
    makeobj_54 pak $PAK $DAT ;
    #cp $PAK ~/simutrans/addons/pak.dev
    if [${DAT} = "./"] ;then
	cp `*.pak ~/simutrans/addons/pak.nippon.test`
    else
	cp $PAK ~/simutrans/addons/pak.nippon.test
    fi
    echo "--------------------------------"
    date +"%y/%m/%d %T";
    echo "--------------------------------"
    
    #/home/hayate/simutrans/simutrans.start.112-3-Dev.sh
done

