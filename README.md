# Singularity Ubuntu Installer (Ubuntu 22.04 / 24.04)

```markdown


This repository provides:
- Automated installation scripts for **SingularityCE 4.3.3**
- Clean uninstall scripts
- Systemd-managed Singularity cache cleaner
- CI/local testing pipeline
- Example images and building scripts
- GitHub Actions CI

Supports:
- Ubuntu 22.04 LTS
- Ubuntu 24.04 LTS

Requires no Docker or Kubernetes. Only root privileges for installation.
Normal users may run Singularity without special groups.

## Quick Start
```bash
sudo bash scripts/install_singularity_24.04.sh
````

To test:

```bash
bash scripts/test_singularity.sh
```

To uninstall:

```bash
sudo bash scripts/uninstall_singularity.sh
```

## Systemd Cache Cleaner

Enable automatic cleanup:

```bash
sudo systemctl enable --now singularity-cache-cleaner.service
```

## Directory Tree

```bash
singularity-ubuntu-installer/
├── README.md
├── LICENSE
├── scripts/
│   ├── install_singularity_24.04.sh
│   ├── uninstall_singularity.sh
│   ├── test_singularity.sh
│   ├── clean_cache.sh
│   └── ci/
│       ├── github_ci_test.sh
│       └── local_ci_test.sh
├── systemd/
│   └── singularity-cache-cleaner.service
├── examples/
│   ├── hello-world.def
│   └── run_example.sh
├── .github/
│   └── workflows/
│       └── ci.yml
└── docs/
    ├── INSTALL.md
    ├── TESTING.md
    └── SYSTEMD.md
```

---
