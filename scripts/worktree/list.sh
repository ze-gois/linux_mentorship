#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../lib/common.sh"
for repo in "$ROOT"/repos/*.git; do
    [[ -d "$repo" ]] || continue
    require_bare "$repo"
    printf '\n=== %s ===\n' "$(basename "$repo")"
    git --git-dir="$repo" worktree list
done
