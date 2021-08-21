GOLANGCI_VERSION = 1.34.0

ci: clean lint test
.PHONY: ci

LDFLAGS := -ldflags="-s -w"

bin/golangci-lint: bin/golangci-lint-${GOLANGCI_VERSION}
	@ln -sf golangci-lint-${GOLANGCI_VERSION} bin/golangci-lint
bin/golangci-lint-${GOLANGCI_VERSION}:
	@curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | BINARY=golangci-lint bash -s -- v${GOLANGCI_VERSION}
	@mv bin/golangci-lint $@

clean:
	@echo "--- clean all the things"
	@rm -rf dist
.PHONY: clean

lint: bin/golangci-lint
	@echo "--- lint all the things"
	@bin/golangci-lint run
.PHONY: lintg

test:
	@echo "--- test all the things"
	@go test -v -cover ./...
.PHONY: test

build: 
	goreleaser release --snapshot --skip-publish --rm-dist
.PHONY: build