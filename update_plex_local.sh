#!/bin/bash

[[ "${DEBUG}" == "true" ]] && set -x

set -u -o pipefail

echo "Updating Plex - /data/.local/*"
for i in $(ls /data/.local/movies); do
    ~/scripts/plex-scanner -s -r -c 1 -d /data/movies/$i
done

for i in $(ls /data/.local/tv); do
    ~/scripts/plex-scanner -s -r -c 2 -d /data/tv/$i
done

for i in $(ls /data/.local/other); do
    ~/scripts/plex-scanner -s -r -c 5 -d /data/other/$i
done
