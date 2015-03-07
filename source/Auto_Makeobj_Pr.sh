#!/bin/sh
DAT=$1
## png / datをモニターする
inotifywait -m -e modify,create,delete --format %w%f "?.png" $DAT|
#inotifywait -m -e modify,create,delete --format %w%f $DAT|
while read files;do
    makeobj_54 pak "../pak/" $DAT ;
done

