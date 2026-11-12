# Bash Security & Network Discovery Scripts

Three **educational Bash scripts** written as network and security exercises. The published versions were **reviewed and corrected** from the author's earlier drafts to improve variable handling, argument validation, dependency checks, and accuracy of their descriptions. They are not production-grade scanners.

| Script | Purpose | Notes |
| --- | --- | --- |
| [`smart_scan.sh`](smart_scan.sh) | Checks a bounded set of TCP ports with Netcat; sends the open-port list to Nmap service detection | `nc` and `nmap` required |
| [`ip_discover.sh`](ip_discover.sh) | Performs PTR / reverse DNS lookups for an IPv4 range | Does **not** prove hosts are online |
| [`subdomain_enum.sh`](subdomain_enum.sh) | Checks a wordlist of candidate DNS names | Fixed typo in original file name (`subdomin_enum.sh`) |

## Run examples

```bash
bash smart_scan.sh 127.0.0.1 20 100
bash ip_discover.sh 192.168.56. 10 20
bash subdomain_enum.sh example.test wordlist.txt
```

Use only authorized lab targets/domains. The port script checks a maximum of 1,024 ports per invocation, the reverse-DNS script at most 64 addresses, and the subdomain script at most 1,000 wordlist entries.

## Validation

All three scripts pass `bash -n` syntax validation. An **offline smoke test** using mocked `nc`, `nmap`, and `host` commands verifies selected happy-path and error-handling behavior without generating network traffic:

```bash
bash tests/test_scripts.sh
```

The offline test does **not** establish correctness against real networks, operating systems, DNS responses, or arbitrary targets.

## Changes from original drafts

- Fixed `smart_scan.sh` inconsistent variables/array references and corrected Nmap version detection flag to `-sV`.
- Replaced incorrect empty-array check, quoted arguments, validated port boundaries, and added dependency checks.
- Described the original `ip_discover.sh` more accurately as reverse DNS, not live-host discovery.
- Replaced unsafe wordlist expansion with a line-oriented loop and added basic input validation to subdomain enumeration.

**Ethics:** Run network scans or enumerations only where you have explicit permission. No credentials, real organization target lists, or attack payloads are included.
