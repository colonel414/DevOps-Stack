# https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-install
{
    sudo yum install -y yum-utils

    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

    sudo yum -y install vault  #=>vault-enterprise

    vault --help
}
