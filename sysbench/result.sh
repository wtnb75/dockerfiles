#! /bin/sh

awk '/Number of threads/{th=$(NF);}/events\/s/{eps=$(NF);}/95th/{pct95=$(NF);print th, eps, pct95;}' $* | sort -n
