#!/bin/bash

set -eou pipefail

. ~/scripts/secrets

IPADDRNOW=$(curl https://api.ipify.org); \

STOREDIP=$(cat /tmp/ipaddrnow.txt);\

# You'll need to fill in your home folder for the ipaddrnow.txt file,
# your email address, your key, zone_ID, DNS_ID, and (domain) Name
 
if [ "$IPADDRNOW" != "$STOREDIP" ]; \
then
echo $IPADDRNOW > /tmp/ipaddrnow.txt; \
EMAIL="$CLOUDFLARE_EMAIL"; \
KEY="$CLOUDFLARE_API_KEY"; \
ZONE_ID="$CLOUDFLARE_ZONE_ID"; \
DNS_ID="$CLOUDFLARE_DNS_ID"; \
TYPE="A"; \
NAME="$CLOUDFLARE_DNS_NAME"; \
PROXIED="false"; \
TTL="1";\
curl -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$DNS_ID" \
-H "X-Auth-Email: $EMAIL" \
-H "X-Auth-Key: $KEY" \
-H "Content-Type: application/json" \
--data '{"type":"'"$TYPE"'","name":"'"$NAME"'","content":"'"$IPADDRNOW"'","proxied":'"$PROXIED"',"ttl":'"$TTL"'}' \
| python -m json.tool;
fi
