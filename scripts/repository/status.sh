#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../lib/common.sh"
for repo in "$ROOT"/repos/*.git; do
    [[ -d "$repo" ]] || continue
    require_bare "$repo"
    printf '\n=== %s ===\n' "$repo"
    git --git-dir="$repo" remote -v
    git --git-dir="$repo" count-objects -vH
done
