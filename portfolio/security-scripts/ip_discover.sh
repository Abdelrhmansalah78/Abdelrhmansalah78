#!/usr/bin/env bash
# Reverse-DNS enumeration of a small IPv4 range (not a live-host check).
set -euo pipefail
usage() { echo "Usage: $0 <ipv4-prefix e.g. 192.168.56.> <start-octet> <end-octet>" >&2; exit 2; }
[[ $# == 3 ]] || usage
prefix=$1; start=$2; end=$3
[[ "$prefix" =~ ^([0-9]{1,3}\.){3}$ && "$start" =~ ^[0-9]+$ && "$end" =~ ^[0-9]+$ ]] || usage
IFS=. read -r a b c _ <<< "$prefix"
(( 10#$a <= 255 && 10#$b <= 255 && 10#$c <= 255 )) || usage
start=$((10#$start)); end=$((10#$end))
(( start >= 0 && end <= 255 && start <= end && end - start <= 63 )) || usage
command -v host >/dev/null 2>&1 || { echo 'Missing dependency: host' >&2; exit 1; }
printf 'Reverse DNS lookup for %s%d through %s%d\n' "$prefix" "$start" "$prefix" "$end"
for ((i=start; i<=end; i++)); do
  result=$(host "${prefix}${i}" 2>/dev/null) || continue
  if [[ "$result" == *'domain name pointer'* ]]; then
    printf '%s\n' "$result"
  fi
done
