{
    helm upgrade --values consul/values.yml consul hashicorp/consul --namespace consul --version "1.0.1"
}