#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../lib/common.sh"
while IFS=$'\t' read -r project name revision; do
    [[ -z "$project" || "$project" == \#* ]] && continue
    repo="$(project_repo "$project")"
    require_bare "$repo"
    if ! git --git-dir="$repo" cat-file -e "${revision}^{commit}" 2>/dev/null; then
        die "Pinned revision unavailable: $project $revision. Fetch project history first."
    fi
    bash "$ROOT/scripts/worktree/spawn.sh" "$project" "$name" "$revision"
done < "$ROOT/configs/worktrees.tsv"
