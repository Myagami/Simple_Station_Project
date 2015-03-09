#!/bin/sh
## png / datをモニターする
inotifywait -m -e modify,create,delete --format %w%f "./"|
#inotifywait -m -e modify,create,delete --format %w%f $DAT|
while read files;do
    touch image_up ;
done
