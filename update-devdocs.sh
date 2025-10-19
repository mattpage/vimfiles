#!/usr/bin/env bash
# Build a local DevDocs index for offline fzf searching.
# Dependencies: curl, jq, fzf

set -euo pipefail

data_dir="${HOME}/.local/share/devdocs"
index_file="${HOME}/.local/devdocs_index.txt"
manifest_url="https://devdocs.io/docs.json"
cdn_url="https://documents.devdocs.io"
site_url="https://devdocs.io"

mkdir -p "$data_dir"
: > "$index_file"

echo "→ Fetching DevDocs manifest..."
manifest="$(curl -fsSL "$manifest_url")"

# Limit which docsets to fetch (optional)
wanted=(
  "css"
  "dom"
  "go"
  "html"
  "http"
  "javascript"
)

for slug in "${wanted[@]}"; do
  echo "→ Downloading $slug ..."
  doc_url="${cdn_url}/${slug}/index.json"
  dest="${data_dir}/${slug}.json"

  if ! curl -fsSL "$doc_url" -o "$dest"; then
    echo "  ⚠️ Failed to fetch $slug"
    continue
  fi

  # Verify JSON integrity
  if ! jq empty "$dest" 2>/dev/null; then
    echo "  ⚠️ Invalid JSON in $slug"
    continue
  fi

  name="$(echo "$manifest" | jq -r --arg slug "$slug" '.[] | select(.slug==$slug) | .name // $slug')"
  jq -r --arg slug "$slug" --arg name "$name" --arg site "$site_url" '
    .entries[]? | select(.path) |
    "\($name): \(.name // .path)\t\($site)/\($slug)/\(.path)"
  ' "$dest" >> "$index_file"
done

echo "✅ Done. Built index at $index_file"
echo "   Search with:"
echo "   cat ~/.local/devdocs_index.txt | fzf --delimiter='\t' --with-nth=1 | cut -f2 | xargs open"
