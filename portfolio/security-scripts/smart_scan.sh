#!/usr/bin/env bash
# Educational TCP port check followed by Nmap service detection.
# Run only against hosts you own or are explicitly authorized to assess.
set -euo pipefail

usage() { echo "Usage: $0 <target-ip-or-host> [start-port=1] [end-port=1024]" >&2; exit 2; }
[[ $# -ge 1 && $# -le 3 ]] || usage
target=$1
start=${2:-1}
end=${3:-1024}
[[ "$target" =~ ^[A-Za-z0-9][A-Za-z0-9._-]*$ ]] || { echo "Invalid target." >&2; exit 2; }
[[ "$start" =~ ^[0-9]+$ && "$end" =~ ^[0-9]+$ ]] || usage
start=$((10#$start)); end=$((10#$end))
(( start >= 1 && end <= 65535 && start <= end && end - start <= 1023 )) || {
  echo "Choose a valid range of at most 1024 ports." >&2; exit 2;
}
for cmd in nc nmap; do command -v "$cmd" >/dev/null 2>&1 || { echo "Missing dependency: $cmd" >&2; exit 1; }; done

open_ports=()
printf 'Checking TCP ports %d-%d on %s ...\n' "$start" "$end" "$target"
for ((port=start; port<=end; port++)); do
  if nc -z -w 1 "$target" "$port" >/dev/null 2>&1; then
    open_ports+=("$port")
  fi
done
if (( ${#open_ports[@]} == 0 )); then
  echo "No open TCP ports found in the specified range."
  exit 0
fi
ports_csv=$(IFS=,; echo "${open_ports[*]}")
printf 'Open TCP ports: %s\n' "$ports_csv"
echo 'Running Nmap version detection on identified ports...'
nmap -sV -p "$ports_csv" "$target"
