#!/bin/bash
# Fuente original: https://gist.github.com/jthan24/de226afb3f84439ff122684ad047e469
# Modificado para ejecutarse en una MAC.

THRESHOLD=80

# Check CPU load
CPU_LOAD=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')
echo "CPU Load: $CPU_LOAD%"

# Check memory usage
MEMORY=$(vm_stat | awk '
  /Pages active:/   { active = $3; gsub(/[^0-9]/, "", active) }
  /Pages inactive:/ { inactive = $3; gsub(/[^0-9]/, "", inactive) }
  /Pages wired down:/ { wired = $4; gsub(/[^0-9]/, "", wired) }
  /Pages free:/     { free = $3; gsub(/[^0-9]/, "", free) }
  END {
    used = active + inactive + wired
    total = used + free
    if (active !~ /^[0-9]+$/ || inactive !~ /^[0-9]+$/ || wired !~ /^[0-9]+$/ || free !~ /^[0-9]+$/ || total == 0) exit 1
    printf "%.2f", used / total * 100
  }') || { echo "Error: unable to calculate memory usage" >&2; exit 1; }
echo "Memory Usage: $MEMORY%"

# Check disk space
DISK=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
echo "Disk Usage: $DISK%"

# Alert if any metric exceeds threshold
if awk -v cpu="$CPU_LOAD" -v memory="$MEMORY" -v disk="$DISK" -v threshold="$THRESHOLD" 'BEGIN {
    exit !((cpu + 0) > threshold || (memory + 0) > threshold || (disk + 0) > threshold)
}'; then
    echo "Alert: One of the metrics is above $THRESHOLD%"
fi