#!/bin/bash

cat host-list.txt | parallel --lb \
   "echo {}; ansible-playbook -i {} books/initial.yml books/kube-dependencies.yml books/master.yml books/workers.yml > {}.log; echo finished {}"
