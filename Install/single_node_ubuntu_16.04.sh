# Install Kubernetes

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet kubeadm kubectl kubernetes-cni

# Install Docker

apt-get update && apt-get install -y apt-transport-https
apt-get install -y docker.io

# Disable swap

swapoff -a

# Initialize kubeadm and configure Kubernetes

kubeadm init
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=/etc/kubernetes/admin.conf
sysctl net.bridge.bridge-nf-call-iptables=1
export kubever=$(kubectl version | base64 | tr -d '\n')
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$kubever"


# Run taint command to allow Kubernetes create pods on master node

kubectl taint nodes --all node-role.kubernetes.io/master-


# Verify Kubernetes installation

kubectl get nodes
kubectl get pods --all-namespaces
docker images
docker ps
