# etcd runs in a pod in kube-system namespace

# List all pods
kubectl get pods --all-namespaces

# Example list of pods
NAMESPACE     NAME                             READY   STATUS    RESTARTS   AGE
kube-system   coredns-66bff467f8-7bbm9         1/1     Running   0          17h
kube-system   coredns-66bff467f8-9kt7k         1/1     Running   0          17h
kube-system   etcd-ubuntu                      1/1     Running   0          17h
kube-system   kube-apiserver-ubuntu            1/1     Running   0          17h
kube-system   kube-controller-manager-ubuntu   1/1     Running   0          17h
kube-system   kube-proxy-j2v8r                 1/1     Running   0          17h
kube-system   kube-scheduler-ubuntu            1/1     Running   0          17h
kube-system   weave-net-9cf5p    


# etcd runs in a container using image k8s.gcr.io/etcd
# Find the container id of etcd container
docker ps | grep etcd

# Exec into etcd container
docker exec -it <etcd_container_id> /bin/sh

# Run commands using etcdctl

etcdctl --endpoints 127.0.0.1:2379 --cacert /etc/kubernetes/pki/etcd/ca.crt --cert /etc/kubernetes/pki/etcd/server.crt --key /etc/kubernetes/pki/etcd/server.key get / --prefix

etcdctl --endpoints 127.0.0.1:2379 --cacert /etc/kubernetes/pki/etcd/ca.crt --cert /etc/kubernetes/pki/etcd/server.crt --key /etc/kubernetes/pki/etcd/server.key get / --prefix --keys-only

# Set etcd command prefix for running etcdctl commands

export ETCD_CMD_PREFIX="etcdctl --endpoints 127.0.0.1:2379 --cacert /etc/kubernetes/pki/etcd/ca.crt --cert /etc/kubernetes/pki/etcd/server.crt --key /etc/kubernetes/pki/etcd/server.key"

# Run commands using etcdctl

$ETCD_CMD_PREFIX member list

$ETCD_CMD_PREFIX alarm list

$ETCD_CMD_PREFIX user list

$ETCD_CMD_PREFIX endpoint status

$ETCD_CMD_PREFIX check perf
