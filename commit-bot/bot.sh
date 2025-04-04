#!/bin/bash

info="Commit: $(date)"

# Change directory silently
case "$OSTYPE" in
    darwin*) cd "`dirname $0`" >/dev/null 2>&1 || exit 1 ;;
    linux*) cd "$(dirname "$(readlink -f "$0")")" >/dev/null 2>&1 || exit 1 ;;
    msys*|cygwin*) cd "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ;;
    *) exit 1 ;;
esac

# Write commit message silently
echo "$info" >> output.txt

# Check if inside a Git repository
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 1

# Get current branch
branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

# Commit & push changes silently
git add output.txt >/dev/null 2>&1
git commit -m "$info" >/dev/null 2>&1
git push origin "$branch" >/dev/null 2>&1
