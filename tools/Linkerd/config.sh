# Meshing a service with annotations
# Meshing a Kubernetes resource is typically done by annotating the resource (or its namespace) with the linkerd.io/inject: enabled Kubernetes annotation
{
    cat deployment.yml | linkerd inject - | kubectl apply -f -

    kubectl get -n NAMESPACE deploy -o yaml | linkerd inject - | kubectl apply -f -

    kubectl get -n NAMESPACE deploy -o yaml | linkerd uninject - | kubectl apply -f -

    kubectl get -n NAMESPACE daemonset -o yaml | linkerd inject - | kubectl apply -f -

    kubectl get -n NAMESPACE deploy -o yaml | linkerd inject - | kubectl apply -f -

    kubectl get -n NAMESPACE replicaset -o yaml | linkerd inject - | kubectl apply -f -

    kubectl get -n NAMESPACE replicaset -o yaml | linkerd uninject - | kubectl apply -f -

    kubectl get -n NAMESPACE statefulset -o yaml | linkerd inject - | kubectl apply -f -

    kubectl get -n NAMESPACE statefulset -o yaml | linkerd uninject - | kubectl apply -f -


    # Verifying the data plane pods have been injected
    kubectl -n NAMESPACE get pod -o jsonpath='{.items[0].spec.containers[*].name}'

    # Handling MySQL, SMTP, and other non-HTTP protocols
    - To bypass the proxy altogether you can use the annotation 'config.linkerd.io/skip-outbound-ports'  
    - To configure Linkerd to look for ServiceProfiles for off-cluster connections add the annotation 'config.linkerd.io/enable-external-profiles' #This annotation should be set on the source of the traffic.
    - Using NetworkPolicy resources with opaque ports('When a service has a port marked as "opaque" in a Kubernetes cluster, any network policies that restrict access to that service must be changed to target the Linkerd proxy inbound port (4143 by default) instead of the original service port. This is because traffic targeting the opaque endpoint is redirected to the Linkerd proxy, which then transparently forwards it to the main application container over a TCP connection.')
}