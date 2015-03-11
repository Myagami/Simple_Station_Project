#!/bin/sh
#PAK=$1
DAT="./"
PNG="png/image_up"
## png / datをモニターする
inotifywait -m -e modify,create,attrib --format %w%f $PNG $DAT|
#inotifywait -m -e modify,create,delete --format %w%f $DAT|
while read files;do
    makeobj_54 pak ../pak/ ./ ;
    makeobj_54 pak /home/hayate/simutrans/addons/pak.nippon.test/ ./ ;
    
    echo "--------------------------------"
    date +"%y/%m/%d %T";
    echo "--------------------------------"
    
    #/home/hayate/simutrans/simutrans.start.112-3-Dev.sh
done

