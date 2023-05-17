#Generate a Key Pair
{
    ssh-keygen
}
#Copy the Public Key:
    #Option 1: Use ssh-copy-id
    {
        ssh-copy-id demo@SERVER_IP_ADDRESS
    }
    #Option 2: Manually Install the Key
    {
        cat ~/.ssh/id_rsa.pub
        su - demo
        mkdir .ssh
        chmod 700 .ssh
        nano .ssh/authorized_keys #Enter your public key (which should be in your clipboard) by pasting it into the editor. Now hit ctrl + X to exit and Y then enter to save and exit
        chmod 600 .ssh/authorized_keys
        exit
    }
#Configure SSH Daemon
{
    nano /etc/ssh/sshd_config
    systemctl reload sshd
}