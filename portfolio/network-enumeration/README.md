# Network Scanning & SMB Enumeration

**Type:** Metasploitable lab exercise  
**Tools:** Nmap, enum4linux, service inspection, SearchSploit research

## Objective

Identify exposed services and investigate SMB users, groups, and shared resources on an intentionally vulnerable lab target.

## Activities supported by the walkthrough

- Used Nmap to inspect exposed network services.
- Inspected HTTP resources presented by the lab target.
- Used `enum4linux` to enumerate SMB account/group information and available shares.
- Observed share-enumeration output, including results showing `Mapping: OK` and `Listing: OK` for a share named `tmp`.
- Used SearchSploit to research service-related exploit information; **successful exploitation was not shown or claimed**.

## Evidence

**[View recorded walkthrough on Google Drive](https://drive.google.com/file/d/1iNhNdmO4BxjR5rsyLtVe076yPyd1eKhC/view)**. Access may depend on Drive sharing permissions.

## Relationship to vulnerability-assessment project

The [Nmap / Nessus vulnerability-assessment project](https://github.com/Abdelrhmansalah78/vulnerability-scan) focuses on scanner findings and remediation reporting. This separate exercise emphasizes deeper **service and SMB enumeration**. Shared tools and a training target do not imply distinct confirmed vulnerabilities.

## Limitations

Read access or share-listing success is not evidence of write access or exploitability. Scanner/enumeration output is not proof of unauthorized access.

**Authorized educational testing only.**
