SHELL_SCRIPT_PATH = /usr/local/bin/anyconnect-bitwarden

.PHONY: build
build:
	./scripts/build-shell.sh

.PHONY: clean
clean:
	rm -rf build

.PHONY: install
install:
	sudo rm -f "$(SHELL_SCRIPT_PATH)"
	sudo cp "$(PWD)/build/anyconnect-bitwarden" "$(SHELL_SCRIPT_PATH)"
