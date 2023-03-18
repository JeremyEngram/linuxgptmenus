#!/bin/bash

for file in /usr/local/bin/*; do
  if [[ ! "$file" =~ \.sh$ ]]; then
    mv "$file" "${file}.sh"
  fi
done
