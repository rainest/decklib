#!/bin/bash -e

go install k8s.io/code-generator/cmd/deepcopy-gen
TMP_DIR=$(mktemp -d)
trap "rm -rf $TMP_DIR" EXIT

# konnect package
deepcopy-gen --input-dirs github.com/rainest/decklib/pkg/konnect \
  -O zz_generated.deepcopy \
  --go-header-file scripts/header-template.go.tmpl \
  --output-base $TMP_DIR

diff -Naur konnect/zz_generated.deepcopy.go \
  $TMP_DIR/github.com/rainest/decklib/pkg/konnect/zz_generated.deepcopy.go

# file package
deepcopy-gen --input-dirs github.com/rainest/decklib/pkg/file \
  -O zz_generated.deepcopy \
  --go-header-file scripts/header-template.go.tmpl \
  --output-base $TMP_DIR

diff -Naur file/zz_generated.deepcopy.go \
  $TMP_DIR/github.com/rainest/decklib/pkg/file/zz_generated.deepcopy.go
