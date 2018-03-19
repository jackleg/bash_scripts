#!/usr/bin/env bash
# template from: https://dev.to/thiht/shell-scripts-matter

set -euo pipefail
IFS=$'\n\t'

# 현재 스크립트의 absolute path 구하기
WORK_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# getopts with silent mode
while getopts ":a:" opt; do
  case $opt in
    a)
      echo "-a was triggered, Parameter: $OPTARG" >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done


#/ Usage:
#/ Description:
#/ Examples:
#/ Options:
#/   --help: Display this help message
usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage

readonly LOG_FILE="/tmp/$(basename "$0").log"
info()    { echo "[INFO]    $@" | tee -a "$LOG_FILE" >&2 ; }
warning() { echo "[WARNING] $@" | tee -a "$LOG_FILE" >&2 ; }
error()   { echo "[ERROR]   $@" | tee -a "$LOG_FILE" >&2 ; }
fatal()   { echo "[FATAL]   $@" | tee -a "$LOG_FILE" >&2 ; exit 1 ; }

# 문자열을 지정한 문자로 join.
# usage: join_by , A B C (output: A,B,C)
join_by() { local IFS=$1; shift; echo "$*"; }

cleanup() {
    # Remove temporary files
    # Restart services
    # ...
}

if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then
    trap cleanup EXIT
    # Script goes here
    # ...
fi
