# Linux mentorship laboratory

A laboratory for reproducing Linux mentorship sessions and experimenting with kernel revisions, configurations and runtimes.

- `repos/`: bare Git repositories only; locally generated.
- `worktrees/`: materialized source trees, grouped by project.
- `configs/`: versioned repository specifications and kernel, BusyBox and QEMU configurations.
- `experiments/`: local builds, runtime state and results.
- `scripts/`: lifecycle commands, grouped by responsibility.
- `sessions/` and `patches/`: versioned research material.

## Quick start (fresh clone)

```sh
bash scripts/repository/bootstrap.sh
bash scripts/worktree/populate.sh
bash scripts/worktree/list.sh
bash scripts/worktree/spawn.sh linux echo-2022 rust-for-linux/rust
```

Bootstrap clones full bare repositories and configures remotes. Population uses pinned commits, detached HEADs and no automatic source updates. To fetch new history explicitly, use `bash scripts/repository/fetch.sh linux`.

## Existing installation

Do not run bootstrap on a legacy checkout with populated `src/` or `.git/modules/src/`. See [migration notes](sessions/migration.md) to reuse local objects without downloading them again. The migration is intentionally manual until tested.

## Scope

The first implementation covers repositories and worktrees. Kernel configuration, out-of-tree builds, BusyBox initramfs and QEMU tests are the next layer; see [experiment design](scripts/experiment/README.md). No kernel build or QEMU boot is claimed by this scaffold.
