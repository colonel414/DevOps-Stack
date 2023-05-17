# https://phoenixnap.com/kb/kubernetes-kind
#!/bin/bash

# 1. Create a cluster:

kind create cluster

# 2. Use a custom name for the cluster:

kind create cluster --name=[cluster-name]

# 3. Create a cluster with a custom node image:

kind create cluster --image=[image]

# 4. Use a custom configuration for the cluster:

kind create cluster --config=[config-yaml]

# 5. When creating a cluster, assign a waiting time for the control plane to go up:

kind create cluster --wait [time-interval]

# 6. View the list of the running clusters:

kind get clusters

# 7. View information about a cluster:

kubectl cluster-info --context kind-[cluster-name]

# 8. Load a Docker image into a cluster:

kind load docker-image [docker-image-name]

# 9. Load an image archive into a cluster:

kind load image-archive [tar-archive-location]

# 10. Export logs:

kind export logs

# 11. Delete a cluster:

kind delete cluster --name [cluster-name]