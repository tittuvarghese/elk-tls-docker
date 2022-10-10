KIBANA_SERVICE_TOKEN=`../bin/elasticsearch-service-tokens create elastic/kibana kibana-system-token`
echo "Service Token"
echo $KIBANA_SERVICE_TOKEN
PARSED_TOKEN=(${KIBANA_SERVICE_TOKEN// = / })
echo ${PARSED_TOKEN[2]}
echo 'ELASTIC_SERVICE_ACCOUNT_TOKEN='${PARSED_TOKEN[2]} >> /usr/share/elasticsearch/utils/.env