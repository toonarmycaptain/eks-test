sudo apt update && sudo apt install
# install kubectl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update && sudo apt install && sudo apt install apt-transport-https ca-certificates curl kubectl bash-completion
# enable kubectl bash completion
echo 'source <(kubectl completion bash)' >>~/.bashrc
kubectl completion bash >/etc/bash_completion.d/kubectl

# install digital ocean api
sudo snap install doctl
sudo snap connect doctl:kube-config
sudo snap connect doctl:ssh-keys :ssh-keys
sudo snap connect doctl:dot-docker

# install helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt update
sudo apt install helm
# helm autocompletion
source <(helm completion bash)
helm completion bash > /etc/bash_completion.d/helm


# dl config file/auth for current cluster
mkdir ~/.config  # needed due too doctl not having permissions
doctl auth init # need access token

mkdir ~/.kube  # similarly need permissions


doctl kubernetes cluster kubeconfig save <DO cluster ID from dashboard>

git clone https://github.com/toonarmycaptain/kubernetes-test.git
cd kubernetes-test

helm install flask-app helm_charts/flask_app/

kubectl get services -w  # watch until external-ip has a value, and go observe running app

