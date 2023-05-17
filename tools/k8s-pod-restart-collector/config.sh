helm upgrade --install k8s-pod-restart-info-collector ./helm \
   --set slackWebhookUrl="slackWebhookUrl" \
   --set clusterName="cluster-name" \
   --set slackChannel="infra-alerts-channel"