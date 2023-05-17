# https://www.jenkins.io/doc/book/installing/kubernetes/
# https://devopscube.com/setup-jenkins-on-kubernetes-cluster/
{
    kubectl create namespace devops-tools
    kubectl apply -f serviceAccount.yaml
    kubectl create -f volume.yaml # Replace 'worker-node01' with any one of your cluster worker nodes hostname.
}

# Install Jenkins with Helm
{
    helm repo add jenkinsci https://charts.jenkins.io
    helm repo update
    helm search repo jenkinsci
}

{
    kubectl apply -f https://raw.githubusercontent.com/installing-jenkins-on-kubernetes/jenkins-volume.yaml
    kubectl apply -f https://raw.githubusercontent.com/installing-jenkins-on-kubernetes/jenkins-sa.yaml
}

{
    # Open the values.yaml file and modify it
    curl -O https://raw.githubusercontent.com/jenkinsci/helm-charts/main/charts/jenkins/values.yaml -o values.yaml
}

{
    $ chart=jenkinsci/jenkins
    $ helm install jenkins -n jenkins -f jenkins-values.yaml $chart
}

# Password
{
    $ jsonpath="{.data.jenkins-admin-password}"
$ secret=$(kubectl get secret -n jenkins jenkins -o jsonpath=$jsonpath)
$ echo $(echo $secret | base64 --decode)
}

# URL
{
    $ jsonpath="{.spec.ports[0].nodePort}"
$ NODE_PORT=$(kubectl get -n jenkins -o jsonpath=$jsonpath services jenkins)
$ jsonpath="{.items[0].status.addresses[0].address}"
$ NODE_IP=$(kubectl get nodes -n jenkins -o jsonpath=$jsonpath)
$ echo http://$NODE_IP:$NODE_PORT/login
}
