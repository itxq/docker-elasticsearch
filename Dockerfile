ARG ELASTICSEARCH_VERSION
FROM elasticsearch:${ELASTICSEARCH_VERSION}
ARG ELASTICSEARCH_VERSION
ARG ANALYSIS_IK_URL=https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v${ELASTICSEARCH_VERSION}/elasticsearch-analysis-ik-${ELASTICSEARCH_VERSION}.zip
ENV ANALYSIS_IK_URL=${ANALYSIS_IK_URL}
RUN yes|/usr/share/elasticsearch/bin/elasticsearch-plugin install ${ANALYSIS_IK_URL}
RUN echo 'xpack.security.enabled: true' >> /usr/share/elasticsearch/config/elasticsearch.yml
RUN echo 'xpack.security.transport.ssl.enabled: false' >> /usr/share/elasticsearch/config/elasticsearch.yml