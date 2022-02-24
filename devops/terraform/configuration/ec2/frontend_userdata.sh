#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1


echo "sudo apt-get update"
sudo apt-get update -y 
sleep 10
echo "sudo apt install openjdk-8-jdk openjdk-8-jre -y"
sudo apt install openjdk-8-jdk openjdk-8-jre -y  
sleep 60
echo "updating /etc/environment"
cat >> /etc/environment <<EOL
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
EOL
#We need to add the repository key to the system
echo "wget --no-check-certificate -qO"
wget --no-check-certificate -qO - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
echo "echo deb https://pkg.jenkins.io/debian-stable binary/"
echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
echo "apt-get update"
sudo apt-get update
echo "apt-get install jenkins -y"
sudo apt-get install jenkins -y
echo "systemctl start jenkins"
sudo systemctl start jenkins
echo "apt-get install apt-transport-https wget gnupg"
apt-get install apt-transport-https wget gnupg
echo "apt-add-repository --yes ppa:ansible/ansible"
apt-add-repository --yes ppa:ansible/ansible   
echo "apt-get update"
apt-get update
echo "apt-get install ansible -y"
apt-get install ansible -y