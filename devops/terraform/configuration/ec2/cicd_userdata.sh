#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
JAVA_VERSION="11"
JENKINS_KEY="http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key"
JENKINS_PACKAGE="https://pkg.jenkins.io/debian-stable"
ANSIBLE_USER="ansible-admin"
DOCKER_DOWNLOAD="https://download.docker.com/linux/ubuntu"
apt-get update
sleep 60
# Installing JDK 
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Installing Java $JAVA_VERSION and setting Environment Variable >>>>>>>>>>>>>>>>>>>>>>"
apt install openjdk-$JAVA_VERSION-jdk openjdk-$JAVA_VERSION-jre maven -y
cat >> /etc/environment <<EOL
JAVA_HOME=/usr/lib/jvm/java-$JAVA_VERSION-openjdk-amd64
JRE_HOME=/usr/lib/jvm/java-$JAVA_VERSION-openjdk-amd64/jre
EOL

#Installing Jenkins
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Install Jenkins>>>>>>>>>>>>>>>>>>>>>>>>>"
wget --no-check-certificate -qO - $JENKINS_KEY |  apt-key add -
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FCEF32E745F2C3D5
echo deb $JENKINS_PACKAGE binary/ |  tee /etc/apt/sources.list.d/jenkins.list
apt-get update
apt-get install jenkins apt-transport-https wget gnupg -y
echo "<<<<<<<<<<<<<<<<<< start jenkins>>>>>>>>>>>>>>>>>>>>"
systemctl start jenkins
#Installing Ansible and configure ansible user
echo "<<<<<<<<<<< Install ansible >>>>>>>>>>>>>>>"
apt-add-repository --yes ppa:ansible/ansible
apt-get update
apt-get install ansible -y
adduser $ANSIBLE_USER
usermod -aG sudo $ANSIBLE_USER
mkdir /home/$ANSIBLE_USER/.ssh
touch /home/$ANSIBLE_USER/.ssh/id_rsa
chmod 400 /home/$ANSIBLE_USER/.ssh/id_rsa
chown -R $ANSIBLE_USER:$ANSIBLE_USER /home/$ANSIBLE_USER/.ssh
echo "$ANSIBLE_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
#Install Docker
echo "<<<<<<<<<<< Installing Docker >>>>>>>>>>>>>>>>"
curl -fsSL $DOCKER_DOWNLOAD/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] $DOCKER_DOWNLOAD \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install docker-ce docker-ce-cli containerd.io -y
usermod -a -G docker jenkins
usermod -a -G docker $ANSIBLE_USER
echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


