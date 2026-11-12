#!/usr/bin/env bash
# Offline smoke tests: mocks replace nc, nmap, and host. No network traffic.
set -euo pipefail
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$tmp/bin"
cat > "$tmp/bin/nc" <<'NC'
#!/usr/bin/env bash
[[ "${@: -1}" == '22' || "${@: -1}" == '80' ]]
NC
cat > "$tmp/bin/nmap" <<'NMAP'
#!/usr/bin/env bash
printf '%s\n' "$*" > "$MOCK_NMAP_ARGS"
NMAP
cat > "$tmp/bin/host" <<'HOST'
#!/usr/bin/env bash
case "$1" in
  192.168.56.10) echo '10.56.168.192.in-addr.arpa domain name pointer lab.example.test.' ;;
  www.example.test) echo 'www.example.test has address 192.0.2.12' ;;
  *) echo 'not found' >&2; exit 1 ;;
esac
HOST
chmod +x "$tmp/bin/"*
export PATH="$tmp/bin:$PATH" MOCK_NMAP_ARGS="$tmp/nmap-args.txt"
output=$(bash "$script_dir/smart_scan.sh" 127.0.0.1 20 25)
[[ "$output" == *'Open TCP ports: 22'* ]]
[[ "$(cat "$MOCK_NMAP_ARGS")" == '-sV -p 22 127.0.0.1' ]]
output=$(bash "$script_dir/ip_discover.sh" 192.168.56. 10 12)
[[ "$output" == *'lab.example.test'* ]]
printf 'www\nadmin\n#skip\n' > "$tmp/wordlist.txt"
output=$(bash "$script_dir/subdomain_enum.sh" example.test "$tmp/wordlist.txt")
[[ "$output" == *'www.example.test has address'* ]]
[[ "$output" != *'admin.example.test'* ]]
if bash "$script_dir/smart_scan.sh" 'bad;target' 20 25 >/dev/null 2>&1; then exit 1; fi
printf 'All offline smoke tests passed.\n'
