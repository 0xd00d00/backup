#!/bin/bash 
while IFS= read -r line; do 
  if [[ $line == *","* ]]; then
      modified_line=$(echo "$line" | sed 's/\(.*[0-9]\)년 \(.*\)월 \(.*\)일\(.*\),/\1. \2. \3. \4/')
      echo "$modified_line" >> modi_file.txt
  else 
    echo "$line" >> modi_file.txt
  fi 
done < $1

mv modi_file.txt latest_miracle.txt
