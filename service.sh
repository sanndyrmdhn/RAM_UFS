while [[ "$(getprop sys.boot_completed)" != "1" ]]; do
    sleep 3
done
# Main Storage (sda) Tuning
echo deadline > /sys/block/sda/queue/scheduler 2>/dev/null
echo 512 > /sys/block/sda/queue/read_ahead_kb
echo 128 > /sys/block/sda/queue/nr_requests
echo 0 > /sys/block/sda/queue/iostats
echo 0 > /sys/block/sda/queue/add_random
echo 0 > /sys/block/sda/queue/nomerges
echo 2 > /sys/block/sda/queue/rq_affinity

# Deadline Specifics
echo 250 > /sys/block/sda/queue/iosched/read_expire
echo 10 > /sys/block/sda/queue/iosched/writes_starved
echo 10 > /sys/block/sda/queue/iosched/fifo_batch

# System Writeback
echo 1500 > /proc/sys/vm/dirty_writeback_centisecs
echo 20 > /proc/sys/vm/dirty_ratio
echo 5 > /proc/sys/vm/dirty_background_ratio

# Swappiness (Keseimbangan RAM & ZRAM)
echo 30 > /proc/sys/vm/swappiness

# VFS Cache Pressure
echo 50 > /proc/sys/vm/vfs_cache_pressure

# LMK
echo 65536 > /proc/sys/vm/min_free_kbytes
echo 32768 > /proc/sys/vm/extra_free_kbytes
resetprop ro.lmk.thrashing_limit 50
resetprop ro.lmk.thrashing_limit_decay 70
resetprop ro.lmk.swap_free_low_percentage 10
resetprop ro.lmk.swap_util_max 85
resetprop ro.lmk.psi_partial_stall_ms 50
resetprop ro.lmk.psi_complete_stall_ms 100
resetprop ro.lmk.kill_timeout_ms 100

# Page Cluster
echo 0 > /proc/sys/vm/page-cluster

# Overcommit Memory
echo 0 > /proc/sys/vm/overcommit_memory

# Compact Memory
echo 1 > /proc/sys/vm/compact_memory

# Dalvik VM
resetprop dalvik.vm.heapstartsize 16m
resetprop dalvik.vm.heapgrowthlimit 256m
resetprop dalvik.vm.heapsize 512m
resetprop dalvik.vm.heaptargetutilization 0.6
resetprop dalvik.vm.heapminfree 4m
resetprop dalvik.vm.heapmaxfree 16m

# Disable HyperOS "memory compaction"
resetprop ro.config.avoid_gfx_accel false
echo 0 > /proc/sys/vm/zone_reclaim_mode