# Singularity Ubuntu Installer (Ubuntu 22.04 / 24.04)


This repository provides:
- Automated installation scripts for **SingularityCE 4.3.3**
- Clean uninstall scripts
- Systemd-managed Singularity cache cleaner
- CI/local testing pipeline
- Example images and building scripts
- GitHub Actions CI


Supports:
- Ubuntu 24.04 LTS


Requires no Docker or Kubernetes. Only root privileges for installation.
Normal users may run Singularity without special groups.
sudo bash scripts/install_singularity_24.04.sh
