#install wget and curl tools
{
    # Debian / Ubuntu systems
    sudo apt update
    sudo apt install wget curl unzip
}

{
    # RHEL based systems
    sudo yum install curl wget unzip
    sudo yum install -y yum-utils
}

#https://github.com/hashicorp/terraform/releases
#Install Terraform on Linux
{
    TER_VER=$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | cut -d: -f2 | tr -d \"\,\v | awk '{$1=$1};1')
    wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip
}

#Extract and move terraform binary file to the /usr/local/bin directory
{
    unzip terraform_${TER_VER}_linux_amd64.zip
    sudo mv terraform /usr/local/bin/
    which terraform
    terraform --version
}

# Install Terraform on CentOS 8 / Rocky Linux 8
{
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
    sudo dnf repolist
    sudo yum -y install terraform

    yum --showduplicate list terraform
    sudo dnf install terraform-1.0.2-1.x86_64

    terraform  version
}
