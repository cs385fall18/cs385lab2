FROM openjdk:8-jre

ENV KAFKA_VERSION 1.0.0
ENV KAFKA_SCALA_VERSION 2.11
ENV KAFKA_ARCH "kafka_$KAFKA_SCALA_VERSION-$KAFKA_VERSION.tgz"
ENV KAFKA_HOME /opt/kafka

WORKDIR /opt

RUN git clone https://github.com/jcabmora/minibank.git
# what to do to check if things work
RUN sed -i 's/dbConn := fmt.Sprintf("minibank:minibank@tcp(localhost)/minibank")/dbConn := fmt.Sprintf("minibank:minibank@tcp(mysql)/minibank")/g' minibank/src/minibank/main.go
#RUN apt-get update
#RUN apt-get install -y jq
#RUN wget -O - $(wget -qO- https://www.apache.org/dyn/closer.cgi\?as_json\=1\&path\=/kafka/$KAFKA_VERSION/$KAFKA_ARCH | jq --raw-output '.preferred')kafka/$KAFKA_VERSION/$KAFKA_ARCH | tar zxf -
#RUN mv /opt/kafka_$KAFKA_SCALA_VERSION-$KAFKA_VERSION $KAFKA_HOME
#RUN sed -i 's/zookeeper.connect=localhost:2181/zookeeper.connect=zookeeper:2181/g' /opt/kafka/config/server.properties
#RUN sed -i 's/broker.id=0/broker.id=-1/g' /opt/kafka/config/server.properties
#RUN rm -rf /var/lib/apt/lists/*

CMD ["/opt/kafka/bin/kafka-server-start.sh", "/opt/kafka/config/server.properties"]
