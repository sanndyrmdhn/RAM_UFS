# RAM UFS Tweak

A kernel-level performance script for rooted Android devices (Magisk). Runs automatically after boot and applies low-level optimizations across storage, memory, and the Java runtime — making your phone feel snappier, keep more apps alive in the background, and stutter less under load.

---

## What this module optimizes

### Storage I/O
Switches the disk scheduler to `deadline`, which prioritizes read requests over writes. Read-ahead is bumped to 512 KB so the kernel prefetches more data per access. Redundant overhead like I/O statistics tracking and entropy generation are disabled, and the read expiry window is tightened to 250 ms for faster response times.

### Disk write behavior
Instead of flushing dirty pages to disk constantly, the module extends the writeback interval to every 15 seconds, reducing write storms. Dirty page ratios are capped at 20% (foreground) and 5% (background), so large writes happen in a controlled, predictable way rather than all at once.

### RAM & swap balance
Swappiness is set to 30, telling the kernel to strongly prefer keeping data in RAM before touching ZRAM. VFS cache pressure is halved to 50, so filesystem metadata stays cached longer. Page cluster is set to 0 — the optimal setting for ZRAM-equipped devices since swap prefetching wastes CPU on compressed pages. A minimum of 64 MB is always kept free as a buffer.

### Low Memory Killer (LMK)
The LMK is tuned to be more patient before killing background apps. It only acts when thrashing crosses 50%, swap free drops below 10%, or PSI memory stall exceeds 50 ms — meaning apps survive longer during normal multitasking. When a kill is needed, it completes within 100 ms so the system recovers quickly.

### Dalvik / ART heap
The Java runtime heap starts at 16 MB per app (light on boot) and can grow up to 512 MB for heavy apps, with a 256 MB soft growth limit for typical usage. Garbage collection is tuned to trigger at 60% heap utilization and free between 4–16 MB per cycle, reducing GC pause frequency without letting memory bloat.

---

## Compatibility

- Android 10.0 or higher
- Kernel version 4.14 or higher
- Magisk 26 or higher
- ZRAM enabled (recommended)

## Download

- Download from the [release page](https://github.com/sanndyrmdhn/RAM_UFS/releases)
- Download and flash the zip in magisk manager ( Not tested in KSU and APatch )
- Reboot the device


## Notes
- Tested on Xiaomi/Redmi devices running HyperOS; may work on other ROMs with minor adjustments
