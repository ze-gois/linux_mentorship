#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
die() { printf '%s\n' "$*" >&2; exit 1; }
valid_name() { [[ "$1" =~ ^[a-zA-Z0-9][a-zA-Z0-9._-]*$ ]] || die "Invalid name: $1"; }
project_repo() {
    valid_name "$1"
    [[ -f "$ROOT/configs/repositories/$1.conf" ]] || die "Unknown project: $1"
    printf '%s/repos/%s.git\n' "$ROOT" "$1"
}
require_bare() {
    [[ "$(git --git-dir="$1" rev-parse --is-bare-repository 2>/dev/null)" == true ]] || die "Not a bare repository: $1"
}
