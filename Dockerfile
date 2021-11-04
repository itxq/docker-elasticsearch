FROM elasticsearch:7.14.2
ARG ANALYSIS_IK_URL=https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.14.2/elasticsearch-analysis-ik-7.14.2.zip
ENV ANALYSIS_IK_URL=${ANALYSIS_IK_URL}
RUN yes|/usr/share/elasticsearch/bin/elasticsearch-plugin install ${ANALYSIS_IK_URL}
RUN echo 'xpack.security.enabled: true' >> /usr/share/elasticsearch/config/elasticsearch.yml
RUN echo 'xpack.security.transport.ssl.enabled: true' >> /usr/share/elasticsearch/config/elasticsearch.yml