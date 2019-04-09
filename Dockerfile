FROM alpine

MAINTAINER Jason Hansen <jason@slack.io>

ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/slack/k8s-debug-pod" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile"

RUN apk add --update ca-certificates \
 && apk add bash curl netcat-openbsd bind-tools net-tools \
    openssl openssh iptables ebtables tcpdump tshark iproute2 \
 && rm /var/cache/apk/*

RUN \
 curl -L https://storage.googleapis.com/kubernetes-release/release/v1.6.4/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl-v1.6.4 \
 && chmod +x /usr/local/bin/kubectl-v1.6.4

RUN \
 curl -L https://storage.googleapis.com/kubernetes-release/release/v1.5.7/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl-v1.5.7 \
 && chmod +x /usr/local/bin/kubectl-v1.5.7

RUN \
 curl -L https://storage.googleapis.com/kubernetes-release/release/v1.10.13/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl-v1.10.13 \
 && chmod +x /usr/local/bin/kubectl-v1.10.13

RUN \
 curl -L https://storage.googleapis.com/kubernetes-release/release/v1.11.8/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl-v1.11.8 \
 && chmod +x /usr/local/bin/kubectl-v1.11.8

RUN \
 curl -L https://storage.googleapis.com/kubernetes-release/release/v1.12.6/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl-v1.12.6 \
 && chmod +x /usr/local/bin/kubectl-v1.12.6

RUN \
 curl -L https://storage.googleapis.com/kubernetes-release/release/v1.13.4/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl-v1.13.4 \
 && chmod +x /usr/local/bin/kubectl-v1.13.4

RUN \
 curl -L https://github.com/coreos/etcd/releases/download/v2.3.8/etcd-v2.3.8-linux-amd64.tar.gz -o /tmp/etcd-v2.3.8.tar.gz \
 && tar -C /tmp -xvzf /tmp/etcd-v2.3.8.tar.gz --strip-components=1 etcd-v2.3.8-linux-amd64/etcdctl && mv /tmp/etcdctl /usr/local/bin/etcdctl-v2.3.8 && rm /tmp/etcd-v2.3.8.tar.gz

RUN \
 curl -L https://github.com/coreos/etcd/releases/download/v3.0.17/etcd-v3.0.17-linux-amd64.tar.gz -o /tmp/etcd-v3.0.17.tar.gz \
 && tar -C /tmp -xvzf /tmp/etcd-v3.0.17.tar.gz --strip-components=1 etcd-v3.0.17-linux-amd64/etcdctl && mv /tmp/etcdctl /usr/local/bin/etcdctl-v3.0.17 && rm /tmp/etcd-v3.0.17.tar.gz

RUN \
 curl -L https://github.com/coreos/etcd/releases/download/v3.1.8/etcd-v3.1.8-linux-amd64.tar.gz -o /tmp/etcd-v3.1.8.tar.gz \
 && tar -C /tmp -xvzf /tmp/etcd-v3.1.8.tar.gz --strip-components=1 etcd-v3.1.8-linux-amd64/etcdctl && mv /tmp/etcdctl /usr/local/bin/etcdctl-v3.1.8 && rm /tmp/etcd-v3.1.8.tar.gz

RUN \
  ln -s /usr/local/bin/kubectl-v1.13.4 /usr/local/bin/kubectl; \
  ln -s /usr/local/bin/etcdctl-v3.1.8 /usr/local/bin/etcdctl
