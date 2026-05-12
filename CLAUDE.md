# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
make build   # docker buildx build -t hexletbasics/base-image .
make push    # docker push hexletbasics/base-image
```

Validation (used by derived images via `common/common.mk`):

```bash
make check              # runs all checks: description-lint, schema-validate, test
make description-lint   # yamllint on module description YAML files
make schema-validate    # ajv-cli validates spec/language/module/lesson YAML against JSON schemas
make test               # runs tests in all module Makefiles
```

## Architecture

This is a Docker base image for HexletBasics's coding exercise platform. Derived images extend it with language-specific runtimes (Python, Ruby, Java, etc.).

**Base image** (`Dockerfile`): built from `node:25-slim`, includes pnpm, python3, git, jq, yamllint, yq, ajv-cli. Published to DockerHub as `hexletbasics/base-image:latest`.

**Multi-arch strategy**: amd64 is built and pushed on every push to `main` (GitHub Actions). arm64 is built nightly on an ARM64 runner. A combined multi-arch manifest is created and pushed as `:latest` after the nightly arm64 build.

**`common/` directory**: copied into derived images at `/opt/basics/common`. Contains:
- JSON schemas (`spec.json`, `module.json`, `language.json`, `lesson.json`) for validating course content YAML
- Validation shell scripts in `common/bin/` that call `ajv-cli`
- `common.mk` — a shared Makefile included by derived image repos to run the full validation chain
- `yamllint.yml` — shared yamllint config (line-length checks disabled)

Derived image repos include `common.mk` via `include /opt/basics/common/common.mk` and rely on this image being available on DockerHub.
