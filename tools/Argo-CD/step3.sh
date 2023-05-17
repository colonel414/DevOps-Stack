#Access the ArgoCD API server through loadbalancer
{
    kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
    kubectl port-forward svc/argocd-server -n argocd 8080:443
}

#Accessing API through ingress
{
    kubectl apply -f ./https-ingress.yml
}

#Access API with port-forwarding
{
    kubectl port-forward svc/argocd-server -n argocd 8080:443
}

#Register A Cluster To Deploy To
{
    kubectl config get-contexts -o name
    argocd cluster add [cluster-name]
}