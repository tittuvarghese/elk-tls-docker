## SYSCTL Setip
sysctl -w vm.max_map_count=262144

# Step 1 - Generation of Certificates
docker compose -f docker-compose.setup.yml run --rm certs
sleep 5 # Sleep 5 Second 

# Step 2 - Extraction of Cetificates
sleep 5 # Sleep 5 Second 

# Step 3 - Starting Elastic Search
docker compose -f docker-compose.production.yml up -d elasticsearch1.elasticsearch
docker compose -f docker-compose.production.yml up -d  elasticsearch2.elasticsearch
docker compose -f docker-compose.production.yml up -d  elasticsearch3.elasticsearch
sleep 25 # Sleep 5 Second 

###########################################
# Step 4 - Creation of Kibana System Token
KIBANA_SERVICE_TOKEN=`docker exec elasticsearch1.elasticsearch /bin/sh -- bin/elasticsearch-service-tokens create elastic/kibana kibana-system-token`
echo "Kibana Service Token"
echo $KIBANA_SERVICE_TOKEN
PARSED_TOKEN=(${KIBANA_SERVICE_TOKEN//=/ })
export ELASTIC_SERVICE_ACCOUNT_TOKEN=${PARSED_TOKEN[2]}
sed -i '/ELASTIC_SERVICE_ACCOUNT_TOKEN/d' .env
sleep 2
echo 'ELASTIC_SERVICE_ACCOUNT_TOKEN='${PARSED_TOKEN[2]} >> .env

# bin/elasticsearch-reset-password -u kibana_system -a -s -b --url "https://0.0.0.0:9200"

###########################################

# Step 5 - Starting Kibana
docker compose -f docker-compose.production.yml up -d kibana
