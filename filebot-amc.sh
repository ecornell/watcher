#!/usr/bin/env bash
[[ "${DEBUG}" == "true" ]] && set -x

set -u -o pipefail

export HOME="/data"

DEST="${1-}"
SOURCE="${2-}"

[[ -z "${DEST-}" ]] && logger "Must provide destination (\$1). Exiting." && exit 1
[[ -z "${SOURCE-}" ]] && logger "Must provide source (\$2). Exiting." && exit 1
[[ ! -e ${DEST-} ]] && logger "Destination does not exist (${DEST}). Exiting." && exit 1

FILES="$(find "${SOURCE}" -type f -regex '.*\.\(mkv\|mp4\|avi\|wmv\|flv\|webm\|mov\)')"

[[ -z "${FILES-}" ]] && exit 0

# Configuration
FILEBOT_ACTION="move"
FIlEBOT_UNSORTED="y"
FILEBOT_CONFLICT="override"
FILEBOT_CLEAN="y"
FILEBOT_MOVIEFORMAT=$"Movies/{n} ({y})/{n} ({y}){' -  pt'+pi} - [{vf}, {vc}, {ac}{', '+source}]{'.'+lang}"
FILEBOT_SERIESFORMAT=$"Shows/{n}/{episode.special ? 'Specials' : 'Season '+s.pad(2)}/{n} - {episode.special ? 'S00E'+special.pad(2) : s00e00} - {t.replaceAll(/[\`\´\‘\’\ʻ]/, /'/).replaceAll(/[!?.]+$/).replacePart(', Part \$1')} [{vf}, {vc}, {ac}{', '+source}]{'.'+lang}"

filebot -no-xattr -script fn:amc "${SOURCE}" \
    --output "${DEST}" \
    --action "${FILEBOT_ACTION}" \
    --log-lock no \
    --conflict "${FILEBOT_CONFLICT}" \
    --def   unsorted="${FIlEBOT_UNSORTED}" \
            clean="${FILEBOT_CLEAN}" \
            movieFormat="${FILEBOT_MOVIEFORMAT}" \
            seriesFormat="${FILEBOT_SERIESFORMAT}" || exit 1

find "${SOURCE}" -type d -empty -delete &> /dev/null

exit 0
