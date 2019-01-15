# Builds a docker image for Kafka Connect with the S3 plugin

FROM confluentinc/cp-kafka-connect-base
LABEL maintainer=matthewburgess@digital.uc.dwp.gov.uk
ENV CONFLUENT_MAJOR_VERSION=5
ENV CONFLUENT_MINOR_VERSION=0
ENV CONFLUENT_PATCH_VERSION=1
ENV CONFLUENT_DEB_VERSION=1
ENV COMPONENT=kafka-connect

    RUN echo "===> Installing JDBC, Elasticsearch and S3 connector ... ..." \
        && apt-get -qq update \
        && apt-get install -y \
            confluent-kafka-connect-jdbc=${CONFLUENT_VERSION}${CONFLUENT_PLATFORM_LABEL}-${CONFLUENT_DEB_VERSION} \
            confluent-kafka-connect-hdfs=${CONFLUENT_VERSION}${CONFLUENT_PLATFORM_LABEL}-${CONFLUENT_DEB_VERSION} \
            confluent-kafka-connect-elasticsearch=${CONFLUENT_VERSION}${CONFLUENT_PLATFORM_LABEL}-${CONFLUENT_DEB_VERSION} \
            confluent-kafka-connect-storage-common=${CONFLUENT_VERSION}${CONFLUENT_PLATFORM_LABEL}-${CONFLUENT_DEB_VERSION} \
            confluent-kafka-connect-s3=${CONFLUENT_VERSION}${CONFLUENT_PLATFORM_LABEL}-${CONFLUENT_DEB_VERSION} \
            confluent-kafka-connect-jms=${CONFLUENT_VERSION}${CONFLUENT_PLATFORM_LABEL}-${CONFLUENT_DEB_VERSION} \
        && apt-get autoremove -y \
        && echo "===> Upgrading ..."  \
        && apt-get dist-upgrade -y \
        && echo "===> Cleaning up ..."  \
        && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/*
