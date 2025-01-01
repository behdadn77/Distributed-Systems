#!/bin/bash
# Start with an empty file
> merged.md

# Add the content of readme.md as the introduction
echo "# Distributed Systems Exam Preparation" >> merged.md
echo "" >> merged.md
cat readme.md >> merged.md
echo -e "\n---\n" >> merged.md

# Generate the Table of Contents
echo "# Table of Contents" >> merged.md
find exercises notes pastExams questions -name '*.md' | sort | while read file; do
  dir_name=$(dirname "$file")
  file_name=$(basename "$file" .md)
  
  # Add TOC entry with an anchor link
  echo "- [$dir_name/$file_name](#$dir_name-$file_name)" >> merged.md
done
echo -e "\n---\n" >> merged.md

# Append all files with section headers and anchors
find exercises notes pastExams questions -name '*.md' | sort | while read file; do
  dir_name=$(dirname "$file")
  file_name=$(basename "$file" .md)
  
  # Add directory and file name as section title with anchor
  echo "## [$dir_name/$file_name](#$dir_name-$file_name)" >> merged.md
  echo "<a id='$dir_name-$file_name'></a>" >> merged.md
  
  # Append file content with a separator
  cat "$file" >> merged.md
  echo -e "\n---\n" >> merged.md
done
