#!/bin/bash

rm -rf *.txt && terraform apply

for c in master-ips worker1-ips worker2-ips
do
    terraform output -json $c | jq '.[0] | @tsv' \
        | sed 's/[\t][\t]*/\\n/g' \
        | xargs printf > "$c.txt"
done