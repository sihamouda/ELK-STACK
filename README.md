# ELK-STACK
This Readme file will help you to use properly my ELK-STACK project

# Getting Started

To start the project, run the following command 

```bash
docker compose up
```
You will notice that ELK is not secured 

## Minimal Security for ELK

To enable minimal security features, take a look on elasticsearch.yml kibana.yml and logstash.yml and restart the project

* Run the following command to automatically generate passwords for built in users (**read the next option before executing**)

    ```bash
    docker compose exec -it elasticsearch bash bin/elasticsearch-setup-passwords auto -v --batch
    ```

* If you want to chose the passwords for built in users, run the following command

    ```bash
    docker compose exec -it elasticsearch bash bin/elasticsearch-setup-passwords interactive
    ```

* If you need to reset passwords for elastic, kibana and logstash, use the following commands 

    ```bash
    docker compose exec elasticsearch bin/elasticsearch-reset-password --batch --user elastic
    ```

    ```bash
    docker compose exec elasticsearch bin/elasticsearch-reset-password --batch --user kibana_system
    ```

    ```bash
    docker compose exec elasticsearch bin/elasticsearch-reset-password --batch --user logstash_system
    ```
    **Don't forget to paste the result in the .env**

## Minimal Security for ELK + HTTPS

To get a higher level of security, you need to activate the **HTTPS** on ELK

1. Generate a **CA** certificate using this command (**optional**)

2. Generate Certification using the **CA** certificate

3. Copy certifactes to the **config** directory

4. Take a look on elasticsearch.yml kibana.yml and logstash.yml and restart the project

    **CHECK SETUP.SH**

# Coming Features

1. Interactive cli to make for faster setup

2. Beats