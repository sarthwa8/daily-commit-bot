#!/usr/bin/env bash
#
# Appends one timestamped line to activity-log.md.
# Args: $1 = this commit's index, $2 = total commits in the run (both optional).
#
set -euo pipefail

i="${1:-1}"
n="${2:-1}"
ts="$(date -u +'%Y-%m-%d %H:%M:%S UTC')"

# Create the log with a header the first time it's used.
if [ ! -f activity-log.md ]; then
  printf '# Activity log\n\nAutomated daily activity. One line per commit.\n\n' > activity-log.md
fi

printf -- '- %s — activity %s/%s\n' "$ts" "$i" "$n" >> activity-log.md
