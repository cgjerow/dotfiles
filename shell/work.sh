export GOOGLE_APPLICATION_CREDENTIALS=~/.config/gcloud/configurations/gcp-local.json
export ELASTICSEARCH_APIKEY=$(<~/.config/ugc-server/ELASTICSEARCH_DEV.key)

alias vpnreset='sudo killall vpnagentd && open -a "Cisco Secure Client"'

useEsDev() {
    export ELASTICSEARCH_APIKEY=$(<~/.config/ugc-server/ELASTICSEARCH_DEV.key)
}

useEsInt() {
    export ELASTICSEARCH_APIKEY=$(<~/.config/ugc-server/ELASTICSEARCH_INT.key)
}

lextest() {
    query=$1
    grpcurl -d "{ \"query\":  { \"key\": \"title\", \"s\": \"$1\" }, \"pageSize\": 2, \"searchStrategy\": \"LEXICAL\" }" -plaintext localhost:6565 com.ea.neotek.ugc.search.SearchService/ItemSearch
}
