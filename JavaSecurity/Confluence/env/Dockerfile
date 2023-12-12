FROM openjdk:8-jdk-bullseye

COPY atlassian-confluence-6.9.0.zip /
COPY confluence.cfg.xml /var/data/confluence/confluence.cfg.xml

RUN unzip atlassian-confluence-6.9.0.zip && \ 
    mv atlassian-confluence-6.9.0 atlassian-confluence && \
    mkdir -p /var/data/confluence/ && \
    mkdir -p /var/data/clusters && \
    echo ' ' >> /atlassian-confluence/confluence/WEB-INF/classes/confluence-init.properties && \
    echo 'confluence.home=/var/data/confluence/' >> /atlassian-confluence/confluence/WEB-INF/classes/confluence-init.properties
