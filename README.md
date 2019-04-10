# Debug Pod for Kubernetes

Quick and dirty image that can be used to debug Kubernetes clusters.

## Contents

* etcdctl versions: 2.3.8, 3.0.17, 3.1.8
* kubectl versions: 1.5.7, 1.6.4, 1.10.13, 1.11.8, 1.12.6, 1.13.4

## Usage

```
$ kubectl -n default run -ti --rm --restart=Never debug --image=jhansen/k8s-debug-pod:0.2.0 -- /bin/bash
bash-4.3# etcdctl-v3.1.8 --endpoint http://kcp-etcd:2379 member list
1512c61c595fdfe6: name=kcp-etcd-2 peerURLs=http://kcp-etcd-2.kcp-etcd:2380 clientURLs=http://kcp-etcd-2.kcp-etcd:2379 isLeader=true
503ae051423e6825: name=kcp-etcd-1 peerURLs=http://kcp-etcd-1.kcp-etcd:2380 clientURLs=http://kcp-etcd-1.kcp-etcd:2379 isLeader=false
c33944875fb30d39: name=kcp-etcd-0 peerURLs=http://kcp-etcd-0.kcp-etcd:2380 clientURLs=http://kcp-etcd-0.kcp-etcd:2379 isLeader=false
```

## Networking

### DNS

```console
kubectl -n default apply -f dns/debug-dns.yaml
```

Checks (kube/core)-dns, Azure internal DNS, and external DNS resolution for internal and external domains.

```console
kubectl -n default apply -f dns/sniff-dns.yaml
```

Launches a pod in the host namespace with `NET_ADMIN`, runs `tshark -f udp port 53` to catch all DNS requests leaving the host.

### Ebtables

```console
kubectl -n default apply -f network/debug-ebtables.yaml
```

Dumps `ebtables -t nat -L`, `ebtables -L`, `arp -na`, and the last 200 lines of `azure-cnimonitor.log` on a loop of `POD_SLEEP_SECS`.

To check the status of `azure-cni-networkmonitor` this debug pod also mounts `/var/log`:

```console
kubectl exec <debug-ebtables-pod> -it cat /var/log/azure-cnimonitor.log
```
