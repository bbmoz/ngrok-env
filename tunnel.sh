#!/bin/bash

set -ex
set -o pipefail

# start tunnel
killall ngrok || true
ngrok start app -config ${TUNNEL_DIR}/tunnel.yml &
while ! curl -s ${TUNNEL_API_URL}; do sleep 1; done

# save forwarding address
WEB_TUNNEL_URL=$(curl -s ${TUNNEL_API_URL}/app | jq '.public_url' | tr -d '"')
echo "export WEB_TUNNEL_URL=${WEB_TUNNEL_URL}" > ${TUNNEL_DIR}/tunnel.env
