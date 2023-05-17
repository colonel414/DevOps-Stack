#Add the Helm Chart Repository
{
    #Install helm
    helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
    helm fetch rancher-latest/rancher
    helm fetch rancher-stable/rancher --version=v2.4.8
}

#Choose your SSL Configuration
{

}

#Render the Rancher Helm Template
{
    #Option A: Default Self-Signed Certificate
    {
        #Add the cert-manager repo
        helm repo add jetstack https://charts.jetstack.io
        helm repo update

        #Fetch the cert-manager chart
        helm fetch jetstack/cert-manager --version v1.5.1

        #Render the cert-manager template
        helm template cert-manager ./cert-manager-v1.5.1.tgz --output-dir . \
            --namespace cert-manager \
            --set image.repository= \
            --set webhook.image.repository= \
            --set cainjector.image.repository= \
            --set startupapicheck.image.repository= <REGISTRY.YOURDOMAIN.COM:PORT >/quay.io/jetstack/cert-manager-controller \
            <REGISTRY.YOURDOMAIN.COM:PORT >/quay.io/jetstack/cert-manager-webhook \
            <REGISTRY.YOURDOMAIN.COM:PORT >/quay.io/jetstack/cert-manager-cainjector \
            <REGISTRY.YOURDOMAIN.COM:PORT >/quay.io/jetstack/cert-manager-ctl

        #Download the cert-manager CRD
        curl -L -o cert-manager/cert-manager-crd.yaml https://github.com/cert-manager/cert-manager/releases/download/v1.5.1/cert-manager.crds.yaml

        #Render the Rancher templateli
        helm template rancher ./rancher- --output-dir . \
            --no-hooks \ # prevent files for Helm hooks from being generated <VERSION >.tgz

        --namespace cattle-system \
            --set hostname= \
            certmanager.version= \
            rancherImage= \
            --set systemDefaultRegistry= Set a default private registry to be used in Rancher <RANCHER.YOURDOMAIN.COM > \
            --set <CERTMANAGER_VERSION > \
            --set <REGISTRY.YOURDOMAIN.COM:PORT >/rancher/rancher \
            <REGISTRY.YOURDOMAIN.COM:PORT >\ #
        --set useBundledSystemChart=true # Use the packaged Rancher system charts
    }
    #Option B: Certificates From Files using Kubernetes Secrets
    {
        #Create secrets

        #Render the Rancher template
        helm template rancher ./rancher-<VERSION>.tgz --output-dir . \
    --no-hooks \ # prevent files for Helm hooks from being generated
    --namespace cattle-system \
    --set hostname=<RANCHER.YOURDOMAIN.COM> \
    --set rancherImage=<REGISTRY.YOURDOMAIN.COM:PORT>/rancher/rancher \
    --set ingress.tls.source=secret \
    --set privateCA=true \ #If you are using a Private CA signed cert, add --set privateCA=true
    --set systemDefaultRegistry=<REGISTRY.YOURDOMAIN.COM:PORT> \ # Set a default private registry to be used in Rancher
    --set useBundledSystemChart=true # Use the packaged Rancher system charts
    }
}

#Install Rancher
{
    kubectl create namespace cattle-system
    kubectl -n cattle-system apply -R -f ./rancher
}
