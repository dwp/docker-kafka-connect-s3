# Builds a docker image for Kafka Connect with the S3 plugin

FROM confluentinc/cp-kafka-connect-base
LABEL maintainer=matthewburgess@digital.uc.dwp.gov.uk
ENV CONFLUENT_MAJOR_VERSION=5
ENV CONFLUENT_MINOR_VERSION=0
ENV CONFLUENT_PATCH_VERSION=1
ENV CONFLUENT_DEB_VERSION=1

RUN echo "===> Installing S3 connector ..." \
    && CONFLUENT_VERSION=${CONFLUENT_MAJOR_VERSION}.${CONFLUENT_MINOR_VERSION}.${CONFLUENT_PATCH_VERSION}-${CONFLUENT_DEB_VERSION} \
    && apt-get -qq update \
    && apt-get install -y confluent-kafka-connect-s3=${CONFLUENT_VERSION} awscli \
    && echo "===> Upgrading ..."  \
    && apt-get dist-upgrade -y \
    && echo "===> Cleaning up ..."  \
    && apt-get autoremove -y \
    && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/*

CMD echo "===> Importing Config..." \
    && aws s3api get-object --bucket $CONFIG_BUCKET --key $CONFIG_OBJECT connect-s3-distributed.properties
