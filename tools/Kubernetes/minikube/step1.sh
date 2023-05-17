{
    sudo apt update
    sudo apt install apt-transport-https
    sudo apt upgrade

    [ -f /var/run/reboot-required ] && sudo reboot -f
}
