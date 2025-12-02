PREFIX=/usr/local
SING_VER=v4.3.4

install:
	bash scripts/install_singularity_24.04.sh

clean:
	sudo bash scripts/uninstall_singularity.sh

test:
	bash scripts/test_singularity.sh