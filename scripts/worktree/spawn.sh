#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../lib/common.sh"
[[ $# -eq 3 ]] || die "Usage: $0 PROJECT NAME REVISION"
project="$1"; name="$2"; revision="$3"
repo="$(project_repo "$project")"
valid_name "$name"
require_bare "$repo"
target="$ROOT/worktrees/$project/$name"
commit="$(git --git-dir="$repo" rev-parse --verify --end-of-options "${revision}^{commit}")" || die "Revision unavailable: $revision (fetch first)"
if [[ -e "$target" ]]; then
    [[ -e "$target/.git" ]] || die "Destination exists but is not a worktree: $target"
    [[ "$(git -C "$target" rev-parse --path-format=absolute --git-common-dir)" == "$(realpath "$repo")" ]] || die "Different repository: $target"
    [[ "$(git -C "$target" rev-parse HEAD)" == "$commit" ]] || die "Existing worktree has another revision: $target"
    printf 'Already present: %s\n' "$target"
    exit 0
fi
mkdir -p "$(dirname "$target")"
git --git-dir="$repo" worktree add --detach "$target" "$commit"
