#!/usr/bin/env bash
# The machine-wide heavy-run lock — one wheel-scale process at a time
# (CLAUDE.md ⧗'s resource pair, mechanized). A 2026-07-31 measured kill:
# two gate legs beside foreign builds on a full zram swap took the whole
# session down. The lock is a TTL LEASE, not a pid (a session's heavy
# work spans many short-lived shells, so any live-pid test reads its own
# holder as dead — measured at this script's first instrument-check):
# acquire stamps an epoch; a lease older than the TTL is stale and
# stolen; `touch` renews mid-session; `release` ends it. A crashed
# session costs at most one skipped heavy window. The MemAvailable
# floor rides the same verb: acquire refuses when the machine cannot
# hold a wheel-scale run even if the lease is free.
#
#   tools/heavy-lock.sh acquire   # exit 0 = you hold the lease; 1 = held/low-mem
#   tools/heavy-lock.sh touch     # renew the lease (long marches)
#   tools/heavy-lock.sh release   # end the lease
#   tools/heavy-lock.sh status    # holder age + MemAvailable; exit 0 free / 1 held
#
# Destiny: dissolves into the medium's own scheduler when compile-spine
# fanout owns machine residency (band E) — bash scaffold tier until then.
set -u
LOCK_DIR="${MENTL_HEAVY_LOCK:-/tmp/mentl-heavy-lock.d}"
TTL_SECONDS="${MENTL_HEAVY_TTL:-1800}"              # 30 min — one skipped 20-min window worst case
MEM_FLOOR_KB=$((6 * 1024 * 1024))                    # 6 GiB — the self-compile's ~3GB peak class, doubled

mem_avail_kb() { awk '/MemAvailable/ {print $2}' /proc/meminfo; }
lease_epoch()  { cat "$LOCK_DIR/epoch" 2>/dev/null || echo 0; }
lease_age()    { echo $(( $(date +%s) - $(lease_epoch) )); }
lease_live()   { [ -d "$LOCK_DIR" ] && [ "$(lease_age)" -lt "$TTL_SECONDS" ]; }

case "${1:-status}" in
  acquire)
    avail="$(mem_avail_kb)"
    if [ "$avail" -lt "$MEM_FLOOR_KB" ]; then
      echo "heavy-lock: REFUSED — MemAvailable ${avail}kB below the $((MEM_FLOOR_KB/1024/1024))GiB floor"
      exit 1
    fi
    if lease_live; then
      echo "heavy-lock: HELD — lease $(lease_age)s old (ttl ${TTL_SECONDS}s)"
      exit 1
    fi
    rm -rf "$LOCK_DIR"; mkdir "$LOCK_DIR" || { echo "heavy-lock: race lost"; exit 1; }
    date +%s > "$LOCK_DIR/epoch"
    echo "heavy-lock: acquired (lease ${TTL_SECONDS}s)"; exit 0
    ;;
  touch)
    [ -d "$LOCK_DIR" ] && date +%s > "$LOCK_DIR/epoch" && echo "heavy-lock: lease renewed" && exit 0
    echo "heavy-lock: no lease to renew"; exit 1
    ;;
  release)
    rm -rf "$LOCK_DIR"; echo "heavy-lock: released"; exit 0
    ;;
  status)
    avail="$(mem_avail_kb)"
    if lease_live; then
      echo "heavy-lock: HELD — lease $(lease_age)s old · MemAvailable ${avail}kB"; exit 1
    fi
    echo "heavy-lock: free · MemAvailable ${avail}kB"; exit 0
    ;;
  *)
    echo "usage: heavy-lock.sh acquire|touch|release|status"; exit 2
    ;;
esac
