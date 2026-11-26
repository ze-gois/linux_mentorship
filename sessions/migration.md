# Migrating the existing local checkout

The old layout used submodules at src/linux and src/busybox, plus a linked src/linux-rust worktree. The published parent now uses bare repositories and a pinned manifest instead.

Do not delete the old administrative databases. Before pulling the new parent commit, inspect git status (including ignored files) in all three source trees, back up any changes and record refs. A safe migration can clone the existing administrative databases locally with git clone --bare --local, then import every needed remote-tracking ref and tag from the old Linux database before removing it. Local cloning may hardlink objects; verify the resulting repositories with git fsck and compare refs before deleting anything. Do not use --shared or alternates if the old database will be removed.

A migration script is deliberately deferred until the actual local layout and refs are inspected. Fresh-clone bootstrap refuses to proceed when legacy directories are detected.
