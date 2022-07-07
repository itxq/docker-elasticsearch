# Elasticsearch镜像（安装IK分词器）

### 部署示例

> docker-compose.yml 

```yaml
version: '3.3'

services:

  # elasticsearch
  elasticsearch:
    env_file:
      - .env
    image: itxq/elasticsearch:8.2.3
    restart: always
    ports:
      - ${ES_SERVER_PORT}:9200
    environment:
      - discovery.type=single-node
      - xpack.security.enabled=true
      - xpack.security.transport.ssl.enabled=false
      - FORMAT_MESSAGES_PATTERN_DISABLE_LOOKUPS=true
      - "ES_JAVA_OPTS=${ES_JAVA_OPTS}"
      - "TAKE_FILE_OWNERSHIP=true"
    volumes:
      - ./storage/data/elasticsearch:/usr/share/elasticsearch/data:rw
    privileged: true
    network_mode: bridge

  # kibana
  kibana:
    env_file:
      - .env
    image: kibana:8.2.3
    restart: always
    ports:
      - ${KIBANA_SERVER_PORT}:5601
    depends_on:
      - elasticsearch
    links:
      - elasticsearch
    environment:
      ELASTICSEARCH_HOSTS: ${KIBANA_ELASTICSEARCH_HOSTS}
      ELASTICSEARCH_USERNAME: ${KIBANA_ELASTICSEARCH_USERNAME}
      ELASTICSEARCH_PASSWORD: ${KIBANA_ELASTICSEARCH_PASSWORD}
      SERVER_PUBLICBASEURL: ${KIBANA_SERVER_PUBLICBASEURL}
      I18N_LOCALE: "zh-CN"
    privileged: true
    network_mode: bridge
```

> .env

```env
ES_SERVER_PORT=9200
ES_JAVA_OPTS=-Xms256m -Xmx1024m

KIBANA_SERVER_PORT=5601
KIBANA_ELASTICSEARCH_HOSTS=http://elasticsearch:9200
KIBANA_ELASTICSEARCH_USERNAME=kibana_system
KIBANA_ELASTICSEARCH_PASSWORD=kibana_system_password
KIBANA_SERVER_PUBLICBASEURL=http://localhost:5601
```

### 设置密码

```shell
# 自由设置密码
/usr/share/elasticsearch/bin/elasticsearch-setup-passwords interactive

# 自动生成密码
/usr/share/elasticsearch/bin/elasticsearch-setup-passwords auto
```