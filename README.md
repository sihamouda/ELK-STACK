# ELK-STACK
This Readme file will help you to use properly my ELK-STACK project

# Initial setup

1.run the following command to start the project

```bash
docker compose up
```

2.now you need to reset passwords for elastic, kibana and logstash using the following commands 

```bash
docker compose exec elasticsearch bin/elasticsearch-reset-password --batch --user elastic
```

```bash
docker compose exec elasticsearch bin/elasticsearch-reset-password --batch --user kibana_system
```

```bash
docker compose exec elasticsearch bin/elasticsearch-reset-password --batch --user logstash_system
```
3.paste the result in the .env
