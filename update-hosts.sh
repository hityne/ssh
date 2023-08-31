#!/bin/bash

# URL to fetch data from
URL="https://gitlab.com/ineo6/hosts/-/raw/master/next-hosts"

# Temporary file to hold the fetched data
TMP_FILE="/tmp/next-hosts.tmp"

# Backup hosts file
HOSTS_BAK="/etc/hosts_bak"

# Fetch the data
curl -s "$URL" > "$TMP_FILE"

# Append the fetched data to hosts_bak
# Here, I'm assuming that the old data in hosts_bak is delimited by a comment line like "# GitLab Hosts Start" and "# GitLab Hosts End".
# We first remove the old data and then append the new data.
sed -i '/# Git Hosts Update Start/,/# Git Hosts Update End/d' "$HOSTS_BAK"
echo "# Git Hosts Update Start" >> "$HOSTS_BAK"
cat "$TMP_FILE" >> "$HOSTS_BAK"
echo "# Git Hosts Update End" >> "$HOSTS_BAK"

# Replace /etc/hosts with hosts_bak
cp "$HOSTS_BAK" /etc/hosts

# Cleanup
rm "$TMP_FILE"

