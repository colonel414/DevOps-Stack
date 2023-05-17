{
    helm repo add hashicorp https://helm.releases.hashicorp.com
    helm search repo hashicorp/consul
}

# Custom install
{
    helm install consul hashicorp/consul --create-namespace --namespace consul --values consul/values.yaml
    # export VERSION=1.0.1
    # helm install consul hashicorp/consul --set global.name=consul --version ${VERSION} --create-namespace --namespace consul
}

{
    kubectl create ns [namespace]
    kubectl label namespace [namespace] connect-inject=enabled ##Label the namespaces where you would like to enable Consul Service Mesh
}
helm install consul hashicorp/consul --create-namespace --namespace consul --values consul/values.yml
watch kubectl get pods -n consul
helm upgrade consul hashicorp/consul --create-namespace --namespace consul --values consul/values.yml



# Install consul-k8s
{
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
    sudo yum -y install consul-k8s
    consul-k8s version
}

{
    consul-k8s install -set connectInject.enabled=true -set controller.enabled=true

    consul-k8s status
}
