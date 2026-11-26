#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../lib/common.sh"
[[ ! -d "$ROOT/src/linux" && ! -d "$ROOT/.git/modules/src/linux" && ! -d "$ROOT/.git/modules/src/busybox" ]] || die "Legacy checkout detected; read sessions/migration.md before proceeding."
for spec in "$ROOT"/configs/repositories/*.conf; do
    project="$(basename "$spec" .conf)"
    repo="$(project_repo "$project")"
    url="$(git config -f "$spec" --get remote.origin.url)"
    if [[ ! -e "$repo" ]]; then
        git clone --bare "$url" "$repo"
    fi
    require_bare "$repo"
    while IFS= read -r key; do
        value="$(git config -f "$spec" --get "$key")"
        git --git-dir="$repo" config --replace-all "$key" "$value"
    done < <(git config -f "$spec" --name-only --list)
    git --git-dir="$repo" fetch origin --tags
done
