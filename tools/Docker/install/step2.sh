#create the docker group and add your user
{
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker
}

#Configure Docker to start on boot
{
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
    #To disable
    sudo systemctl disable docker.service
    sudo systemctl disable containerd.service
}

[WARNING: Error loading config file: /home/user/.docker/config.json - 
stat /home/user/.docker/config.json: permission denied
]
{
    sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
    sudo chmod g+rwx "$HOME/.docker" -R
}
