# K8S Cluster on Digital Ocean

## Steps
1. Create Droplets using Terraform
```
$ TF_VAR_do_token=<TOKEN> TF_VAR_no_clusters=<NO_CLUSTER> ./scripts/tf-apply.sh
```

2. Prepare Ansible inventory for each cluster
```
$ rm -rf hostfile-dir/* && python scripts/create-host-files.py
```

3. Setup clusters
```
$ scripts/setup-cluster.sh
```

4. Destroy clusters
```
$ terraform destroy
```