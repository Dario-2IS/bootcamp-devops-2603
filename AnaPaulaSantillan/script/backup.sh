#Instrucciones
#Como base: https://gist.github.com/jthan24/de226afb3f84439ff122684ad047e469
#Se ejecutó en una MAC.

#!/bin/bash
THRESHOLD=80
# Check CPU load
CPU_LOAD=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')

echo "CPU Load: $CPU_LOAD%"
# Check memory usage
MEMORY=$(vm_stat | awk '
  /Pages active/   { active=$3 }
  /Pages inactive/ { inactive=$3 }
  /Pages wired/    { wired=$4 }
  /Pages free/     { free=$3 }
  END {
    used = active + inactive + wired
    total = used + free
    printf "%.2f", used/total * 100.0
  }')

echo "Memory Usage: $MEMORY%"
# Check disk space
DISK=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

echo "Disk Usage: $DISK%"
# Alert if any metric exceeds threshold
if [[ "$CPU_LOAD" > "$THRESHOLD" || "$MEMORY" > "$THRESHOLD" || "$DISK" > "$THRESHOLD" ]]; then
echo "Alert: One of the metrics is above $THRESHOLD%"
fi