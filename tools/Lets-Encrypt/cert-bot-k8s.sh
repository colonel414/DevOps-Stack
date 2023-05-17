#!/bin/bash

# Set the domain name and email address for certbot
DOMAINS=("*.ronford.dev" "ronford.dev" "123.ronford.dev")
EMAIL_ADDRESS=cornelius.wafula@ronforddigital.com

# Deploy the certbot container
echo "Deploying the certbot container..."
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: certbot
spec:
  replicas: 1
  selector:
    matchLabels:
      app: certbot
  template:
    metadata:
      labels:
        app: certbot
    spec:
      containers:
        - name: certbot
          image: certbot/certbot
          command: ["certbot"]
EOF

# Run the certbot job to generate SSL certificates
echo "Generating SSL certificates using certbot..."
kubectl apply -f - <<EOF
apiVersion: batch/v1
kind: Job
metadata:
  name: certbot-job
spec:
  template:
    spec:
      containers:
        - name: certbot
          image: certbot/certbot
          command:
            - "certbot"
            - "certonly"
            - "--email"
            - "${EMAIL_ADDRESS}"
            - "--agree-tos"
            - "--no-eff-email"
            - "--manual"
            - "--preferred-challenges"
            - "dns"
            - "-d"
            - "${DOMAIN_NAME}"
      restartPolicy: Never
  backoffLimit: 0
EOF

# Wait for the certbot job to complete
echo "Waiting for the certbot job to complete..."
kubectl wait --for=condition=complete --timeout=30s job/certbot-job

# Store the generated SSL certificates in a Kubernetes secret
echo "Storing the generated SSL certificates in a secret..."
kubectl create secret tls certbot-secret --cert=/etc/letsencrypt/live/${DOMAIN_NAME}/fullchain.pem --key=/etc/letsencrypt/live/${DOMAIN_NAME}/privkey.pem

# Use the certificates in your application
echo "Using the SSL certificates in your application..."
# Update your application deployment to reference the secret containing the SSL certificates

echo "Done!"
