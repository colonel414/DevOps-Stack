{
    sudo apt install make -y
    sudo firewall-cmd --add-port={22/tcp,80/tcp} --permanent
    sudo firewall-cmd --reload
}

{
    sudo apt install build-essential
    git clone https://github.com/shellhub-io/shellhub.git
    cd shellhub
    echo "SHELLHUB_ENV=development" >>.env.override
    make keygen
    make start
    docker ps
}
