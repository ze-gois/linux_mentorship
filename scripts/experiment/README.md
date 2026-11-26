# Experiment lifecycle (design)

Proposed commands: spawn, configure, menuconfig, build, test, debug, snapshot, status, destroy.

An experiment refers to an existing worktree, records its commit, selects a configuration fragment and uses an independent absolute Kbuild output path. For example:

```sh
make -C worktrees/linux/rust-next O="$PWD/experiments/minimal/build" LLVM=1 KCONFIG_ALLCONFIG="$PWD/configs/kernel/qemu-rust-minimal.config" allnoconfig
make -C worktrees/linux/rust-next O="$PWD/experiments/minimal/build" LLVM=1 -j8
```

QEMU should boot arch/x86/boot/bzImage from the output tree with a compatible BusyBox initramfs and serial console. Automated assertions and toolchain validation remain to be implemented. Worktree deletion must eventually account for experiment dependencies.
