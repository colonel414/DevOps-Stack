#!/bin/bash

# Cloudflare API credentials
ZONE_ID="ZONE-ID"
API_KEY="API-KEY"
EMAIL="[email]"

# API endpoint for purging cache
ENDPOINT="https://api.cloudflare.com/client/v4/zones/$ZONE_ID/purge_cache"

# Purge everything
curl -X POST $ENDPOINT \
     -H "X-Auth-Email: $EMAIL" \
     -H "X-Auth-Key: $API_KEY" \
     -H "Content-Type: application/json" \
     --data '{"purge_everything":true}'
