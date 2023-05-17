#Find the required assets for your Rancher version
{
    touch rancher-images.txt
    touch rancher-save-images.sh

    touch rancher-load-images.sh
}
#Collect the cert-manager image
{
    helm repo add jetstack https://charts.jetstack.io
    helm repo update
    helm fetch jetstack/cert-manager --version v1.5.1
    helm template ./cert-manager- <version >.tgz | awk '$1 ~ /image:/ {print $2}' | sed s/\"//g >>./rancher-images.txt

    sort -u rancher-images.txt -o rancher-images.txt
}

#Save the images to your workstation
{
    chmod +x rancher-save-images.sh

    ./rancher-save-images.sh --image-list ./rancher-images.txt
}

#Populate the private registry
{
    docker login harbor.ronforddigital.dev
    chmod +x rancher-load-images.sh
    ./rancher-load-images.sh --image-list ./rancher-images.txt --registry harbor.ronforddigital.dev
}
