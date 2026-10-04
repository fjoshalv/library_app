#!/usr/bin/env bash
# Runs the tests of every workspace package that has a test/ folder.
set -euo pipefail
cd "$(dirname "$0")/.."

for dir in app packages/*; do
  [ -d "$dir/test" ] || continue
  echo "==> $dir"
  if grep -q 'sdk: flutter' "$dir/pubspec.yaml"; then
    (cd "$dir" && flutter test)
  else
    (cd "$dir" && dart test)
  fi
done
