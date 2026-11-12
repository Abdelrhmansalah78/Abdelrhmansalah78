# Linux Apache Web Server Deployment Lab

**Type:** Linux system administration and local-network website hosting  
**Web server:** Apache HTTP Server (`httpd`)  
**Document root:** `/var/www/html`

## Project overview

This educational demonstration shows how a static website/template was served from a Linux host using Apache. The evidence is a recording of command-line service management followed by a browser opening the site locally.

## What is visible in the recording

1. Website files are present under `/var/www/html`, Apache's document root.
2. Apache service management is demonstrated using `systemctl stop httpd`, `systemctl start httpd`, and `systemctl status httpd`.
3. The `httpd` service is shown as **active (running)** and serving HTTP on port **80**.
4. Firefox loads a **Coming Soon** web page using the local IP `192.168.1.8`.

The displayed page uses a **Kool Form Pack** template. This is documentation of **web deployment and Linux service administration**, not evidence of original website design.

## Evidence

**[Linux_Apache_Web_Server_Deployment_Demo.mov — Google Drive](https://drive.google.com/file/d/1gyvwGEoICSp6-Q9yJ18eGuxJv70Q-st9/view)**

The file was renamed on Drive from `Project .mov` to make its subject clear. The video remains hosted on Drive rather than being added as a large binary file.

## Skills demonstrated

- Basic Linux filesystem navigation and document-root management
- Apache HTTP Server service management using `systemctl`
- Verifying access to an HTTP site from a local-network browser

## Scope and limitations

The recording supports a **local-network deployment demo**. It does not establish public internet hosting, domain/DNS setup, HTTPS/TLS configuration, cloud deployment, CI/CD, production uptime, or an original website codebase. The site's source files and full server configuration are not included here.

## Author

Abdelrhman Salah — Computer Science student | Cybersecurity & DevSecOps
