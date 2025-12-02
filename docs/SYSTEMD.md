# Systemd Cleanup Service

Enable the cleanup:

```bash
sudo cp systemd/singularity-cache-cleaner.service /etc/systemd/system/
sudo systemctl enable --now singularity-cache-cleaner.service
