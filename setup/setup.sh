set -e

setup_passwords()
{
    echo "====== Setting up Default User Passwords ======"
    echo "==============================================="
    
    bin/elasticsearch-setup-passwords auto -u "https://0.0.0.0:9200" -v --batch >> kEy

    echo "=================== DONE!!! ==================="
    echo "==============================================="
}

reset_passwords()
{
    echo "====== Resetting Default User Passwords ======"
    echo "=============================================="

    bin/elasticsearch-reset-password --batch --user elastic  > kEy
    bin/elasticsearch-reset-password --batch --user kibana_system  >>kEy 
    bin/elasticsearch-reset-password --batch --user logstash_system  >>kEy 

    echo "=================== DONE!!! ==================="
    echo "==============================================="
}

generate_ca(){
    echo "================ Generating CA ================"
    echo "==============================================="
    cd $ELASTIC_DIR
    bin/elasticsearch-certutil ca --pem --out /tmp/certs/elk-ca.zip
    cd /tmp/certs
    unzip elk-ca.zip

    echo "=================== DONE!!! ==================="
    echo "==============================================="
}

generate_cert(){
    echo "==============  Generating CERTS ============== "
    echo "==============================================="
    cd $ELASTIC_DIR
    bin/elasticsearch-certutil cert --ca-cert /tmp/certs/ca/ca.crt --ca-key /tmp/certs/ca/ca.key --pem --in ./config/instances.yml --out  /tmp/certs/certs.zip 
    cd /tmp/certs
    unzip certs.zip

    echo "=================== DONE!!! ==================="
    echo "==============================================="
}

elastic_cert_cp(){
    echo "======= Configuring Elasticsearch CERTS ======="
    echo "==============================================="
    
    cd $ELASTIC_DIR
    mkdir config/certs
    cp /tmp/certs/ca/ca.crt /tmp/certs/elasticsearch/* config/certs

    echo "=================== DONE!!! ==================="
    echo "==============================================="
}

kibana_cert_cp(){
    echo "========== Configuring Kibana CERTS ==========="
    echo "==============================================="
    
    cd $KIBANA_DIR
    mkdir config/certs
    cp /tmp/certs/ca/ca.crt /tmp/certs/kibana/* config/certs

    echo "=================== DONE!!! ==================="
    echo "==============================================="
}

logstash_cert_cp(){
    echo "=========  Configuring Logstash CERTS ========="
    echo "==============================================="
    
    cd $LOGSTASH_DIR
    mkdir config/certs
    cp /tmp/certs/ca/ca.crt /tmp/certs/logstash/* config/certs

    echo "=================== DONE!!! ==================="
    echo "==============================================="
}

# echo"=============== Welcome ELK CLI ==============="
# echo"==============================================="
# function="Set_Passwords Reset_Passwords Generate_CA Generate_Certs Copy_Elastic_Certs Copy_Kibana_Certs Copy_Logstash_Certs"
# select option in $function; do
#     echo $option
# done