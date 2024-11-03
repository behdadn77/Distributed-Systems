#!/bin/bash

# Create directories for each chapter
mkdir -p "Modeling"
mkdir -p "Communication"
mkdir -p "Naming"
mkdir -p "Consistency_and_Replication"
mkdir -p "Synchronization"
mkdir -p "Peer_to_Peer"
mkdir -p "Fault_Tolerance"
mkdir -p "Big_Data"

# Move .md files to corresponding chapter directories
# Ignoring the readme.md file
for file in *.md; do
  if [[ "$file" == "readme.md" ]]; then
    continue
  fi

  case "$file" in
    # Files related to Communication
    *Message_Queuing* | *Communication*)
      mv "$file" "Communication/"
      ;;
    # Files related to Naming
    *Flat_Naming* | *Remove_Unreferenced* | *Mobile_Code* | *Structured_Naming*)
      mv "$file" "Naming/"
      ;;
    # Files related to Consistency and Replication
    *Consistency* | *Replication*)
      mv "$file" "Consistency_and_Replication/"
      ;;
    # Files related to Synchronization
    *Clock_Synchronization* | *Scalar_Clocks*)
      mv "$file" "Synchronization/"
      ;;
    # Files related to Peer to Peer
    *Peer_to_Peer* | *DHT*)
      mv "$file" "Peer_to_Peer/"
      ;;
    # Files related to Fault Tolerance
    *Failures* | *Fault_Tolerance*)
      mv "$file" "Fault_Tolerance/"
      ;;
    # Files related to Big Data
    *Big_Data*)
      mv "$file" "Big_Data/"
      ;;
    # Files related to Modeling
    *Modeling*)
      mv "$file" "Modeling/"
      ;;
    # Default case for files that don't match any pattern
    *)
      echo "File '$file' does not match any chapter category."
      ;;
  esac
done
