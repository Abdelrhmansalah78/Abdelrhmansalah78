#!/usr/bin/env bash
# Small wordlist-based DNS discovery for domains you are allowed to assess.
set -euo pipefail
usage() { echo "Usage: $0 <domain> <wordlist.txt>" >&2; exit 2; }
[[ $# == 2 ]] || usage
domain=$1; wordlist=$2
[[ "$domain" =~ ^[A-Za-z0-9][A-Za-z0-9.-]*[A-Za-z0-9]$ ]] || usage
[[ -r "$wordlist" && -f "$wordlist" ]] || { echo 'Wordlist must be a readable file.' >&2; exit 2; }
command -v host >/dev/null 2>&1 || { echo 'Missing dependency: host' >&2; exit 1; }
checked=0
while IFS= read -r label || [[ -n "$label" ]]; do
  [[ -z "$label" || "$label" == \#* ]] && continue
  [[ "$label" =~ ^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$ || "$label" =~ ^[A-Za-z0-9]$ ]] || continue
  checked=$((checked + 1))
  if (( checked > 1000 )); then echo 'Reached the 1000-name safety limit.' >&2; break; fi
  fqdn="${label}.${domain}"
  result=$(host "$fqdn" 2>/dev/null) || continue
  if [[ "$result" == *'has address'* || "$result" == *'has IPv6 address'* ]]; then
    printf '%s\n' "$result"
  fi
done < "$wordlist"
