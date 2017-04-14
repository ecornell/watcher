#!/bin/bash
export DEBUG=false
export PIPE_TMP_DIR='/data/.pipe'
export WATCHER_OPTIONS='-r -e close_write -e moved_to --exclude \.~'
~/scripts/watcher.sh '/data/.local' '[[ -f ${FILE} ]] && echo ${FILE} | ~/scripts/pipe.sh -t 20 "~/scripts/transfer_copy.sh /data/.local edrive: {}" && ~/scripts/update_plex_local.sh && ~/scripts/transfer_tier.sh /data/.local edrive:'

