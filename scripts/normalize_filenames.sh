#!/bin/bash

# Normalize filenames and folder names inside lib/ to lower_snake_case
find lib -depth | while read path; do
  base=$(basename "$path")
  dir=$(dirname "$path")
  snake=$(echo "$base" | sed -E 's/([a-z0-9])([A-Z])/\1_\2/g' | tr '[:upper:]' '[:lower:]')

  if [[ "$base" != "$snake" ]]; then
    mv "$path" "$dir/$snake"
  fi
done

echo "✅ All lib/ files and folders converted to lower_snake_case"
