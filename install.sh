#!/usr/bin/env bash
# motodo installer — copies `todo` onto your PATH and adds the login banner hook.
# Idempotent: safe to run more than once.
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="${MOTODO_BIN:-$HOME/.local/bin}"
PROFILE="${MOTODO_PROFILE:-$HOME/.bash_profile}"
HOOK='case $- in *i*) command -v todo >/dev/null 2>&1 && todo banner ;; esac'
MARK='# --- motodo login banner ---'

mkdir -p "$BIN_DIR"
install -m 0755 "$SRC_DIR/todo" "$BIN_DIR/todo"
echo "installed: $BIN_DIR/todo"

if [ -f "$PROFILE" ] && grep -Fq "$MARK" "$PROFILE"; then
  echo "login hook already present in $PROFILE"
else
  {
    printf '\n%s\n' "$MARK"
    printf '# Shows open tasks on login. Manage with: todo add / todo done <id> / todo rm <id>\n'
    printf '%s\n' "$HOOK"
    printf '# --- end motodo login banner ---\n'
  } >> "$PROFILE"
  echo "added login hook to $PROFILE"
fi

case ":$PATH:" in
  *":$BIN_DIR:"*) : ;;
  *) echo "note: $BIN_DIR is not on your PATH — add it so 'todo' is found." ;;
esac

echo
echo "done. Open a new login shell, or run: todo add \"try me\""
