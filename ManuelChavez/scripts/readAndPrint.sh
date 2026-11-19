#!/usr/bin/env bash

# Reads one line from stdin (either typed by user or piped in)
IFS= read -r MY_VAR

echo "Line read: $MY_VAR"