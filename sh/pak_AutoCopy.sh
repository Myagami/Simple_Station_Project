#!/bin/sh
BRANCH=$1

## 全体のモニター
while inotifywait -e modify,create,delete -r ./ ; do
    cp * ~/simutrans/addons/pak.nippon.test/
done
