#!/bin/bash

# Converts any string to lower_snake_case
to_snake_case() {
  echo "$1" |
    sed -E 's/([a-z0-9])([A-Z])/\1_\2/g' |       # camelCase -> snake_case
    sed -E 's/([A-Z])([A-Z][a-z])/\1_\2/g' |     # ABBCC -> AB_BCC
    tr '[:upper:]' '[:lower:]'
}

# Fix path segment by segment
fix_path() {
  path="$1"
  IFS='/' read -ra parts <<< "$path"
  new_parts=()
  for part in "${parts[@]}"; do
    new_parts+=( "$(to_snake_case "$part")" )
  done
  IFS='/'; echo "${new_parts[*]}"
}

# Loop through all .dart files
find ./lib -type f -name "*.dart" | while read file; do
  # Process import/export/part/part of statements
  grep -oE "(import|export|part of|part) ['\"][^'\"]+['\"]" "$file" | while read line; do
    keyword=$(echo "$line" | awk '{print $1}')
    original_path=$(echo "$line" | cut -d"'" -f2)

    # Skip if not .dart
    if [[ "$original_path" != *".dart" ]]; then
      continue
    fi

    fixed_path=$(fix_path "$original_path")

    if [[ "$original_path" != "$fixed_path" ]]; then
      sed -i '' "s|$original_path|$fixed_path|g" "$file"
      echo "✔ $keyword updated: $original_path -> $fixed_path in $file"
    fi
  done
done

echo "✅ All import/export/part paths converted to lower_snake_case."
