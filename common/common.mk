COMMON_DIR := /opt/basics/common

check: description-lint code-lint schema-validate markdown-lint test

description-lint:
	yamllint modules -c $(COMMON_DIR)/yamllint.yml

test:
	@(for i in $$(find modules/** -type f -name Makefile); do make test -C $$(dirname $$i) || exit 1; done)

markdown-lint:
	rumdl check --config $(COMMON_DIR)/.rumdl.toml modules

markdown-lint-fix:
	rumdl fmt --config $(COMMON_DIR)/.rumdl.toml modules

schema-validate:
	@$(COMMON_DIR)/bin/validate-spec.sh
	@$(COMMON_DIR)/bin/validate-language.sh
	@$(COMMON_DIR)/bin/validate-modules.sh
	@$(COMMON_DIR)/bin/validate-lessons.sh

.PHONY: all test
