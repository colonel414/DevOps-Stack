#!/bin/bash

# Prerequisites
kubectl version --short

# Step 1: Install Linkerd
curl https://run.linkerd.io/install | sh

export PATH=$PATH:$HOME/.linkerd2/bin

# Step 2: Validate your Kubernetes cluster
linkerd version

linkerd check --pre

# Step 3: Create a Linkerd profile
linkerd profile create linkerd

# Step 4: Deploy Linkerd to the cluster
linkerd install --crds | kubectl apply -f -

linkerd install --set proxyInit.runAsRoot=true | kubectl apply -f -



# Step 5: Inject Linkerd proxies into the application
# linkerd inject my-app.yml > my-app-with-linkerd.yml
# kubectl apply -f my-app-with-linkerd.yml

# Step 6: Verify the deployment
linkerd check

# Step 7: Start using Linkerd
echo "Linkerd is now installed and ready to use!"


linkerd viz install  --set prometheus.enabled=false --set grafana.enabled=false --set prometheusUrl=http://192.169.186.58:9090 --set grafana.externalUrl=http://192.169.11.226:80 --set dashboard.enforcedHostRegexp=".*" > /home/ronfordlb/tools/linkerd/linkerd-viz.yml

linkerd viz dashboard &


linkerd uninstall | kubectl delete -f -