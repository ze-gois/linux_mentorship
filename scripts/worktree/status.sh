#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../lib/common.sh"
[[ $# -eq 2 ]] || die "Usage: $0 PROJECT NAME"
repo="$(project_repo "$1")"; valid_name "$2"
target="$ROOT/worktrees/$1/$2"
[[ -e "$target/.git" ]] || die "Missing worktree: $target"
[[ "$(git -C "$target" rev-parse --path-format=absolute --git-common-dir)" == "$(realpath "$repo")" ]] || die "Different repository"
git -C "$target" status --short --branch
git -C "$target" log -1 --oneline
