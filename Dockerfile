FROM centos
RUN mkdir -p /opt/kafka \
  && cd /opt/kafka \
  && yum -y install java-1.8.0-openjdk-headless tar \
  && curl -s https://www.mirrorservice.org/sites/ftp.apache.org/kafka/2.5.1/kafka_2.12-2.5.1.tgz | tar -xz --strip-components=1 \
  && yum clean all
RUN chmod -R a=u /opt/kafka
WORKDIR /opt/kafka
VOLUME /tmp/kafka-logs /tmp/zookeeper
ADD prom-jmx-agent-config.yml /opt/kafka/prom-jmx-agent-config.yml
ADD https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.13.0/jmx_prometheus_javaagent-0.13.0.jar /opt/kafka/jmx_prometheus_javaagent.jar
EXPOSE 2181 2888 3888 9092