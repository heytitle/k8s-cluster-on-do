# K8S Cluster on Digital Ocean

## Steps
1. Create Droplets using Terraform
```
# Assume all variables in terraform.tfvars are set.
$ ./scripts/tf-apply.sh
```

2. Prepare Ansible inventory for each cluster
```
$ rm -rf hostfile-dir/* && python scripts/create-host-files.py
```

3. Setup clusters
```
$ scripts/setup-cluster.sh
```

3.1 Configure local kubectl
```
scp -r ubuntu@<master_ip>:~/.kube ~/
```

4. Destroy clusters
```
$ terraform destroy
```