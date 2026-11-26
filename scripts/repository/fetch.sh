#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../lib/common.sh"
[[ $# -eq 1 ]] || die "Usage: $0 PROJECT"
repo="$(project_repo "$1")"
require_bare "$repo"
git --git-dir="$repo" fetch --all --tags
