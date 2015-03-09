#!/bin/sh
## pngが更新されたらimage_upを更新する
inotifywait -m -e modify,create,delete --format %w%f "./"|
#inotifywait -m -e modify,create,delete --format %w%f $DAT|
while read files;do
    touch image_up ;
done
