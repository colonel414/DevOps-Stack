# Accessing Jenkins Using Kubernetes Service
# Create 'service.yaml' and Create the Jenkins service using kubectl
{
    kubectl apply -f service.yaml
    http://<node-ip>:32000
}

# get the Jenkins initial Admin password from the pod logs either from the Kubernetes dashboard or CLI
{
    kubectl get pods --namespace=devops-tools
    kubectl logs jenkins-deployment-2539456353-j00w5 --namespace=devops-tools
    ---
    kubectl exec -it jenkins-559d8cd85c-cfcgk cat /var/jenkins_home/secrets/initialAdminPassword -n devops-tools
}

