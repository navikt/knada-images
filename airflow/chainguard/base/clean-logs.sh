#!/usr/bin/env bash
set -euo pipefail

readonly DIRECTORY="${AIRFLOW_HOME:-/usr/local/airflow}"
readonly RETENTION_DAYS="${AIRFLOW__LOG_RETENTION_DAYS:-15}"
readonly RETENTION_MINUTES="${AIRFLOW__LOG_RETENTION_MINUTES:-0}"
readonly FREQUENCY="${AIRFLOW__LOG_CLEANUP_FREQUENCY_MINUTES:-15}"
readonly MAX_PERCENT="${AIRFLOW__LOG_MAX_SIZE_PERCENT:-0}"

trap "exit" INT TERM

MAX_SIZE_BYTES="${AIRFLOW__LOG_MAX_SIZE_BYTES:-0}"
if [[ "$MAX_SIZE_BYTES" -eq 0 && "$MAX_PERCENT" -gt 0 ]]; then
  total_space=$(df -k "${DIRECTORY}"/logs 2>/dev/null | tail -1 | awk '{print $2}' || echo "0")
  MAX_SIZE_BYTES=$(( total_space * 1024 * MAX_PERCENT / 100 ))
  echo "Computed MAX_SIZE_BYTES from ${MAX_PERCENT}% of disk: ${MAX_SIZE_BYTES} bytes"
fi

readonly MAX_SIZE_BYTES

readonly EVERY=$((FREQUENCY*60))

echo "Cleaning logs every $EVERY seconds"
if [[ "$MAX_SIZE_BYTES" -gt 0 ]]; then
  echo "Max log size limit: $MAX_SIZE_BYTES bytes"
fi

retention_days="${RETENTION_DAYS}"

while true; do
  total_retention_minutes=$(( (retention_days * 1440) + RETENTION_MINUTES ))
  echo "Trimming airflow logs older than ${total_retention_minutes} minutes."

  find "${DIRECTORY}"/logs \
    -type d -name 'lost+found' -prune -o \
    -type f -mmin +"${total_retention_minutes}" -name '*.log' -print0 | \
    xargs -0 rm -f || true

  if [[ "$MAX_SIZE_BYTES" -gt 0 && "$retention_days" -ge 0 ]]; then
    current_size=$(df -k "${DIRECTORY}"/logs 2>/dev/null | tail -1 | awk '{print $3}' || echo "0")
    current_size=$(( current_size * 1024 ))

    if [[ "$current_size" -gt "$MAX_SIZE_BYTES" ]]; then
      retention_days=$((retention_days - 1))
      echo "Size ($current_size bytes) exceeds limit ($MAX_SIZE_BYTES bytes). Reducing retention to ${retention_days} days."
      continue
    fi
  fi

  find "${DIRECTORY}"/logs -type d -empty -delete || true

  retention_days="${RETENTION_DAYS}"

  seconds=$(( $(date -u +%s) % EVERY))
  (( seconds < 1 )) || sleep $((EVERY - seconds - 1))
  sleep 1
done
