#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

PYTHON_VERSION="2.7"
ANSIBLE_USER="ansible-admin"
DOCKER_DOWNLOAD="https://download.docker.com/linux/ubuntu"
ANSIBLE_USER_PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDacP0i3DufOinMQJCz42YlL5duYrHFetImZEtmwwRXGqrOctAJBfCah8itUjsyYHdQlV/1DEIVknY/tNg5tV4sqTL0v7CUuWezfIffpeyEdmfac5fLmpMqAjc/KghscBEbRL815WdXvVpVGWF59rm5Y21HZul1fkhab7BIZDmBdlVqihypeoTfoh4jyio59dtHbGDYGPbPpeSSEAg+52aECpTzWg+kFSPqdB1MxfwRJg1Xb+PGncgSaC5cVrC4pU3xOq0SYwEGKGLLGuyqbakX50w+gVPYpjqnNM/ANHL8OgMS/gnJpUG19QG7ei/hQRkYQFfvkX3issYCWg+AMK7ceB0+dZRKNOAWbneXnh1IzcXPS8QlIH6CvRvp+wDUWS2yJM8FCj7gElEEBNvcKjQ0ke0TQWtySjWxraEfvQLjzmzByfC255j8JqoJzju8BZp+czlzt6d0WaYF03Kujhr51XbhMdaYX7JUN6iOZkQ0PlA6HzY6jOzyDeSBxc0HqPUOvscKezRMC9ze+wWI4PXtDJ9p80GmyMV1Mzr6iUcgDMFBYI8HDvBg0p5bGn7GoTMW/IVeY/fjA/sC3WiszI0wULfQRBePOk/8oYvnPC3qaMm74h1qwGnaCnKUAEUpler26CkHEe5TmEszMmUQnPf4irXdjag655ndP8k2hIe3DQ=="
apt-get update
sleep 60
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>> install python and create ansible user>>>>>>"

apt install python$PYTHON_VERSION python-pip python-docker -y
adduser $ANSIBLE_USER
usermod -aG sudo $ANSIBLE_USER
echo "$ANSIBLE_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
echo "<<<<<<<<<<< Installing Docker >>>>>>>>>>>>>>>>"
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>> install docker >>>>>>"
curl -fsSL $DOCKER_DOWNLOAD/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] $DOCKER_DOWNLOAD \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install docker-ce docker-ce-cli containerd.io -y
usermod -a -G docker $ANSIBLE_USER
mkdir /home/$ANSIBLE_USER/.ssh
echo -e "$ANSIBLE_USER_PUBLIC_KEY" > /home/$ANSIBLE_USER/.ssh/authorized_keys
chown -R $ANSIBLE_USER:$ANSIBLE_USER /home/$ANSIBLE_USER/.ssh