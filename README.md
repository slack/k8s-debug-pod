# Debug Pod for Kubernetes

Quick and dirty image that can be used to debug Kubernetes clusters.

## Contents

* etcdctl versions: 2.3.8, 3.0.17, 3.1.8
* kubectl versions: 1.5.7, 1.6.4, 1.10.7, 1.11.2

## Usage

```
$ kubectl -n kcp run -ti --rm --restart=Never debug --image=jhansen/k8s-debug-pod -- /bin/bash
bash-4.3# etcdctl-v3.1.8 --endpoint http://kcp-etcd:2379 member list
1512c61c595fdfe6: name=kcp-etcd-2 peerURLs=http://kcp-etcd-2.kcp-etcd:2380 clientURLs=http://kcp-etcd-2.kcp-etcd:2379 isLeader=true
503ae051423e6825: name=kcp-etcd-1 peerURLs=http://kcp-etcd-1.kcp-etcd:2380 clientURLs=http://kcp-etcd-1.kcp-etcd:2379 isLeader=false
c33944875fb30d39: name=kcp-etcd-0 peerURLs=http://kcp-etcd-0.kcp-etcd:2380 clientURLs=http://kcp-etcd-0.kcp-etcd:2379 isLeader=false
```
