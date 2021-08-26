#install docker
#rahul -a for if 2 condiftion 

if [[ $(cat /etc/centos-release | grep -o "CentOS") ==  "CentOS" ]]
then
echo "this is centos installing docker"
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine -y > /dev/null 2>&1
sudo yum install -y yum-utils
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io -y

sudo systemctl start docker
sudo systemctl enable docker

sudo systemctl status docker

echo "latest docker is succesfully installed"

#elif [[ $(cat /etc/os-release | grep -io "ubuntu")  == "ubuntu" ]]

a=`cat /etc/os-release | grep -o "ubuntu" | uniq`
elif [[ $a -eq "ubuntu" ]]
then
echo "this is ubuntu now installing docker"
sudo apt-get remove docker docker-engine docker.io containerd runc -y
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
echo "latest docker is succesfully installed"

else
echo "this is not in centos or ubuntu please visit docker hub to install latest one"
fi

#selinux disable
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

#disable swap
swapoff -a
sed -i 's/\/swap/#\/swap.img/g' /etc/fstab

#disable firewall
systemctl stop firewalld
systemctl disable firewalld

#disable br netfilter module
modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables

#add k8 repo and install 
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

yum install kubeadm kubectl -y

systemctl enable kubelet
systemctl start kubelet
systemctl enable docker
systemctl start docker

#initialize k8 master
kubeadm init



cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system



# edit
/usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf

/etc/docker/daemon.json 

{
  "exec-opts": ["native.cgroupdriver=systemd"]
}