
files = ('master-ips.txt', 'worker1-ips.txt', 'worker2-ips.txt')

all_ips = []

for f in files:
    with open("./%s" % f, "r") as fh:
        all_ips.append(list(map(lambda x: x.strip(), fh.readlines())))


template = """
[masters]
master ansible_host={master_ip} ansible_user=root

[workers]
worker1 ansible_host={worker1_ip} ansible_user=root
worker2 ansible_host={worker2_ip} ansible_user=root

[all:vars]
ansible_python_interpreter=/usr/bin/python3
"""


with open("host-list.txt", "w") as fw:
    for i in range(len(all_ips[0])):
        hostfile = template.format(
            master_ip=all_ips[0][i],
            worker1_ip=all_ips[1][i],
            worker2_ip=all_ips[2][i],
        )

        path = "./hostfile-dir/cluster-%d" % (i+1)

        with open(path, "w") as  f:
            f.write(hostfile)

        fw.write(path + "\n")
    