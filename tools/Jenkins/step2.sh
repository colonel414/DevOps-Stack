# Create a Deployment file named 'deployment.yaml' and Create the deployment using kubectl

{
    kubectl apply -f deployment.yaml
    kubectl get deployments -n devops-tools
    kubectl describe deployments --namespace=devops-tools
}