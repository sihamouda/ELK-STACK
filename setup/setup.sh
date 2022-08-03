set -e

setup_passwords()
{
    printf "######## Setting up Default User Passwords ########\n"
    printf "##################################################\n"
    
    bin/elasticsearch-setup-passwords auto -u "https://0.0.0.0:9200" -v --batch >> kEy

    printf "##################### DONE!!! #####################\n"
    printf "##################################################\n"
}

reset_passwords()
{
    printf "######## Resetting Default User Passwords ########\n"
    printf "##################################################\n"

    bin/elasticsearch-reset-password --batch --user elastic  > kEy
    bin/elasticsearch-reset-password --batch --user kibana_system  >>kEy 
    bin/elasticsearch-reset-password --batch --user logstash_system  >>kEy 

    printf "##################### DONE!!! #####################\n"
    printf "##################################################\n"
}

generate_ca(){
    printf "################## Generating CA ##################\n"
    printf "##################################################\n"
    cd $ELASTIC_DIR
    bin/elasticsearch-certutil ca --pem --out /tmp/certs/elk-ca.zip
    cd /tmp/certs
    unzip elk-ca.zip

    printf "##################### DONE!!! #####################\n"
    printf "##################################################\n"
}

generate_cert(){
    printf "################ Generating CERTS ################\n"
    printf "##################################################\n"
    cd $ELASTIC_DIR
    bin/elasticsearch-certutil cert --ca-cert /tmp/certs/ca/ca.crt --ca-key /tmp/certs/ca/ca.key --pem --in ./config/instances.yml --out  /tmp/certs/certs.zip 
    cd /tmp/certs
    unzip certs.zip

    printf "##################### DONE!!! #####################\n"
    printf "##################################################\n"
}

elastic_cert_cp(){
    printf "######### Configuring Elasticsearch CERTS #########\n"
    printf "##################################################\n"
    
    cd $ELASTIC_DIR
    mkdir config/certs
    cp /tmp/certs/ca/ca.crt /tmp/certs/elasticsearch/* config/certs

    printf "##################### DONE!!! #####################\n"
    printf "##################################################\n"
}

kibana_cert_cp(){
    printf "############ Configuring Kibana CERTS #############\n"
    printf "##################################################\n"
    
    cd $KIBANA_DIR
    mkdir config/certs
    cp /tmp/certs/ca/ca.crt /tmp/certs/kibana/* config/certs

    printf "##################### DONE!!! #####################\n"
    printf "##################################################\n"
}

logstash_cert_cp(){
    printf "########### Configuring Logstash CERTS ###########\n"
    printf "##################################################\n"
    
    cd $LOGSTASH_DIR
    mkdir config/certs
    cp /tmp/certs/ca/ca.crt /tmp/certs/logstash/* config/certs

    printf "##################### DONE!!! #####################\n"
    printf "##################################################\n"
}


logstash_cert_cp
